#!/bin/bash
#PBS -N PVL2023_hybrid
#PBS -q teachingq
#PBS -l select=8:ncpus=8:mpiprocs=8:mem=16gb
#PBS -l walltime=00:30:00
# Standard output / error
#PBS -o strong_hybrid_64_4000_1000.out
#PBS -e strong_hybrid_64_4000_1000.err

echo "Job started from $(pwd)"
# Switch to your working directory:
cd $HOME/PVL_2023
echo "Running in directory $(pwd)"

# Tell OpenMP how many threads to spawn per MPI rank
export OMP_NUM_THREADS=8
echo "select=8:ncpus=8:mpiprocs=8:mem=16gb"
echo "Hybrid Strong Scalability Test 2.0 with 64 ranks and 64 cores"
echo "OMP_NUM_THREADS = $OMP_NUM_THREADS"

# Launch 
time mpiexec ./hybrid_4000_1000_2
