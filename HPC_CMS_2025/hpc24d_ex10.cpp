// MPI Broadcast Example
#include <iostream>
#include "mpi.h"

int main(int argc, char **argv)
{
    int rank, size;
    MPI_Init(&argc, &argv);

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    std::cout << "Hello from rank " << rank << "! (size " <<size<< ")\n";
    
    MPI_Barrier(MPI_COMM_WORLD);

    int n = (rank + 1)*4711;
    MPI_Bcast(&n, 1, MPI_INT, 0, MPI_COMM_WORLD);
            //*buf, count, datatype, root (or sending rank), communicator
    
    std::cout << "\nrank" << rank << ": Received = " << n << "\n";

    MPI_Finalize();

    return 0;

}