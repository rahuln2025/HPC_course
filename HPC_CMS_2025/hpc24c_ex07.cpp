//First MPI program
#include <iostream>
#include "mpi.h"

int main(int argc, char** argv) {

    // Initialize the MPI environment
    MPI_Init(&argc, &argv);

    int rank, size;

    // Get the number of processes
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    // Get the rank of the process
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);


    for (int i = 0; i < size; ++i) {
        if (rank == i) {
            std::cout << "Hello world from rank " << rank << " of " << size << std::endl;
        }
        MPI_Barrier(MPI_COMM_WORLD); // Synchronize after each print
    }
    // Finalize the MPI environment
    MPI_Finalize();
    
    return 0;
}