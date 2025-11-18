#!/bin/bash
#SBATCH --job-name=GaAs_nscf
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --time=00:10:00

module load class-simulations

mpirun -np $SLURM_NTASKS pw.x < GaAs.nscf.in > GaAs.nscf.out