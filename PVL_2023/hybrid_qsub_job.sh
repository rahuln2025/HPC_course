#!/bin/bash
#PBS -N PVL2023_hybrid
#PBS -q teachingq
#PBS -l select=1:ncpus=4:mpiprocs=4:mem=128gb
#PBS -l walltime=00:30:00
# Standard output / error
#PBS -o hybrid2_4_1000_1000.out
#PBS -e hybrid2_4_1000_1000.err

echo "Job started from $(pwd)"
# Switch to your working directory:
cd $HOME/PVL_2023
echo "Running in directory $(pwd)"

# Tell OpenMP how many threads to spawn per MPI rank
export OMP_NUM_THREADS=2
echo "select=1:ncpus=4:mpiprocs=4:mem=64gb"
echo "Hybrid 2.0 Strong Scalability Test 2.0 with 4 ranks and 4 cores"
echo "OMP_NUM_THREADS = $OMP_NUM_THREADS"

# Launch 
time mpiexec -- ./hybrid_version2_1000_1000 --store
