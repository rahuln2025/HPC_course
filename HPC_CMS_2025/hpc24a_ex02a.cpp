// First program to run on the HPC cluster
// Use of OpenMP
#include <iostream>
#include <omp.h>

int main(int argc, char** argv) {

    #pragma omp parallel
    {
        // declare variables
        int numthreads, num;
        //get number of threads 
        numthreads = omp_get_num_threads();
        // get thread number 
        num = omp_get_thread_num(); 
        // print thread number and total threads
        std::cout <<"Thread " << num << " of " << numthreads << "\n"; 
    }
    // end of main function and returns 0 (thus, the int in function definition)
    return 0; 
}