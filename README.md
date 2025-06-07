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