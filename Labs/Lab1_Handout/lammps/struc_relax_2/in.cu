# ----------------------------------------
# LAMMPS Input Script: Cu (FCC) with EAM
# Goal: Find minimum energy FCC configuration
# ----------------------------------------

# ---- Initialize Simulation ---- 
clear                    # Clear previous simulation settings
units           metal    # Use metal units (Å, eV, ps, g/mol)
dimension       3        # 3D simulation
boundary        p p p    # Periodic boundary conditions in x,y,z
atom_style      atomic   # Atoms only (no charges, bonds, etc.)

# ---- Initialize Simulation Box ----
lattice fcc 3.61         # FCC lattice with lattice constant 3.61 Å (approx Cu experimental value)
region  box block 0 1 0 1 0 1 units lattice   # Define unit box with lattice units
create_box 1 box         # Create simulation box for 1 atom type
create_atoms 1 box       # Fill the box with atoms (according to FCC lattice)
replicate 4 4 4          # Replicate unit cell 4x4x4 times → 256 atoms total

# ---- Define Atom Mass ----
mass 1 63.546                 # Define mass for atom type 1 (Cu)

# ---- Define Interatomic Potential ----
pair_style eam           # Use Embedded Atom Method (EAM) potential
pair_coeff * * Cu_u3.eam # Use provided EAM potential file for Cu (example filename)
neighbor 2.0 bin         # Neighbor list cutoff distance = 2.0 Å
neigh_modify delay 0 every 1 check yes  # Update neighbor list every step

# ---- Define Computations ----
compute eng all pe/atom  # Compute per-atom potential energy
compute eatoms all reduce sum c_eng   # Sum of all atomic energies = total potential energy

# ---- Find Minimum Energy Configuration ----
reset_timestep 0         # Reset timestep counter
fix 1 all box/relax iso 0.0 vmax 0.001   # Relax box dimensions under zero pressure
thermo 10                # Print thermodynamic info every 10 steps
thermo_style custom step pe lx ly lz press c_eatoms  # Output specific quantities
min_style cg             # Use conjugate gradient minimizer
minimize 1e-25 1e-25 5000 10000   # Convergence criteria: energy/force tolerance, max iterations

# ---- Define Global Variables ----
variable N_atoms equal "count(all)"     # Number of atoms
variable total_e equal "c_eatoms"       # Total potential energy
variable length equal "lx"              # Box length (x direction, since FCC cube → lattice constant)
variable coh_e equal "v_total_e/v_N_atoms"  # Cohesive energy per atom

# ---- Print Results ----
print "Total energy (eV) = ${total_e};"
print "Number of atoms = ${N_atoms};"
print "Lattice constant (Angstroms) = ${length};"
print "Cohesive energy (eV) = ${coh_e};"

print "All done!"