#!/bin/bash
#PBS -N PVL2023_hybrid
#PBS -q teachingq
#PBS -l select=2:ncpus=8:mpiprocs=8:mem=64gb
#PBS -l walltime=00:30:00
# Standard output / error
#PBS -o strong_mpi_16_4000_1000.out
#PBS -e strong_mpi_16_4000_1000.err

echo "Job started from $(pwd)"
# Switch to your working directory:
cd $HOME/PVL_2023
echo "Running in directory $(pwd)"

# Tell OpenMP how many threads to spawn per MPI rank
export OMP_NUM_THREADS=1
echo "MPI Only Strong Scalability Test with 2 ranks and 16 cores"
echo "OMP_NUM_THREADS = $OMP_NUM_THREADS"

# Launch 
time mpiexec ./hybrid_4000_1000
