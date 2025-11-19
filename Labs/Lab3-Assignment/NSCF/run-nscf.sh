#!/bin/bash
#SBATCH --job-name=GaAs_nscf
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=4000M 
#SBATCH --cpus-per-task=2  # 1 thread per rank

module load class-simulations

mpirun -np $SLURM_NTASKS pw.x < GaAs.nscf.in > GaAs.nscf.out