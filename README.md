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

## Compile C++ scripts

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

#### Running on login node
This is not the recommended way to run your HPC executables, especially if they are large computations. 
1. 
```
export OMP_NUM_THREADS=4 # specifiy threads required
time ./ex02a # run executable with time tracking
```
2. Your outputs will be printed in the terminal and not stored in a file.

#### Job Script
The most recommended way to run any HPC executable. 
1. Making a job.script: explained via example
```
#!/bin/bash

#PBS -N ex02_output # name of your job, will be shown in queue
#PBS -q teachingq # job queue to which job will be submitted
#PBS -l select=1:ncpus=1:mpiprocs=1 # requesting resources, 1 node with 1 CPU core with 1 MPI process
#PBS -l walltime=00:01:00 # maximum walltime. After this time, job run will be terminated
#PBS -o ex02a.out # file to store outputs
#PBS -e ex02a.err # file to store error logs

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


# Matrix Handling in C++

### Matrix storage and indexing in C++ with std::vector

In this code, matrices are stored as one-dimensional (`1D`) arrays using `std::vector<double>`. This is a common and efficient approach in C++ for handling matrices, especially when the size is determined at runtime.

For an `N x N` matrix, you declare a vector of size `N * N`:

```cpp
std::vector<double> a(N * N);
```

Each element of the matrix can be accessed using the formula `a[i * N + j]`, where `i` is the row index and `j` is the column index. This is known as **row-major order** storage.

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

