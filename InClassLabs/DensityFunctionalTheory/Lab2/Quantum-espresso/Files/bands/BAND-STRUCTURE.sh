#!/bin/bash
#SBATCH --time=0-1:00           # DD-HH:MM
#SBATCH --nodes=1
#SBATCH --ntasks=3     # MPI tasks
#SBATCH --mem-per-cpu=4000M                 # all memory on node
module load  class-simulations

mpirun -np $SLURM_NTASKS pw.x < pw.scf.silicon_bands.in > pw.scf.silicon_bands.out
mpirun -np $SLURM_NTASKS pw.x < pw.bands.silicon.in > pw.bands.silicon.out
mpirun -np $SLURM_NTASKS bands.x < pp.bands.silicon.in > pp.bands.silicon.out


