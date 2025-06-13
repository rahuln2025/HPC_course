//MPI program to show MPI_Send and MPI_Recv
#include <iostream>
#include "mpi.h"

int main(int argc, char** argv) {

    MPI_Init(&argc, &argv);

    int rank, size;

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    // Each rank sends its rank to the next rank 
    // arnd receives the rank from the previous rank

    int next_rank = (rank + 1) % size; // Next rank in a round-robin fashion
    int prev_rank = (rank - 1 + size) % size; // Previous rank in a round-robin fashion

    int message_to_send = rank; // Each rank sends its rank number
    int message_received; // Variable to store the received message

    // Send the rank number to the next rank
    MPI_Send(&message_to_send, 1, MPI_INT, next_rank, 0, MPI_COMM_WORLD);
    //      (message pointer, count, datatype, destination rank, tag, communicator) 
    // Receive the rank number from the previous rank
    //MPI_Request request;
    MPI_Recv(&message_received, 1, MPI_INT, prev_rank, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    //      (message pointer, count, datatype, destination rank, tag, communicator, status/request pointer in case of Irecv) 

    // Print the message received
    std::cout << "Rank " << rank << " received a message from rank " << message_received << std::endl;

    MPI_Finalize(); // Finalize the MPI environment

    return 0; 
}