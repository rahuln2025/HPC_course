#include <iostream>
#include <omp.h>

int main(int argc, char** argv){

	#pragma omp parallel
	{
		int numthreads, num;
		numthreads=omp_get_num_threads();
		num=omp_get_thread_num();
		std::cout<< "Thread" << num << "of" << numthreads << "\n";
	}
	return 0;
}

