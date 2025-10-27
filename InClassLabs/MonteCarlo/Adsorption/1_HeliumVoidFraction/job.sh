#!/bin/bash
#SBATCH --time=1-00:00      # Max time (DD-HH:MM)
#SBATCH --cpus-per-task=6   # Number of CPUs
#SBATCH --mem=6G            # Memory per node

module load raspa3/3.0.5

raspa3 simulation.json
