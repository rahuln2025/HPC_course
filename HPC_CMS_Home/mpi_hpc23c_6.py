from mpi4py import MPI
import sys
import numpy as np

def f(x):
	fx = 1 / (1 + x**2)
	return fx	

def trapezoidal(A, rank, size, len, dx):
	
	if rank == 0:
		d_pi = dx*0.5*A[0]
		d_pi = d_pi + dx*np.sum(A[1:])
	
	#elif rank == int(size - 1):
	#	d_pi = dx*0.5*A[-1]
	#	d_pi = d_pi + dx*np.sum(A[:-1])

	else: 
		d_pi =  dx*np.sum(A)

	#d_pi = d_pi + 0.5*0.5 #for x = 1, d_pi added manually
	return d_pi

def main(argv):
	comm = MPI.COMM_WORLD
	rank = comm.Get_rank()
	size = comm.Get_size()

	steps_req = 1000000
	ub = steps_req/size
	arr = np.arange(0, ub, 1)
	len = arr.shape[0]
	
	#print("Array in each rank:", arr)
	#print("Length of the array in each rank:", len)
	
	dx = 1.0/(size*(len))
	#print("step size: ", dx)
	
	x = dx*(rank*len + arr)
	A = np.array(list(map(f, x)))
	d_pi = trapezoidal(A, rank, size, len, dx)
	
	#print("for rank:" + str(rank) + " x is: ", x)
	#print("for rank:" + str(rank) + " A is:", A)
	#print("for rank:" + str(rank) + " d_pi is:", d_pi)
	
	comm.Barrier()

	sum = comm.reduce(d_pi, op=MPI.SUM, root = 0)
	if rank == 0:
		sum = sum + 0.5*0.5*dx
		print("Final sum  value is:", sum)
		pi = 4*float(sum)
		print("Final pi value is:", pi)
	return 0

if __name__ == "__main__":
	main(sys.argv)
	MPI.Finalize()	
	
