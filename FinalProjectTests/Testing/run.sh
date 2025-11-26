#!/bin/bash
#SBATCH --job-name=FP-test
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=12:00:00
#SBATCH --mem-per-cpu=800M 
#SBATCH --cpus-per-task=8  # 1 thread per rank

module load class-simulations

mpirun -np $SLURM_NTASKS pw.x < test.scf.in > test9.scf.out