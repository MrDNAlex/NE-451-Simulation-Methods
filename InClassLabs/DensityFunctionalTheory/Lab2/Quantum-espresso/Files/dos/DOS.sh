#!/bin/bash
#SBATCH --time=0-1:00           # DD-HH:MM
#SBATCH --nodes=1
#SBATCH --ntasks=3     # MPI tasks
#SBATCH --mem-per-cpu=4000M                 # all memory on node
module load  class-simulations

mpirun -np $SLURM_NTASKS  pw.x < pw.scf.silicon_dos.in > pw.scf.silicon_dos.out
mpirun -np $SLURM_NTASKS pw.x < pw.nscf.silicon_dos.in > pw.nscf.silicon_dos.out
mpirun -np $SLURM_NTASKS dos.x < pp.dos.silicon.in > pp.dos.silicon.out

