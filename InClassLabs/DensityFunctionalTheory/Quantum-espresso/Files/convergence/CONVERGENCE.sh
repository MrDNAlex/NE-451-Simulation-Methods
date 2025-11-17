#!/bin/bash
#SBATCH --time=0-1:00           # DD-HH:MM
#SBATCH --nodes=1
#SBATCH --ntasks=2     # MPI tasks
#SBATCH --mem-per-cpu=4000M                 # all memory on node
module load  class-simulations


NAME="ecut"

for CUTOFF in  10 15 20 25 30 35 40
do
cat > ${NAME}_${CUTOFF}.in << EOF
 &control
    calculation = 'scf',
    prefix = 'silicon'
    outdir = './tmp/'
    pseudo_dir = '.'
 /
 &system
    ibrav =  2,
    celldm(1) = 10.0,
    nat =  2,
    ntyp = 1,
    ecutwfc = $CUTOFF
 /
 &electrons
    mixing_beta = 0.6
 /

ATOMIC_SPECIES
 Si 28.086  Si.pz-vbc.UPF

ATOMIC_POSITIONS (alat)
 Si 0.0 0.0 0.0
 Si 0.25 0.25 0.25

K_POINTS (automatic)
  6 6 6 1 1 1
EOF

mpirun -np $SLURM_NTASKS pw.x < ${NAME}_${CUTOFF}.in > ${NAME}_${CUTOFF}.out
echo ${NAME}_${CUTOFF}
grep ! ${NAME}_${CUTOFF}.out

done

