# -*- coding: utf-8 -*-
"""
Created on Wed Aug 13 16:00:11 2025

@author: Lenovo
"""

import matplotlib.pyplot as plt
import numpy as np

# Load data from the file
data = np.loadtxt('si_bands.dat.gnu')  
k_points = data[:, 0]
energies = data[:, 1]

# Plot band structure
plt.figure(figsize=(6, 4))
plt.plot(k_points, energies, color='b', lw=2)
plt.xlabel('k-point path')
plt.ylabel('Energy (eV)')
plt.title('Band Structure')
plt.grid(True)

# Optionally, add vertical lines for high-symmetry k-points
# Example: if you want lines at the first, middle, and last k-points
high_sym_k = [k_points[0], k_points[len(k_points)//2], k_points[-1]]
for k in high_sym_k:
    plt.axvline(x=k, color='k', linestyle='--', lw=0.8)

plt.tight_layout()
plt.show()
