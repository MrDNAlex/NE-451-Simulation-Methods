#!/bin/bash
#SBATCH --time=0-1:00           # DD-HH:MM
#SBATCH --nodes=1
#SBATCH --ntasks=2     # MPI tasks
#SBATCH --mem-per-cpu=4000M                 # all memory on node
module load  class-simulations

mpirun -np $SLURM_NTASKS  pw.x < pw.scf.silicon.in > pw.scf.silicon.out
