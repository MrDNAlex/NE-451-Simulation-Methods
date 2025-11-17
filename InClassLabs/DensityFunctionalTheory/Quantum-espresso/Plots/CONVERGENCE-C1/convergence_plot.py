import numpy as np
import matplotlib.pyplot as plt
import glob
import re

# Pattern to match total energy line in QE output
energy_pattern = re.compile(r"!\s+total energy\s+=\s+(-?\d+\.\d+)")

ecut_values = []
etot_values = []

# Loop over all output files matching your naming convention
for filename in sorted(glob.glob("ecut_*.out"), key=lambda x: int(x.split("_")[1].split(".")[0])):
    with open(filename) as f:
        for line in f:
            match = energy_pattern.search(line)
            if match:
                ecut = int(filename.split("_")[1].split(".")[0])
                etot = float(match.group(1))
                ecut_values.append(ecut)
                etot_values.append(etot)
                break  # stop reading this file once energy found

# Convert to numpy arrays for easier handling
ecut_values = np.array(ecut_values)
etot_values = np.array(etot_values)

# Plot
plt.figure(figsize=(8, 5))
plt.plot(ecut_values, etot_values, marker='o', linestyle='-', color='b')
plt.xlabel("Ecutwfc (Ry)")
plt.ylabel("Total Energy (Ry)")
plt.title("Convergence of Total Energy with Ecutwfc")
plt.grid(True)
plt.tight_layout()
plt.savefig("Test.png")
plt.show()
