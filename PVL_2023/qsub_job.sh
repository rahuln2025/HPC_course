#!/bin/bash

#PBS -N PVL2023_output
#PBS -q teachingq
#PBS -l select=1:ncpus=8:mpiprocs=8:mem=128gb
#PBS -l walltime=00:30:00
#PBS -o MPI_4000_1000.out
#PBS -e MPI_4000_1000.err

echo -e "Job started from $(pwd)."
echo "Changing directory to..."
PBS_O_WORKDIR=$HOME/PVL_2023
cd $PBS_O_WORKDIR
echo -e "$(pwd)"

time mpiexec ./MPI_4000_1000