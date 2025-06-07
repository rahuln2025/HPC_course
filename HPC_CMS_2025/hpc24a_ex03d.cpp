// OpenMP program for demonstrating use of `omp parallel for`
#include <iostream>
#include <omp.h>
#include <sstream> //for thread-safe output


int main(int argc, char** argv){
    int i;
    int N = 100;
    int num;
    
    #pragma omp parallel for private(num)
    for(i = 0; i<N; i++){
        
        num = omp_get_thread_num();
        
        #pragma omp critical //ensure that only one thread writes to std::cout at a time
        std::cout<< "Thread " << num << " does iteration " << i << "\n"; //this is not thread-safe and results in scarambled output
        // std::stringstream ss;
        // ss << "Thread " << num << " does iteration " << i << "\n";
        // std::cout << ss.str(); //this is thread-safe and results in correct output
    }

    return 0;
}