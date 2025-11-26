import numpy as np

a1 = np.array([20.47239210, 0.00000000, 0.00000000])
a2 = np.array([0.00000000, 11.94151020, 0.00000000])
a3 = np.array([0.00000000, 0.00000000, 4.65491719])

b1 = 2*np.pi*(np.cross(a2, a3))/(a1 * np.cross(a2, a3))
b2 = 2*np.pi*(np.cross(a3, a1))/(a1 * np.cross(a2, a3))
b3 = 2*np.pi*(np.cross(a1, a2))/(a1 * np.cross(a2, a3))


print(b1, b2, b3)


# ===============================================================
# Generate K_POINTS crystal_b path for orthorhombic LiFePO4 (Pnma)
# Path: Γ – X – S – Y – Γ – Z – U – R – T – Z
# Points expressed in fractional reciprocal coordinates (crystal_b)
# ===============================================================

import numpy as np

# ---------------------------------------------------------------
# 1. High-symmetry points for simple orthorhombic (Pnma)
# ---------------------------------------------------------------
kpoints = {
    "G": np.array([0.0, 0.0, 0.0]),            # Gamma
    "X": np.array([0.5, 0.0, 0.0]),
    "Y": np.array([0.0, 0.5, 0.0]),
    "Z": np.array([0.0, 0.0, 0.5]),
    "S": np.array([0.5, 0.5, 0.0]),
    "T": np.array([0.0, 0.5, 0.5]),
    "U": np.array([0.5, 0.0, 0.5]),
    "R": np.array([0.5, 0.5, 0.5]),
}

# ---------------------------------------------------------------
# 2. Band path definition (HPKOT / SeeK-path recommended)
# ---------------------------------------------------------------
path_labels = ["G", "X", "S", "Y", "G", "Z", "U", "R", "T", "Z"]

# ---------------------------------------------------------------
# 3. Number of interpolation points per segment
# ---------------------------------------------------------------
points_per_segment = 20   # Increase to 30+ for very smooth bands

# ---------------------------------------------------------------
# 4. Generate interpolated path points
# ---------------------------------------------------------------
all_points = []

for i in range(len(path_labels) - 1):
    start = kpoints[path_labels[i]]
    end   = kpoints[path_labels[i+1]]

    # linear interpolation
    for j in range(points_per_segment):
        t = j / (points_per_segment - 1)
        k = (1 - t) * start + t * end
        all_points.append(k)

# Convert to array
all_points = np.array(all_points)
N = len(all_points)

# ---------------------------------------------------------------
# 5. Print QE K_POINTS block
# ---------------------------------------------------------------
print("K_POINTS crystal_b")
print(f"  {N}")
for k in all_points:
    print(f"  {k[0]:.6f}  {k[1]:.6f}  {k[2]:.6f}  1.0")

# ---------------------------------------------------------------
# Save to file (optional)
# ---------------------------------------------------------------
with open("kpath_LiFePO4.in", "w") as f:
    f.write("K_POINTS crystal_b\n")
    f.write(f"  {N}\n")
    for k in all_points:
        f.write(f"  {k[0]:.6f}  {k[1]:.6f}  {k[2]:.6f}  1.0\n")

print("\nSaved to kpath_LiFePO4.in")

