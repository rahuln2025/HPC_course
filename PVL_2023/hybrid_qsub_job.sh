#!/bin/bash
#PBS -N PVL2023_hybrid
#PBS -q teachingq
#PBS -l select=1:ncpus=8:mpiprocs=1
#PBS -l walltime=00:30:00
# Standard output / error
#PBS -o weak_M1_2828_1000.out
#PBS -e weak_M1_2828_1000.err

echo "Job started from $(pwd)"
# Switch to your working directory:
cd $HOME/PVL_2023
echo "Running in directory $(pwd)"

# Tell OpenMP how many threads to spawn per MPI rank
export OMP_NUM_THREADS=1
echo select=1:ncpus=8:mpiprocs=1
echo "MPI Only 2.0 Weak Scalability Test M1 with 1 ranks and 8 cores"
echo "OMP_NUM_THREADS = $OMP_NUM_THREADS"

# Launch 
time mpiexec -- ./weak_2828_1000
