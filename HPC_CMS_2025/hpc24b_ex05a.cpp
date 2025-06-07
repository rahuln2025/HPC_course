// OpemMP Exercise 5a: Monte Carlo Pi Estimation

#include <iostream>
#include <cstdlib>  // For rand()
#include <ctime>    // For seeding rand()
#include <chrono> 
#include <string>
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

    double x, y;
    unsigned long hit = 0;

    // Seed the random number generator with the time
    std::srand(static_cast<unsigned>(std::time(0)));

    auto t_start = std::chrono::high_resolution_clock::now();
    
    #pragma omp parallel for reduction(+:hit) private(x, y)
    for (unsigned long i = 0; i < simulations; i++) {
      x = static_cast<double>(std::rand()) / RAND_MAX;
      y = static_cast<double>(std::rand()) / RAND_MAX;
      
      if ((x * x + y * y) <= 1) {
          hit++;
      }
    }
    auto t_end = std::chrono::high_resolution_clock::now();

    std::chrono::duration<double> t_duration = t_end - t_start;
    std::cout << "Computation took: " << t_duration.count() << " seconds.\n";
    std::cout << "Pi = " << (4.0 * hit) / simulations << "\n";
    
    return 0;
}
