#include <iostream>
#include <omp.h>
#include <vector>



void add_vectors(const unsigned long N, 
                 const std::vector<double> &a,
                 const std::vector<double> &b,
                 std::vector<double> &c) 
{
    unsigned long i, j, k;

    #pragma omp parallel for private(i)
    for (i = 0; i < N; i++) {
        c[i] = a[i] + b[i];
    }
}

void print_vector(const std::vector<double> &v)
{
    for (unsigned long i = 0; i < v.size(); i++) {
        std::cout << v[i] << " ";
    }
    std::cout << std::endl;
}


int main(){

    int n = 8;
    std::vector<double> a = {1, 2, 3, 4, 5, 6, 7, 8};
    std::vector<double> b = {1, 2, 3, 4, 5, 6, 7, 8};
    std::vector<double> c(n, 0);
    int i, num;
    int nthreads;

    // Usage without vector class
    // int a[] = {1, 2, 3, 4, 5, 6, 7, 8};
    // int b[] = {1, 2, 3, 4, 5, 6, 7, 8};
    // int c[8] = {0};
    // #pragma omp parallel for shared (n, a, b, c) private(i, num)
    // for (i=0; i<n; i++) {
    //     c[i] = a[i] + b[i];
    // }

    // #pragma omp master
    // {
    //     printf("\n");
    //     for (i = 0; i < n; i++) {
    //         printf("%d ", c[i]);
    //     }
    //     printf("\n");
    // }

    add_vectors(n, a, b, c);
    
    #pragma omp master
    {
        std::cout << "\nResulting vector: ";
        print_vector(c);
    }
}