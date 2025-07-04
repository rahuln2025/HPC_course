#include <iostream>
#include <vector>
#include <random>
#include <chrono>
#include <fstream>
//#include "mpi.h"

enum State { SUSCEPTIBLE = 0, INFECTED = 2, RECOVERED = 1 };

int main() {
    // Parameters
    const int grid_size = 10;
    const int steps = 30;
    const double p = 0.2; // probability of infection
    const double q = 0.3; // probability of recovery
    const int t = 10;     // immune period

    // Random number generation
    std::mt19937 rng(std::chrono::steady_clock::now().time_since_epoch().count());
    std::uniform_int_distribution<int> dist(0, grid_size - 1);
    std::uniform_real_distribution<double> prob(0.0, 1.0);

    // Grid and immune period
    std::vector<std::vector<int>> grid(grid_size, std::vector<int>(grid_size, SUSCEPTIBLE));
    std::vector<std::vector<int>> immune_period(grid_size, std::vector<int>(grid_size, 0));

    // Output matrix: steps x (grid_size*grid_size)
    std::vector<std::vector<int>> output_matrix;

    // Initialize a few infected individuals
    int initial_infected = 5;
    for (int k = 0; k < initial_infected; ++k) {
        int x = dist(rng), y = dist(rng);
        while (grid[x][y] != SUSCEPTIBLE) {
            x = dist(rng); y = dist(rng);
        }
        grid[x][y] = INFECTED;
    }

    // Directions for neighbor checking
    std::vector<std::pair<int, int>> directions = {{-1,0},{1,0},{0,-1},{0,1}};

    for (int step = 0; step < steps; ++step) {
        // Store current grid state in output_matrix (flattened)
        std::vector<int> flat_grid;
        for (int i = 0; i < grid_size; ++i)
            for (int j = 0; j < grid_size; ++j)
                flat_grid.push_back(grid[i][j]);
        output_matrix.push_back(flat_grid);

        // Copy grid for simultaneous updates
        auto new_grid = grid;
        auto new_immune = immune_period;

        for (int i = 0; i < grid_size; ++i) {
            for (int j = 0; j < grid_size; ++j) {
                if (grid[i][j] == INFECTED) {
                    // Infect neighbors
                    for (const auto& dir : directions) {
                        int dx = dir.first;
                        int dy = dir.second;
                        int ni = i + dx, nj = j + dy;
                        if (ni >= 0 && ni < grid_size && nj >= 0 && nj < grid_size) {
                            if (grid[ni][nj] == SUSCEPTIBLE && prob(rng) < p && immune_period[ni][nj] < t) {
                                new_grid[ni][nj] = INFECTED;
                            }
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

    // Save output_matrix to a .txt file
    std::ofstream outfile("sir_output.csv");
    for (const auto& row : output_matrix) {
        for (size_t i = 0; i < row.size(); ++i) {
            outfile << row[i];
            if (i < row.size() - 1) outfile << " ";
        }
        outfile << "\n";
    }
    outfile.close();

    std::cout << "Simulation complete. Output saved to sir_output.csv\n";
    return 0;
}