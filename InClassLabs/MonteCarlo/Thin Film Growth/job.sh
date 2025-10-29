#!/bin/bash
#SBATCH --time=0-12:00      # Max time (DD-HH:MM)
#SBATCH --cpus-per-task=6   # Number of CPUs
#SBATCH --mem=6G            # Memory per node

module load spparks/2024.11.24

# spparks
spk_serial < in.thin_film.no.schwoebel
