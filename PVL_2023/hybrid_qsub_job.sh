#!/bin/bash
#PBS -N PVL2023_hybrid
#PBS -q teachingq
# Request 1 node with 8 total CPUs, 1 MPI rank per node, 8 OpenMP threads
#PBS -l select=1:ncpus=8:mpiprocs=1:mem=128gb
#PBS -l walltime=00:30:00
# Standard output / error
#PBS -o hybrid_4000_1000.out
#PBS -e hybrid_4000_1000.err

echo "Job started from $(pwd)"
# Switch to your working directory:
cd $HOME/PVL_2023
echo "Running in directory $(pwd)"

# Tell OpenMP how many threads to spawn per MPI rank
export OMP_NUM_THREADS=8
echo "OMP_NUM_THREADS = $OMP_NUM_THREADS"

# Launch exactly one MPI rank (per select) which will internally spawn 8 threads
time mpiexec ./hybrid_4000_1000
