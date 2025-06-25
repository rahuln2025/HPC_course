#include "mpi.h"
#include <vector>
#include <random>
#include <chrono>
#include <fstream>
#include <iostream>
#include <sstream>

// define states with integer values for easy handling
enum State { SUSCEPTIBLE = 0, INFECTED = 1, RECOVERED = 2 };


int main(int argc, char** argv) {

    // Initialize MPI
    MPI_Init(&argc, &argv);
    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    // Parameters
    const int grid_size = 500; // Size of the grid
    const int steps = 1000; // Number of simulation steps
    const double p = 0.5; // probability of infection
    const double q = 0.3; // probability of recovery
    const int t = 5;     // immune period
    

    // Random number generation
    std::mt19937 rng(std::chrono::steady_clock::now().time_since_epoch().count());
    std::uniform_int_distribution<int> dist(0, grid_size - 1);
    std::uniform_real_distribution<double> prob(0.0, 1.0);


    // Initialize a few infected individuals
    int initial_infected = 5;
    
    // Randomly infect cells (done by rank 0)
    // Grid and immune period
    std::vector<std::vector<int>> full_grid(grid_size, std::vector<int>(grid_size, SUSCEPTIBLE));
    std::vector<std::vector<int>> full_immune_period(grid_size, std::vector<int>(grid_size, 0)); // possibly redundant
    if (rank == 0) {
        for (int k = 0; k < initial_infected; ++k) {
            int x = dist(rng), y = dist(rng);
            // check if the randomly chosen cell is already infected
            while (full_grid[x][y] != SUSCEPTIBLE) {
                x = dist(rng); y = dist(rng);
            }
            // Set the randomly chosen cell to infected state
            full_grid[x][y] = INFECTED;
        }
    }

    // Compute local rows for each rank
    // Divide grid horizontally
    int rows_per_rank = grid_size / size;
    int extra = grid_size % size; // extra to distribute if grid_size is not divisible by size
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


   // Local grid and immune period
    // Track local grid state & immune period for the grid cells for each rank
    std::vector<std::vector<int>> local_grid(local_rows, std::vector<int>(grid_size, SUSCEPTIBLE));
                                //grid(n_rows, each row has a vector of grid_size elements, each initialized to SUSCEPTIBLE state) 
    std::vector<std::vector<int>> local_immune_period(local_rows, std::vector<int>(grid_size, 0));
                                //immune_period(n_rows, each row has a vector of grid_size elements, each initialized to 0)


    // Output matrix only on root
    std::vector<std::vector<int>> output_matrix;

    // Distribute the grid to all ranks
    std::vector<int> sendcounts(size), displs(size); // vectors as placeholders
    int start = 0;
    for (int i = 0; i < size; i++) {
        int rows; // number of rows to send to a rank
        if (i < extra) {
            rows = rows_per_rank + 1;
        } else {
            rows = rows_per_rank;
        }
        // Number of elements to send to each rank: n_rows * grid_size
        sendcounts[i] = rows * grid_size;
        // Positions in the flat buffer where each rank's data starts
        // displacements: offset for each rank
        displs[i] = start;
        // update start for the next rank
        start = start + sendcounts[i];
    }
    // Flatten full grid
    std::vector<int> flat_full_grid; // all ranks should know the flat full grid
    if (rank == 0) {
        for (int i = 0; i < grid_size; i++)
            for (int j = 0; j < grid_size; j++)
                            // push_back ~ append in Python
                flat_full_grid.push_back(full_grid[i][j]); // only rank 0 has the full grid
    }

    std::vector<int> flat_local_grid(local_rows * grid_size);
    MPI_Scatterv(flat_full_grid.data(), sendcounts.data(), displs.data(), MPI_INT,
                 flat_local_grid.data(), flat_local_grid.size(), MPI_INT, 0, MPI_COMM_WORLD);
    // MPI_Scatterv(buffer, sendcounts, displacements, datatype, recv_buffer, recv_count, datatype, sending rank, communicator)
    // Now all ranks have their local (flattend) grid distrubuted from fuat_full_grid owned by rank 0.


    // Reconstruct local grid from flat
    for (int i = 0; i < local_rows; i++)
        for (int j = 0; j < grid_size; j++)
            local_grid[i][j] = flat_local_grid[i * grid_size + j];

  
    // Main simulation setup
    // Directions for neighbor checking
    std::vector<std::vector<int>> directions = {{-1,0},{1,0},{0,-1},{0,1}}; // Up, Down, Left, Right


    // Simulation loop
    for (int step = 0; step < steps; ++step) {

        // Gather local grids to the root rank
        for (int i = 0; i< local_rows; ++i){
            for (int j = 0; j < grid_size; ++j){
                flat_local_grid[i * grid_size + j] = local_grid[i][j];
            }
        }
        // Gather local grids to the root rank
        std::vector<int> flat_gathered_grid(grid_size * grid_size); // buffer to gather all local grids
        MPI_Gatherv(flat_local_grid.data(), flat_local_grid.size(), MPI_INT, 
                    flat_gathered_grid.data(), sendcounts.data(), displs.data(), MPI_INT, 0, MPI_COMM_WORLD);
                   // *sendbuf, int sendcount, MPI Datatype sendtype, 
                   // *recvbuf, int recvcount, int displs, MPI Datatype recvtype, root, MPI_Comm comm)
    
        if (rank == 0) {
            output_matrix.push_back(flat_gathered_grid);
        }

        // define a new local grid for the next step
        // std::vector<int> new_local_grid(local_rows * grid_size, SUSCEPTIBLE);
        // std::vector<int> new_local_immune_period(local_rows * grid_size, 0);
        auto new_local_grid = local_grid; // copy current local grid to new local grid
        auto new_local_immune_period = local_immune_period; // copy current immune period to new immune period


        // Exchange boundary rows with neighboring ranks
        std::vector<int> top_row(grid_size), bottom_row(grid_size); // buffers for sending top and bottom rows
        std::vector<int> recv_top(grid_size), recv_bottom(grid_size); // buffers for receiving rows from top and bottom neighbors
                       // receiving from top neighbor's bottom row, receiving from bottom neighbor's top row
        if (local_rows > 0) {
            // Send top row to previous rank & receive bottom row from previous rank
            if (rank > 0)  // rank 0 is the first one, and it does not have a top row it receives from prev. rank
            {
                // for rach rank's local indexing
                for (int j = 0; j < grid_size; ++j) {
                    top_row[j] = local_grid[0][j];
                }
                MPI_Sendrecv(top_row.data(), grid_size, MPI_INT, rank - 1, 0,
                             recv_top.data(), grid_size, MPI_INT, rank - 1, 0,
                             MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                //}
        }
            if (rank < size - 1) { // rank size - 1 is the last one, and it does not have a bottom row to send to next rank
                for (int j = 0; j < grid_size; ++j) {
                    bottom_row[j] = local_grid[local_rows - 1][j];
                }
                MPI_Sendrecv(bottom_row.data(), grid_size, MPI_INT, rank + 1, 0,
                             recv_bottom.data(), grid_size, MPI_INT, rank + 1, 0,
                             MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                //}
            }
        }

 
       for (int i = 0; i < local_rows; i++) {
            for (int j = 0; j < grid_size; j++) {
                if (local_grid[i][j] == INFECTED) {
                    for (int d = 0; d < 4; d++) {
                        int ni = i + directions[d][0];
                        int nj = j + directions[d][1];
                        int neighbor_val = -1;
                        // Check if neighbor is within local grid interior
                        if (ni >= 0 && ni < local_rows && nj >= 0 && nj < grid_size) {
                            neighbor_val = local_grid[ni][nj];
                        } 
                        // handle top rows of local grid
                        // not applicable for rank 0 as it dows not have a top neighbor
                        else if (ni == -1 && rank > 0 && nj >= 0 && nj < grid_size) {
                            neighbor_val = recv_top[nj];
                        } 
                        // handle bottom rows of local grid
                        // not applicable for the last rank as it does not have a bottom neighbor
                        else if (ni == local_rows && rank < size - 1 && nj >= 0 && nj < grid_size) {
                            neighbor_val = recv_bottom[nj];
                        }
                        if (neighbor_val == SUSCEPTIBLE && prob(rng) < p) {
                            if (ni >= 0 && ni < local_rows && nj >= 0 && nj < grid_size) {
                                new_local_grid[ni][nj] = INFECTED;
                            }
                            // Ghost rows are not updated, but infection will propagate next step
                        }
                    }
                    // Attempt to recover
                    if (prob(rng) < q) {
                        new_local_grid[i][j] = RECOVERED;
                        new_local_immune_period[i][j] = t;
                    }
                } else if (local_grid[i][j] == RECOVERED) {
                    new_local_immune_period[i][j] -= 1;
                    if (new_local_immune_period[i][j] <= 0) {
                        new_local_grid[i][j] = SUSCEPTIBLE;
                    }
                }
            }
        }
        local_grid = new_local_grid;
        local_immune_period = new_local_immune_period;
    }


    // Save output_matrix to a .txt file (only root)

    if (rank == 0) {
        std::string output_file = "MPI_v0_500_1000_output.txt"; // output file name
        std::ofstream outfile(output_file);
        for (const auto& row : output_matrix) {
            for (size_t i = 0; i < row.size(); i++) {
                outfile << row[i];
                if (i < row.size() - 1) outfile << " ";
            }
            outfile << "\n";
        }
        outfile.close();
        std::cout << "Simulation complete. Output saved to "<< output_file <<"\n";
    }

    // Finalize MPI
    MPI_Finalize(); 

    return 0;
}
