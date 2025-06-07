// First program to run on the HPC cluster
// Use of OpenMP
#include <iostream>
#include <omp.h>

int main(int argc, char** argv) {

    // declare variables outside omp scope
    int numthreads, num;
    #pragma omp parallel private(numthreads, num)
    {
        numthreads = omp_get_num_threads();
        num = omp_get_thread_num(); 
        std::cout <<"Thread " << num << " of " << numthreads << "\n"; 
    }
    // the next should print the master thread
    std::cout <<"Thread " << num << " of " << numthreads << "\n";
    
    return 0; 
}