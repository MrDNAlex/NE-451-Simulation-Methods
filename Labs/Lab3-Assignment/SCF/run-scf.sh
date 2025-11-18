#!/bin/bash
#SBATCH --job-name=GaAs_scf
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --time=00:30:00

module load class-simulations

mpirun -np $SLURM_NTASKS pw.x < GaAs.scf.in > GaAs.scf.out