from mpi4py import MPI

#Get number of processes
size = MPI.COM_WORLD.Get_size()

#Get the rank of the process
rank = MPI.COMM_WORLD.Get_rank()

#print out a hello world message
print(f"rank={rank} size={size}")

#Synchronize processes
MPI.COMM_WORLD.Barrier()

#broadcast a message from the root process to all other processes
n = (rank +1) * 4711
n = MPI.COMM_WORLD.bcast(n if rank == 0 else None, root = 0)
print(f"	Recieved = {n}")

#Finalize the MPI environment
MPI.Finalize()


