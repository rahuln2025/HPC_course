#include "mpi.h"
#include <stdio.h>

int main(int argc, char **argv) {
    int rank, size;
    double message = 0.0;
    int iterations = 50;
    double start_time, end_time, total_time, single_message_time;

    // Initialize MPI
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    // start timing
    MPI_Barrier(MPI_COMM_WORLD);
    start_time = MPI_Wtime();

    for (int i = 0; i < iterations; i++) {
        if (rank == 0) {
            // Rank 0 sends the message to rank 1
            MPI_Send(&message, 1, MPI_DOUBLE, 1, 0, MPI_COMM_WORLD);
            // Rank 0 receives the message back from rank 1
            MPI_Recv(&message, 1, MPI_DOUBLE, 1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        } else if (rank == 1) {
            // Rank 1 receives the message from rank 0
            MPI_Recv(&message, 1, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            // Rank 1 sends the message back to rank 0
            MPI_Send(&message, 1, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD);
        }
    }

    // stop timing
    MPI_Barrier(MPI_COMM_WORLD);
    end_time = MPI_Wtime();

    if (rank == 0) {
        // total time and time per message
        total_time = end_time - start_time;
        single_message_time = (total_time / (2 * iterations)) * 1e3;
        printf("Total time: %f seconds\n", total_time);
        printf("Time per message: %f milliseconds\n", single_message_time);
    }

    // end
    MPI_Finalize();
    return 0;
}

