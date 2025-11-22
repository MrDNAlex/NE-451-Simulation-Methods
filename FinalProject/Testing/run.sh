#!/bin/bash
#SBATCH --job-name=FP-test
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=7G 
#SBATCH --cpus-per-task=2  # 1 thread per rank

module load class-simulations

mpirun -np $SLURM_NTASKS pw.x < test.scf.in > test.scf.out