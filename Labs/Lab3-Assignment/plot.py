import numpy as np
import matplotlib.pyplot as plt

# ================================
# Load Data
# ================================
data = np.loadtxt("GaAs.band.gnu")

k = data[:, 0]
E = data[:, 1]

# ================================
# Parameters 
# ================================
x1 = 0.8660
x2 = 1.8660
x3 = 2.2932
xmax = 3.2844

ymin = -13
ymax = 7

ef = xxx   # Fermi energy shift (define appropriately)

# ================================
# Plot
# ================================
plt.figure(figsize=(7, 5))

plt.plot(k, E - ef, linewidth=1, color='navy')

# Vertical high-symmetry lines
for xline in [x1, x2, x3]:
    plt.axvline(x=xline, color='gray', linestyle='--', linewidth=0.8)

# Axes labels
plt.ylabel("Energy (eV)")
plt.xlabel("k-point path")

plt.ylim(ymin, ymax)
plt.xlim(0, xmax)

# X-ticks with symmetry labels
plt.xticks(
    [0, x1, x2, x3, xmax],
    ["L", r"$\Gamma$", "X", "K,U", r"$\Gamma$"]
)

plt.tight_layout()

# ================================
# Save figure
# ================================
plt.savefig("GaAs_band.png", dpi=300)
plt.savefig("GaAs_band.pdf")  # optional

plt.show()