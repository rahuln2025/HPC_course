// OpenMP Exercise 5a: Monte Carlo Pi Estimation
// New random number generation engine with modified parallelization

#include <iostream>
#include <cstdlib>  // For rand()
#include <ctime>    // For seeding rand()
#include <chrono> 
#include <string>
#include <random>
#include <omp.h>

int main(int argc, char** argv) {

	unsigned long simulations_input;
    // Check if the user provided an argument for simulations
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <#simulations>\n";
        simulations_input = 10;
    } else {
      try {
        std::string arg = argv[1];
        // Check if the input string is negative
        if (arg[0] == '-' || arg[0] == '0') {
            throw std::invalid_argument("#simulations size cannot be negative.");
        }
        // Convert the string to an unsigned long
        simulations_input = std::stoul(argv[1]);
      } catch (const std::invalid_argument& e) {
          std::cerr << "Invalid input. Please enter a valid unsigned number.\n" ;
          return 1;
      } catch (const std::out_of_range& e) {
          std::cerr << "Input is out of range for an unsigned long.\n";
          return 1;
      }
    }
    
    const unsigned long simulations = static_cast<unsigned long>(simulations_input);
    std::cout << "#simulations: N = " << simulations << "\n";

    //double x, y;
    unsigned long hit = 0;


    // Seed the random number generator with the time
    //std::srand(static_cast<unsigned>(std::time(0)));

    auto t_start = std::chrono::high_resolution_clock::now();
    
    #pragma omp parallel
    {
        // New random engine and distribution create per thread
        // This ensures each thread has its own random number generator
        // These generators are used in all iterations of the loop

        int num = omp_get_thread_num();
        std::mt19937 gen(std::time(0) + num); // Unique seed per thread
        std::uniform_real_distribution<> dis(0.0, 1.0);

        #pragma omp parallel for reduction(+:hit) // reduction directive to sum hits across threads
        for (unsigned long i = 0; i < simulations; i++) {
            double x = dis(gen);
            double y = dis(gen);
            if ((x * x + y * y) <= 1) {
                hit++;
            }
        }
    }
    
    auto t_end = std::chrono::high_resolution_clock::now();

    std::chrono::duration<double> t_duration = t_end - t_start;
    std::cout << "Computation took: " << t_duration.count() << " seconds.\n";
    std::cout << "Pi = " << (4.0 * hit) / simulations << "\n";
    
    return 0;
}
