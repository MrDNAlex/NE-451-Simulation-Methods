import matplotlib.pyplot as plt
import numpy as np

# load data (change unpacking if you have only 2 columns)
energy, dos, idos = np.loadtxt('./si_dos.dat', unpack=True)

fermi_energy = 6.642  # in eV

# make plot
plt.figure(figsize=(12, 6))
plt.plot(energy, dos, linewidth=0.75, color='red')
plt.yticks([])
plt.xlabel('Energy (eV)')
plt.ylabel('DOS')
plt.axvline(x=fermi_energy, linewidth=0.5, color='k', linestyle=(0, (8, 10)))
plt.xlim(-6, 16)
plt.ylim(0,)
plt.fill_between(energy, 0, dos, where=(energy < fermi_energy), facecolor='red', alpha=0.25)
plt.text(fermi_energy - 0.5, max(dos) * 0.2, 'Fermi energy', fontsize=12, rotation=90)
plt.savefig("Test.png")
plt.show()
