#include "mpi.h"
#include <stdio.h>

int main(int argc, char **argv)
{
	int rank, size, err, n, sum;
	MPI_Init(&argc, &argv);

	MPI_Comm_size(MPI_COMM_WORLD, &size);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);

	printf("rank=%d size=%d\n", rank, size);

	n = rank + 1;
	sum = 4710;

	MPI_Barrier(MPI_COMM_WORLD);

	MPI_Reduce(&n, &sum, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
	printf("At rank=%d	Recevied in reduction=%d\n", rank,  sum);

	MPI_Barrier(MPI_COMM_WORLD);

	sum = 3710;
	MPI_Allreduce(&n, &sum, 1, MPI_INT, MPI_SUM, MPI_COMM_WORLD);
	printf("At rank=%d	Received in allreduction = %d\n", rank, sum);

	MPI_Finalize();
	return 0;

}
