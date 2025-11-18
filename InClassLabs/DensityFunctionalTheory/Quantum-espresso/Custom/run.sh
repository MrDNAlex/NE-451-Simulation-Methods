#!/bin/bash
#SBATCH --time=0-1:00           # DD-HH:MM
#SBATCH --nodes=1
#SBATCH --ntasks=3     # MPI tasks
#SBATCH --mem-per-cpu=4000M                 # all memory on node
module load  class-simulations

mpirun -np $SLURM_NTASKS pw.x < pwscf.in > pwscf.out