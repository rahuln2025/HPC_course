#include "mpi.h"
#include <stdio.h>

int main(int argc, char **argv)
{

	int rank, size, err, n;
	MPI_Init(&argc, &argv);
	
	MPI_Comm_size(MPI_COMM_WORLD, &size);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);

	printf("rank=%d size=%d\n", rank, size);

	err=MPI_Barrier(MPI_COMM_WORLD);

	n = (rank + 1) * 4711;
	err=MPI_Bcast(&n, 1, MPI_INT, 0, MPI_COMM_WORLD);
	printf("	Received = %d\n", n);
	MPI_Finalize();
	return 0;

}


