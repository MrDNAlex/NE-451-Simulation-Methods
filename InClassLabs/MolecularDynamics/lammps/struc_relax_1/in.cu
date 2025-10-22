# ----------------------------------------
# LAMMPS Input Script: Cu (FCC) with EAM
# Case: Reading structure from cu.data
# Goal: Relax, compute cohesive energy, and dump atoms
# ----------------------------------------

# ---- Initialize Simulation ----
clear                         
units           metal         # Use metal units (Å, eV, ps, g/mol)
dimension       3             # 3D simulation
boundary        p p p         # Periodic in x, y, z
atom_style      atomic        # Only atoms (no bonds/charges)

# ---- Read Atomic Structure ----
read_data       cu.data       # Load atomic positions and box dimensions

# ---- Define Atom Mass ----
mass 1 63.546                 # Mass of copper atoms (amu)

# ---- Define Interatomic Potential ----
pair_style      eam           # Embedded Atom Method
pair_coeff      * * Cu_u3.eam # EAM potential file for Cu
neighbor        2.0 bin       # Neighbor list cutoff
neigh_modify    delay 0 every 1 check yes  # Update neighbor list every step

# ---- Define Computations ----
compute eng all pe/atom       # Per-atom potential energy
compute eatoms all reduce sum c_eng   # Sum over all atoms → total energy

# ---- Dump Atoms to File (for visualization/post-processing) ----
dump 1 all atom 50 cu_dump.lammpstrj  
# "dump 1": ID of this dump command
# "all": include all atoms
# "atom": dump atom style data (id, type, x, y, z)
# "50": frequency (every 50 steps)
# "cu_dump.lammpstrj": output filename (LAMMPS trajectory format)

dump_modify 1 sort id  
# Ensures atoms in the dump file are sorted by their ID for consistency
# Helpful when comparing configurations between timesteps in OVITO

# ---- Relax Atomic Structure ----
reset_timestep   0
fix 1 all box/relax iso 0.0 vmax 0.001  # Allow box and atoms to relax under zero pressure
thermo 10                               # Print thermodynamic info every 10 steps
thermo_style custom step pe lx ly lz press c_eatoms
min_style cg                             # Conjugate gradient minimization
minimize 1e-25 1e-25 5000 10000         # Energy/force convergence

# ---- Define Global Variables ----
variable N_atoms equal "count(all)"        
variable total_e equal "c_eatoms"          
variable length equal "lx"                 
variable coh_e equal "v_total_e/v_N_atoms" 

# ---- Print Results ----
print "Total energy (eV) = ${total_e};"
print "Number of atoms = ${N_atoms};"
print "Lattice constant (Angstroms) = ${length};"
print "Cohesive energy (eV) = ${coh_e};"
print "All done!"