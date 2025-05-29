#include "mpi.h"
#include <stdio.h>
//#include <cmath>

int main(int argc, char **argv)
{
	int rank, size;
	double dx, x, pi, d_pi, pi_val;

	MPI_Init(&argc, &argv);

	MPI_Comm_size(MPI_COMM_WORLD, &size);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	
	int div = size - 1;
	printf("div = %d\n", div); 
	
	dx = 1.0/div;
	pi = 0;
	x = (rank)*dx;
	d_pi = 0.5*dx*(1/(1 + x*x)+ (1/(1 + (x + dx)*(x+ dx))));
	
	//MPI_Barrier(MPI_COMM_WORLD);
	printf("rank=%d size=%d dx=%f x=%f d_pi=%f pi=%f\n", rank, size, dx, x, d_pi, pi);

	MPI_Reduce(&d_pi, &pi, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
	
	
	MPI_Barrier(MPI_COMM_WORLD);
	
	if (rank == 0)
		{
		pi_val = 4*pi;
		printf("At rank = %d	Value of pi = %f\n", rank, pi_val);
		}

	

	MPI_Finalize();
	return 0;

}
