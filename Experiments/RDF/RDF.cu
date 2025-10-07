#------------------------ INITIALIZATION---------------------
units metal
boundary p p p
atom_style atomic

# Read Data
read structure.lmp

# Define Variables
variable dt equal 0.001

# Define Atom Groups
group Li type 1
group Mn type 2
group O type 3

# Define the Force Fields
pair_style meam
pair_coeff * * library.meam Li Mn O LiMnO.meam Li Mn O

# Equilibriation
thermo 100
thermo_style custom step temp pe ke etotal press lx ly lz

timestep ${dt}
velocity all create 670.0 123

fix integrate1 all npt 670.0 670.0 10.0 aniso 0.0 0.0 10.0 

run 50000
unfix integrate1

# Production
compute RDF all rdf 20 1 1 1 2 1 3
thermo 100
thermo_style custom step temp pe ke etotal vol

dump muDump1 all custom 100 Dumpfiles/_*.dump id type element x y
dump_modify myDump1 element Li Mn O

fix 1 all ave/time 10 10 100 c_RDF[*] file RDF.data mode vector

fix integrate2 all nvt temp 670.0 670.0 10.0
run 50000
unfix integrate2








