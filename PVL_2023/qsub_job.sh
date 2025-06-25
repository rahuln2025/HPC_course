#!/bin/bash

#PBS -N PVL2023_output
#PBS -q teachingq
#PBS -l select=1:ncpus=4:mpiprocs=4
#PBS -l walltime=00:30:00
#PBS -o mpi_500_1000.out
#PBS -e mpi_500_1000.err

echo -e "Job started from $(pwd)."
echo "Changing directory to..."
PBS_O_WORKDIR=$HOME/PVL_2023
cd $PBS_O_WORKDIR
echo -e "$(pwd)"

time mpiexec mpi_500_1000