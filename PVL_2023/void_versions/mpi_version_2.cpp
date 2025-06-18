#include "mpi.h"
#include <vector>
#include <random>
#include <chrono>
#include <fstream>
#include <iostream>
#include <sstream>

// define states with integer values for easy handling
enum State { SUSCEPTIBLE = 0, INFECTED = 1, RECOVERED = 2 };

// State = {
//     'SUSCEPTIBLE': 0,
//     'INFECTED': 1,
//     'RECOVERED': 2
// }

// struct Cell {
//     State state;
//     int immunity_timer;
// };

// class Cell to track cells state and immunity
class Cell {
public:
    State state;
    int immunity_timer;
};

// Parameters
const int GRID_SIZE = 50;
const int STEPS = 100;
const double P_INFECT = 0.2;
const double P_RECOVER = 0.3;
const int IMMUNITY_DURATION = 10;
const int INITIAL_INFECTED = 5;
const int SAVE_INTERVAL = 10; // Save every 10 steps

// Generate output file name
std::string filename(int step) {
    std::ostringstream oss;
    oss << "mpi_grid_step_" << step << ".txt";
    return oss.str();
}

// Save full grid (to be called only by rank 0)
void save_full_grid(const std::vector<std::vector<Cell>>& full_grid, int step) {
    std::ofstream out(filename(step));
    for (const auto& row : full_grid) {
        for (const auto& cell : row) {
            out << static_cast<int>(cell.state) << " ";
        }
        out << "\n";
    }
    out.close();
}

int main(int argc, char** argv) {
    MPI_Init(&argc, &argv);

    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    // Check if GRID_SIZE is divisible by num of MPI processes
    if (GRID_SIZE % size != 0) {
        if (rank == 0) std::cerr << "GRID_SIZE must be divisible by size!\n";
        MPI_Finalize();
        return 1;
    }

    int local_rows = GRID_SIZE / size;
    int extended_rows = local_rows + 2; // +2 for ghost rows (top and bottom)
    using Grid = std::vector<std::vector<Cell>>;
    Grid grid(extended_rows, std::vector<Cell>(GRID_SIZE, {SUSCEPTIBLE, 0}));
    Grid new_grid = grid;

    // Random number generator
    std::mt19937 rng(std::chrono::steady_clock::now().time_since_epoch().count() + rank);
    std::uniform_real_distribution<double> dist(0.0, 1.0);

    // Infect random cells (only root process)
    if (rank == 0) {
        std::vector<std::pair<int, int>> infected_cells;
        for (int k = 0; k < INITIAL_INFECTED; ++k) {
            int i = rng() % GRID_SIZE;
            int j = rng() % GRID_SIZE;
            infected_cells.emplace_back(i, j);
        }

        // Broadcast infected indices
        for (auto& [i, j] : infected_cells) {
            int owner_rank = i / local_rows;
            if (owner_rank == 0) {
                int local_i = i % local_rows + 1;
                grid[local_i][j].state = INFECTED;
            } else {
                MPI_Send(&i, 1, MPI_INT, owner_rank, 0, MPI_COMM_WORLD);
                MPI_Send(&j, 1, MPI_INT, owner_rank, 1, MPI_COMM_WORLD);
            }
        }

        // Send terminator
        for (int r = 1; r < size; ++r) {
            int term = -1;
            MPI_Send(&term, 1, MPI_INT, r, 0, MPI_COMM_WORLD);
        }

    } else {
        while (true) {
            int i, j;
            MPI_Recv(&i, 1, MPI_INT, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            if (i == -1) break;
            MPI_Recv(&j, 1, MPI_INT, 0, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            int local_i = i % local_rows + 1;
            grid[local_i][j].state = INFECTED;
        }
    }

    std::vector<std::pair<int, int>> directions = {{-1,0}, {1,0}, {0,-1}, {0,1}};

    // Main loop
    for (int step = 0; step < STEPS; ++step) {
        // Send/Recv ghost rows
        MPI_Sendrecv(&grid[1][0], GRID_SIZE * sizeof(Cell), MPI_BYTE,
                     (rank - 1 + size) % size, 0,
                     &grid[0][0], GRID_SIZE * sizeof(Cell), MPI_BYTE,
                     (rank - 1 + size) % size, 1,
                     MPI_COMM_WORLD, MPI_STATUS_IGNORE);

        MPI_Sendrecv(&grid[local_rows][0], GRID_SIZE * sizeof(Cell), MPI_BYTE,
                     (rank + 1) % size, 1,
                     &grid[local_rows + 1][0], GRID_SIZE * sizeof(Cell), MPI_BYTE,
                     (rank + 1) % size, 0,
                     MPI_COMM_WORLD, MPI_STATUS_IGNORE);

        // Apply infection/recovery rules
        for (int i = 1; i <= local_rows; ++i) {
            for (int j = 0; j < GRID_SIZE; ++j) {
                Cell& cell = grid[i][j];
                Cell& next_cell = new_grid[i][j] = cell;

                if (cell.state == SUSCEPTIBLE) {
                    for (auto [di, dj] : directions) {
                        int ni = i + di, nj = j + dj;
                        if (ni >= 0 && ni < extended_rows && nj >= 0 && nj < GRID_SIZE) {
                            if (grid[ni][nj].state == INFECTED && dist(rng) < P_INFECT) {
                                next_cell.state = INFECTED;
                                break;
                            }
                        }
                    }
                } else if (cell.state == INFECTED) {
                    if (dist(rng) < P_RECOVER) {
                        next_cell.state = RECOVERED;
                        next_cell.immunity_timer = IMMUNITY_DURATION;
                    }
                } else if (cell.state == RECOVERED) {
                    next_cell.immunity_timer--;
                    if (next_cell.immunity_timer <= 0) {
                        next_cell.state = SUSCEPTIBLE;
                        next_cell.immunity_timer = 0;
                    }
                }
            }
        }

        grid.swap(new_grid);

        // Gather full grid to rank 0
        if (step % SAVE_INTERVAL == 0 || step == STEPS - 1) {
            std::vector<Cell> local_data;
            for (int i = 1; i <= local_rows; ++i)
                for (int j = 0; j < GRID_SIZE; ++j)
                    local_data.push_back(grid[i][j]);

            std::vector<Cell> full_data;
            if (rank == 0)
                full_data.resize(GRID_SIZE * GRID_SIZE);

            MPI_Gather(local_data.data(), local_rows * GRID_SIZE * sizeof(Cell), MPI_BYTE,
                       full_data.data(), local_rows * GRID_SIZE * sizeof(Cell), MPI_BYTE,
                       0, MPI_COMM_WORLD);

            if (rank == 0) {
                std::vector<std::vector<Cell>> full_grid(GRID_SIZE, std::vector<Cell>(GRID_SIZE));
                for (int i = 0; i < GRID_SIZE * GRID_SIZE; ++i) {
                    int row = i / GRID_SIZE;
                    int col = i % GRID_SIZE;
                    full_grid[row][col] = full_data[i];
                }
                save_full_grid(full_grid, step);
                std::cout << "Saved step " << step << std::endl;
            }
        }
    }

    MPI_Finalize();
    return 0;
}
