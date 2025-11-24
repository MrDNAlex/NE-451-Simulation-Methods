#!/bin/bash
#SBATCH --job-name=FP-Geo2
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=12:00:00
#SBATCH --mem-per-cpu=7G 
#SBATCH --cpus-per-task=2  # 1 thread per rank

module load class-simulations

mpirun -np $SLURM_NTASKS pw.x < geoopt.in > geoopt.out