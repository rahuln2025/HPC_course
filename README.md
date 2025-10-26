### Checkout ```PVL_2023``` for HPC Project on cellular automata. Feedback from the oral exam has not been incorporated


# Instructions to do HPC assignments & use GitHub

1. Use VSCode for ssh setup using SSH FS Kelvin.vscode-sshfs. Follow instructions on the extension page
2. Host: ```mlogin01.hrz.tu-freiberg.de```, Username: <YOUR_TUBAF_USERNAME>
3. IMPORTANT: Password: <prompt>, Keep Prompt field empty --> This triggers password entering every time you try to connect
4. In SSH FS extension, next to tubaf_hpc connection, click on the "folder-like" button to open workspace (of whole HPC Cluster)
5. Under ```/home/<YOUR_TUBAF_USERNAME>``` you can find all HPC codes. Manually navigate here. 

# Setup GitHub

Follow these commands:
1. init your git
```git init```
2. check status (ideally all files should be ready for adding)
```git status```
3. first commit
```git commit -m "adding all HPC assignment files form TUBAF cluster"```
4. check status again using ```git status```
5. Create a repo on your github profile. At top right of the newly created repo, get the link for the remote repo. Then link your local TUBAF repo. to the remote github repo. 
```git remote add origin https://github.com/<YOUR_GITHUB_USRNAME>/<YOUR_REPO_NAME>.git```
6. Push code to remote
```git push -u origin master```
7. Now you can check status again if needed. 
8. Optionally set up ```.gitignore``` to prohibit C++ executables from being tracked to GitHub. Ideally GitHub should be the place for your code only. 

# Compiling C++ scripts, running executables & submitting jobs

## Compile C++ scripts for OpenMP

### OpenMP exercises
1. Assuming that your script already exists at the desired path. Let path for this case be ```/home/rn14pyry/HPC_CMS_2025```. Go to the location. 
2. Compile:
```g++ -o ex02a hpc24a_ex02a.cpp -O0 -fopenmp```
- ```g++```: compiler
- ```-o ex02a```: specify the name of compiled executable
- ```hpc24a_ex02a.cpp```: your script name
- ```-O0```: (Capital O, zero) set optimization level to zero, typical for debugging. Higher optimization levels result in compilation that may not follow a predictable sequence out outputs as specified in the script. 
- ```-fopenmp```: Enable OpenMP support for parallelization/
3. After compiling, you shall get an executable ```ex02a```. This will be run using jobscript or interactively or (not recommended to do) on the login node. 

## Compile C++ scripts for MPI

### MPI exercises
1. Assuming your script already exists at the desired path, for e.g. ```home/rn14pyry/HPC_CMS_2025```. Go to the location.
2. First, you need to load module for MPI:
```module load openmpi/gcc/11.4.0```
3. Now you can compile:
```mpic++ -o ex07 hpc24c_ex07.cpp```
4. After compiling you will get an executable (also called as binary) with the name ```ex07```.

## Running binary executables 

### For OpenMP

#### Running OpenMP binary on login node
This is not the recommended way to run your HPC executables, especially if they are large computations. 
1. 
```
export OMP_NUM_THREADS=4 # specifiy threads required
time ./ex02a # run executable with time tracking
```
2. Your outputs will be printed in the terminal and not stored in a file.

#### Job Script for OpenMP
The most recommended way to run any HPC executable. 
1. Making a job.script: explained via example
```sh
#!/bin/bash

# name of your job, will be shown in queue
#PBS -N ex02_output 

# job queue to which job will be submitted
#PBS -q teachingq
 
# requesting resources, 1 node with 1 CPU core with 1 MPI process
#PBS -l select=1:ncpus=1:mpiprocs=1 

# maximum walltime. After this time, job run will be terminated
#PBS -l walltime=00:01:00 

# file to store outputs
#PBS -o ex02a.out

# file to store error logs
#PBS -e ex02a.err

# here onwards, commands to execute are specified

echo -e "Job started from $(pwd)."
echo "Changing directory to..."

# specify working dir.
# $HOME means user home. For me it will be /home/rn14pyry/
# next specify the dir. path where your executable is stored 
PBS_O_WORKDIR=$HOME/HPC_CMS_2025
cd $PBS_O_WORKDIR

echo -e "$(pwd)"

# commands to run your executable
export OMP_NUM_THREADS=4
time ./ex02a
```

2. Submitting job.script: 
```qsub job.script```

3. In the path specified in job.script, you shall see ```*.out``` and ```*.err``` files generated. These contain your results and error logs. 

4. Sometimes the job script might throw errors like: 
```
-bash: /var/spool/pbs/mom_priv/jobs/990837.mmaster02.SC: /bin/bash^M: Defekter Interpreter: Datei oder Verzeichnis nicht gefunden
```
This might be due to the script being interpreted in the Unix system while it has been written in Windows (for e.g. on VSCode on the Windows OS of your laptop)

The next command may help resolve this issue: 
```sh
sed -i 's/\r$//' qsub_job.sh 
```


### For MPI

#### Running MPI binary on login node
This is definitely not the recommended way to run your HPC binaries written with MPI. Prefer this approach for small tests with max 2 processes (n = 2). 

```sh mpiexec -n 2 ./ex07```

The ```-n 2``` specifies the use of two MPI processes (or two ranks). 

The output will be printed in the terminal and not stored in a file. 



#### Job Script for MPI
1. It is quite similar to the one for OpenMP.
```sh
#!/bin/bash

#PBS -N ex07_output
#PBS -q teachingq

# for MPI you need to use more than 1 ncpus and mpiprocs
#PBS -l select=1:ncpus=8:mpiprocs=8 
#PBS -l walltime=00:01:00
#PBS -o ex07.out
#PBS -e ex07.err

echo -e "Job started from $(pwd)."
echo "Changing directory to..."
PBS_O_WORKDIR=$HOME/HPC_CMS_2025
cd $PBS_O_WORKDIR
echo -e "$(pwd)"

# execution command changes as compared to OpenMP
mpiexec ./ex07
```
2. Submitting the job script is the same as for OpenMP binaries. 


#### Using Python

1. You may need to use Python for simple scripts used to post-process results or make first MVP codes (w/o any parallelization).
2. Just need to load the Python module: ```module load python/gcc/11.4.0```. 
3. Then use your Python scripts as you normally run then from terminal. 

# Matrix Handling in C++ and OpenMP

### Matrix storage and indexing in C++ with std::vector

In this code, matrices are stored as one-dimensional (`1D`) arrays using `std::vector<double>`. This is a common and efficient approach in C++ for handling matrices, especially when the size is determined at runtime.

For an `N x N` matrix, you declare a vector of size `N * N`:

```cpp
std::vector<double> a(N * N);
```

Each element of the matrix can be accessed using the formula `a[i * N + j]`, where `i` is the row index and `j` is the column index. This is known as **row-major order** storage.

For more information about the vector class and its commands, see [vector class info](https://cplusplus.com/reference/vector/vector/).


#### Example: 3x3 matrix

Suppose you want to store this 3x3 matrix:

```
| 1  2  3 |
| 4  5  6 |
| 7  8  9 |
```

You declare the vector as:

```cpp
std::vector<double> mat(3 * 3);
```

To fill the matrix:

```cpp
int N = 3;
std::vector<double> mat(N * N);
for (int i = 0; i < N; ++i) {
    for (int j = 0; j < N; ++j) {
        mat[i * N + j] = i * N + j + 1;
    }
}
```

**Accessing elements:**
- `mat[0 * 3 + 0]` is 1 (row 0, col 0)
- `mat[1 * 3 + 2]` is 6 (row 1, col 2)
- `mat[2 * 3 + 1]` is 8 (row 2, col 1)

This method allows you to efficiently handle matrices of any size using a single vector, with easy indexing for both reading and writing elements.

You can **print** it using:
```cpp
// Print function
void print(const unsigned long N, const std::vector<double> &a)
{
    unsigned long i,j;
    for (i = 0; i < N; ++i) {
        for (j = 0; j < N; ++j) {
            std::cout << " " << a[i * N + j];
        }
        std::cout << "\n";
    }
    std::cout << "\n";
}

print(N, mat);
```

This will output:

```
1 2 3
4 5 6
7 8 9
```

This is useful for debugging and verifying the contents of the matrices after initialization and multiplication, especially when working with small matrices. For large matrices, printing is skipped to avoid overwhelming the output.

Useful matrix functions:

Assuming the following matrices or vectors and using the ```#include <vector>``` standard template library:

```cpp
//Matrix

const unsigned long N = static_cast<unsigned long>(n_input);
std::cout << "Matrix size: N = " << N << "\n";

std::vector<double> a(N * N);
std::vector<double> b(N * N);
std::vector<double> c(N * N, 0);  // Initialize c with zeros

//Vector
int n = 8;
std::vector<double> a = {1, 2, 3, 4, 5, 6, 7, 8};
std::vector<double> b = {1, 2, 3, 4, 5, 6, 7, 8};
std::vector<double> c(n, 0);

```

**Matrix Initialization**
```cpp
// Matrix initialization function
void initialize_matrices( const unsigned long N, 
                          std::vector<double> &a,  
                          std::vector<double> &b, 
                          std::vector<double> &c)
{
    unsigned long i,j;

    #pragma omp parallel for private(i,j)
    for (i = 0; i < N; ++i) {
        for (j = 0; j < N; ++j) {
            a[i * N + j] = i + j + 1.0;
            b[i * N + j] = 1.0 / (i + j + 1);
            c[i * N + j] = 0;
        }
    }
}
```



**Matrix Multiplication**
```cpp
// Matrix multiplication function
void multiply_matrices( const unsigned long N, 
                        const std::vector<double> &a, 
                        const std::vector<double> &b, 
                        std::vector<double> &c)
{
    unsigned long i, j, k;

    #pragma omp parallel for private(i, j, k)
    for (i = 0; i < N; ++i) {
        for (j = 0; j < N; ++j) {
            c[i * N + j] = 0;
            for (k = 0; k < N; ++k) {
                c[i * N + j] += a[i * N + k] * b[k * N + j];
            }
        }
    }
}

```

**Vector Addition & Printing**
```cpp
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

```

# Some MPI Caveats

There are several versions of ```MPI_Send``` and ```MPI_Recv```. Here's a quick summary for them. I am not an expert so feel free to correct if I am wrong here. 

### MPI Send/Receive Commands

| Function   | Blocking/Non-blocking | Description                                                                  |
| ---------- | --------------------- | ---------------------------------------------------------------------------- |
| MPI\_Send  | Blocking              | Sends a message and waits until it's delivered to the receiver.              |
| MPI\_Recv  | Blocking              | Receives a message and waits until the message is received.                  |
| MPI\_Isend | Non-blocking          | Initiates a send operation and returns immediately.                          |
| MPI\_Irecv | Non-blocking          | Initiates a receive operation and returns immediately.                       |
| MPI\_Ssend | Blocking              | Synchronous send that waits until the receiver starts receiving the message. |


### MPI Send/Receive Compatibility Table

| Send Type     | Receive Type | Compatible | Remarks                                                    |
|---------------|--------------|------------|------------------------------------------------------------|
|**MPI_Send**      | **MPI_Recv**     | Yes        | Commonly used; both blocking and safe if well-ordered.     |
| MPI_Isend     | MPI_Recv     | Yes        | Non-blocking send with blocking receive; generally safe.   |
| MPI_Send      | MPI_Irecv    | No         | May cause deadlock if receive is not posted early enough.  |
| **MPI_Isend**     | **MPI_Irecv**    | Yes        | Both non-blocking; requires synchronization via `MPI_Wait`.|
| MPI_Ssend     | MPI_Recv     | Yes        | Synchronous; safe if receive is ready.                     |
| MPI_Ssend     | MPI_Irecv    | No         | Can deadlock; ensure receive is posted before send.        |

### More documentation on the way ...


## Some useful links:

0. Since we are at TUBAF, we need to check the [TUBAF HPC Documentation](https://tu-freiberg.de/en/urz/service-portfolio/high-performance-computing-hpc) of handling HPC Cluster. 

1. Rookie HPC has a well-organized and easy to navigate documentation: 
[MPI Documentation](https://rookiehpc.org/mpi/docs/index.html) and [OpenMP Documentation](https://rookiehpc.org/openmp/docs/index.html).

2. [HPC Wiki](https://hpc-wiki.info/hpc/HPC_Wiki)
 has almost all things you need to know.




