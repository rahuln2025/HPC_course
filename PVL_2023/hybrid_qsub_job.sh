#!/bin/bash
#PBS -N PVL2023_hybrid
#PBS -q teachingq
#PBS -l select=8:ncpus=8:mpiprocs=1:mem=16gb
#PBS -l walltime=00:30:00
# Standard output / error
#PBS -o H4_hybrid_64_8000_1000.out
#PBS -e H4_hybrid_64_8000_1000.err

echo "Job started from $(pwd)"
# Switch to your working directory:
cd $HOME/PVL_2023
echo "Running in directory $(pwd)"

# Tell OpenMP how many threads to spawn per MPI rank
export OMP_NUM_THREADS=8
echo "select=8:ncpus=8:mpiprocs=1:mem=16gb"
echo "Hybrid Weak Scalability Test H4 with 8 ranks and 64 cores"
echo "OMP_NUM_THREADS = $OMP_NUM_THREADS"

# Launch 
time mpiexec ./H4_hybrid_8000_1000
