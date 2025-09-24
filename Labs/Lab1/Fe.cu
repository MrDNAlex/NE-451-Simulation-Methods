

# Initialize Simulation
clear               # Clear all settings
units metal         # Use Metal Units (Å, eV, ps, g/mol)
dimension 3         # 3D Simulation
boundary p p p      # Preiodic Boundaryies in X Y Z
atom_style atomic   # Only simulate Atoms, No Bonds, No charges 

# Read the "XYZ" File
read_data Fe.data

# Define the Mass of the Atom with index 1
mass 1 55.845

# Define Interatomic Potential
pair_style eam              # Embedded Atom Method
pair_coeff * * Fe.eam Fe    # EAm Potential File
neighbor 2.0 bin            # Neighbor List Cutoff
neigh_modify delay 0 every 1 check yes # Update the Neighbor list ever step

# Define Computation
compute eng all pe/atom             # Compute the Per Atom Potential Energy
compute eatoms all reduce sum c_eng # Sum over all the atoms and total energy

# Dump atoms to an a Visualization file
dump 1 all atom 50 fe_dump.lammpstrj

# 1 : ID of the Dump
# all : Dump all atoms in the Simulation
# atom : Use the "atom" style
# 50 : Create a dump every 50 steps
# fe_dump.lammpstrj : Name of the dump file

dump_modify 1 sort id
# Make sure the dumoped atoms are sorted by id


# Relax the Atomic Structure
reset_timestep 0
fix 1 all box/relax iso 0.0 vmax 0.001              # let Box relax under 0 pressure
thermo 10                                           # Print Thermodynamic Info every 10 steps
thermo_style custom step pe lx ly lz press c_eatoms 
min_style cg                                        # Conjugate gradient minimization
minimize 1e-25 1e-25 5000 10000                     # Energy/force convergence

# Define Global Variables
variable N_atoms equal "count(all)"        
variable total_e equal "c_eatoms"          
variable length equal "lx"                 
variable coh_e equal "v_total_e/v_N_atoms" 

# Print the Results
print "Total energy (eV) = ${total_e};"
print "Number of atoms = ${N_atoms};"
print "Lattice constant (Angstroms) = ${length};"
print "Cohesive energy (eV) = ${coh_e};"
print "All done!"