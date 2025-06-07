// Program to perform matrix multiplication using OpenMP
#include <iostream>
#include <vector> // class for dynamic arrays
#include <omp.h>
#include <string> // for string manipulation
#include <chrono> // for timing

// Matrix initialization function
void initialize_matrices( const unsigned long N, 
                          std::vector<double> &a,  
                          std::vector<double> &b, 
                          std::vector<double> &c)
{
    unsigned long i,j;

    #pragma omp parallel for private(i,j)
    for (i = 0; i < N; ++i) {
        for (j = 0; j < N; ++j) {
            a[i * N + j] = i + j + 1.0;
            b[i * N + j] = 1.0 / (i + j + 1);
            c[i * N + j] = 0;
        }
    }
}

// Matrix multiplication function
void multiply_matrices( const unsigned long N, 
                        const std::vector<double> &a, 
                        const std::vector<double> &b, 
                        std::vector<double> &c)
{
    unsigned long i, j, k;

    #pragma omp parallel for private(i, j, k)
    for (i = 0; i < N; ++i) {
        for (j = 0; j < N; ++j) {
            c[i * N + j] = 0;
            for (k = 0; k < N; ++k) {
                c[i * N + j] += a[i * N + k] * b[k * N + j];
            }
        }
    }
}

// Print function
void print(const unsigned long N, const std::vector<double> &a)
{
    unsigned long i,j;
    for (i = 0; i < N; ++i) {
        for (j = 0; j < N; ++j) {
            std::cout << " " << a[i * N + j];
        }
        std::cout << "\n";
    }
    std::cout << "\n";
}

// Timing functions
// `using` directive for easier access to chrono types
// it creates type aliases for the clock and time point
// in Python words, it is like `from datetime import datetime as dt`

using Clock = std::chrono::high_resolution_clock;
using TimePoint = std::chrono::time_point<Clock>;

TimePoint timeit() {
    // Returns the current time point
    return Clock::now();
}

double elapsed_time(TimePoint start, TimePoint end) {
    // Calculates the elapsed time between two time points
    if (start > end) {
        std::cerr << "Error: start time is after end time.\n";
        return -1.0; // Return a negative value to indicate an error
    }
    std::chrono::duration<double> duration = end - start;
    return duration.count();
}


int main(int argc, char** argv)
{
    unsigned long n_input;
    // Check if the user provided an argument for N
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <matrix_size>\n";
        n_input = 10;
    } else {
      try {
        std::string arg = argv[1];
        // Check if the input string is negative
        if (arg[0] == '-' || arg[0] == '0') {
            throw std::invalid_argument("Matrix size cannot be negative.");
        }
        // Convert the string to an unsigned long
        n_input = std::stoul(argv[1]);
      } catch (const std::invalid_argument& e) {
          std::cerr << "Invalid input. Please enter a valid unsigned number.\n" ;
          return 1;
      } catch (const std::out_of_range& e) {
          std::cerr << "Input is out of range for an unsigned long.\n";
          return 1;
      }
    }
    
    // Vectors to store the matrices a, b, and c

    const unsigned long N = static_cast<unsigned long>(n_input);
    std::cout << "Matrix size: N = " << N << "\n";

    std::vector<double> a(N * N);
    std::vector<double> b(N * N);
    std::vector<double> c(N * N, 0);  // Initialize c with zeros

    // Print the number of threads used by OpenMP
    #pragma omp parallel
    {
        int numthreads = omp_get_num_threads();
        int num = omp_get_thread_num();
        #pragma omp critical // Ensures unscrambled output
        std::cout << "Thread " << num << " of " << numthreads << std::endl;
    }

    // Initialize matrices a and b
    TimePoint t_start, t_end;
    t_start = timeit();
    initialize_matrices(N, a, b, c); // the function is parallelized
    t_end = timeit();
    std::cout << "Matrix initialization took " << elapsed_time(t_start, t_end) << " seconds.\n";
    
    // Perform matrix multiplication

    t_start = timeit();
    multiply_matrices(N, a, b, c); // the function is parallelized
    t_end = timeit();
    std::cout << "Matrix multiplication took " << elapsed_time(t_start, t_end) << " seconds.\n";

    // Print matrices if N is small
    #pragma omp master // Only the master thread prints the matrices
    {
        if (N < 20) {
            print(N, a);
            print(N, b);
            print(N, c);
        } else {
            std::cout << "N too big for printed output.\n";
        }
    }

    return 0;
}

