#include <iostream>
#include <vector>
#include <random>
#include <chrono>
#include <fstream> // for saving results in output file
#include "mpi.h"

enum State { SUSCEPTIBLE = 0, INFECTED = 2, RECOVERED = 1 };

int main(int argc, char** argv) {
    MPI_Init(&argc, &argv);

    // world size and rank: for overall grid
    int world_size, rank;
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    const int grid_size = 500;
    const int steps = 100;
    const double p = 0.5; // Infection probability
    const double q = 0.3; // Recovery probability
    const int t = 5;

    // Divide grid horizontally
    int rows_per_rank = grid_size / world_size;
    int extra = grid_size % world_size; // extra to distribute if grid_size is not divisible by world_size
    // Calculate number of local rows for each rank
    // Each rank gets rows_per_rank rows, plus one extra row if it is one of the first 'extra' ranks
    int local_rows;
    if (rank < extra) {
        local_rows = rows_per_rank + 1;
    } else {
        local_rows = rows_per_rank;
    }
    // Starting row index for each rank
    int row_start = rank * rows_per_rank + std::min(rank, extra);

    // Random number generation
    std::mt19937 rng(std::chrono::steady_clock::now().time_since_epoch().count() + rank);
    std::uniform_int_distribution<int> dist(0, grid_size - 1); // sample random grid indices from uniform distribution
    std::uniform_real_distribution<double> prob(0.0, 1.0); // sample random probabilities from uniform distribution

    // Local grid and immune period
    // Track local grid state & immune period for the grid cells for each rank
    std::vector<std::vector<int>> grid(local_rows, std::vector<int>(grid_size, SUSCEPTIBLE));
                                //grid(n_rows, each row has a vector of grid_size elements, each initialized to SUSCEPTIBLE state) 
    std::vector<std::vector<int>> immune_period(local_rows, std::vector<int>(grid_size, 0));
                                //immune_period(n_rows, each row has a vector of grid_size elements, each initialized to 0)

    // Output matrix only on root
    std::vector<std::vector<int>> output_matrix;

    // Initialize a few infected individuals (only on root, then scatter between ranks)
    std::vector<std::vector<int>> full_grid;
    // only rank 0 initializes the full grid
    if (rank == 0) {
        full_grid.resize(grid_size, std::vector<int>(grid_size, SUSCEPTIBLE));
        int initial_infected = 5; // Number of initially infected cells
        for (int k = 0; k < initial_infected; ++k) {
            int x = dist(rng), y = dist(rng);
            // check if the randomly chosen cell is already infected
            while (full_grid[x][y] != SUSCEPTIBLE) {
                x = dist(rng); y = dist(rng);
            }
            full_grid[x][y] = INFECTED;
        }
    }

    // Scatter the grid to all ranks
    // Flatten for MPI
    std::vector<int> sendcounts(world_size), displs(world_size);
    int offset = 0;
    for (int i = 0; i < world_size; ++i) {
        int rows = rows_per_rank + (i < extra ? 1 : 0);
        sendcounts[i] = rows * grid_size;
        displs[i] = offset;
        offset += sendcounts[i];
    }
    std::vector<int> flat_full_grid;
    if (rank == 0) {
        for (int i = 0; i < grid_size; ++i)
            for (int j = 0; j < grid_size; ++j)
                flat_full_grid.push_back(full_grid[i][j]);
    }
    std::vector<int> flat_local_grid(local_rows * grid_size);
    MPI_Scatterv(flat_full_grid.data(), sendcounts.data(), displs.data(), MPI_INT,
                 flat_local_grid.data(), flat_local_grid.size(), MPI_INT, 0, MPI_COMM_WORLD);
    // Fill local grid from flat
    for (int i = 0; i < local_rows; ++i)
        for (int j = 0; j < grid_size; ++j)
            grid[i][j] = flat_local_grid[i * grid_size + j];

    // Directions for neighbor checking
    std::vector<std::vector<int>> directions = {{-1,0},{1,0},{0,-1},{0,1}};

    for (int step = 0; step < steps; ++step) {
        // Gather full grid for output (optional, only root)
        std::vector<int> flat_gathered_grid;
        if (rank == 0) flat_gathered_grid.resize(grid_size * grid_size);
        for (int i = 0; i < local_rows; ++i)
            for (int j = 0; j < grid_size; ++j)
                flat_local_grid[i * grid_size + j] = grid[i][j];
        MPI_Gatherv(flat_local_grid.data(), flat_local_grid.size(), MPI_INT,
                    flat_gathered_grid.data(), sendcounts.data(), displs.data(), MPI_INT,
                    0, MPI_COMM_WORLD);
        if (rank == 0) {
            output_matrix.push_back(flat_gathered_grid);
        }

        // Prepare new grid for updates
        auto new_grid = grid;
        auto new_immune = immune_period;

        // Exchange boundary rows with neighbors
        std::vector<int> top_row(grid_size), bottom_row(grid_size);
        std::vector<int> recv_top(grid_size), recv_bottom(grid_size);
        if (local_rows > 0) {
            // Send top row to previous rank, receive bottom ghost row from previous
            if (rank > 0) {
                for (int j = 0; j < grid_size; ++j) top_row[j] = grid[0][j];
                MPI_Sendrecv(top_row.data(), grid_size, MPI_INT, rank - 1, 0,
                             recv_top.data(), grid_size, MPI_INT, rank - 1, 1,
                             MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            }
            // Send bottom row to next rank, receive top ghost row from next
            if (rank < world_size - 1) {
                for (int j = 0; j < grid_size; ++j) bottom_row[j] = grid[local_rows - 1][j];
                MPI_Sendrecv(bottom_row.data(), grid_size, MPI_INT, rank + 1, 1,
                             recv_bottom.data(), grid_size, MPI_INT, rank + 1, 0,
                             MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            }
        }

        for (int i = 0; i < local_rows; ++i) {
            for (int j = 0; j < grid_size; ++j) {
                if (grid[i][j] == INFECTED) {
                    for (int d = 0; d < directions.size(); d++) {
                        int ni = i + directions[d][0];
                        int nj = j + directions[d][1];
                        int neighbor_val = -1;
                        // Check if neighbor is within local grid
                        if (ni >= 0 && ni < local_rows && nj >= 0 && nj < grid_size) {
                            neighbor_val = grid[ni][nj];
                        } else if (ni == -1 && rank > 0 && nj >= 0 && nj < grid_size) {
                            neighbor_val = recv_top[nj];
                        } else if (ni == local_rows && rank < world_size - 1 && nj >= 0 && nj < grid_size) {
                            neighbor_val = recv_bottom[nj];
                        }
                        if (neighbor_val == SUSCEPTIBLE && prob(rng) < p) {
                            if (ni >= 0 && ni < local_rows && nj >= 0 && nj < grid_size) {
                                new_grid[ni][nj] = INFECTED;
                            }
                            // Ghost rows are not updated, but infection will propagate next step
                        }
                    }
                    // Attempt to recover
                    if (prob(rng) < q) {
                        new_grid[i][j] = RECOVERED;
                        new_immune[i][j] = t;
                    }
                } else if (grid[i][j] == RECOVERED) {
                    new_immune[i][j] -= 1;
                    if (new_immune[i][j] <= 0) {
                        new_grid[i][j] = SUSCEPTIBLE;
                    }
                }
            }
        }
        grid = new_grid;
        immune_period = new_immune;
    }

    // Save output_matrix to a .txt file (only root)
    if (rank == 0) {
        std::ofstream outfile("sir_MPI_output.txt");
        for (const auto& row : output_matrix) {
            for (size_t i = 0; i < row.size(); ++i) {
                outfile << row[i];
                if (i < row.size() - 1) outfile << " ";
            }
            outfile << "\n";
        }
        outfile.close();
        std::cout << "Simulation complete. Output saved to sir_MPI_output.txt\n";
    }

    MPI_Finalize();
    return 0;
}