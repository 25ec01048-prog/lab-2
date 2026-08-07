import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
df = pd.read_csv(r'ed-1/MOSFET_ID_VDS.csv')

tox = 10e-9 # 10 nm
Na = 1e16 # 1e17 cm^-3
qf = 1e12 # cm^-2
w = 4*1e-6 # 4 um
L = 0.18 * 1e-6 # 0.18 um
un = 400 # 400 cm^2/Vs
alGate = 4.1

#SPICE-level 1
vGs = [1,2,3]
vDs = np.linspace(0, 4, 50)
i_d = np.array([])
for v_gs in vGs:
    for v_ds in vDs:
        if v_gs < 1:
            i_d = np.append(i_d, 0)
        elif v_gs >= 1 and v_ds <= (v_gs - 1):
            i_d = np.append(i_d, un * w / L * (tox * alGate) * ((v_gs - 1) * v_ds - 0.5 * v_ds ** 2))
        else:
            i_d = np.append(i_d, un * w / L * (tox * alGate) * (0.5 * (v_gs - 1) ** 2))

    plt.plot(vDs, i_d, label=f'$V_{{GS}}$ = {v_gs} V', linewidth=2)
    i_d = np.array([])
    
plt.xlabel('$V_{DS}$ (V)')
plt.ylabel('$I_D$ (mA)')
plt.title('Output characteristics using spice - 1')
plt.legend()
plt.grid(True, linestyle='--', alpha=0.6)
plt.tight_layout()
plt.savefig("task12.png", dpi=350)
plt.show()

# spice level 3
plt.figure(figsize=(10, 6)) # a new window, 10 x 6 inches
for v_gs in vGs:
    for v_ds in vDs:
        if v_gs < 1:
            i_d = np.append(i_d, 0)
        elif v_gs >= 1 and v_ds <= (v_gs - 1):
            i_d = np.append(i_d, un * w / L * (tox * alGate) * ((v_gs - 1) * v_ds - 0.5 * v_ds ** 2))
        else:
            i_d = np.append(i_d, un * w / L * (tox * alGate) * (0.5 * (v_gs - 1) ** 2))

    plt.plot(vDs, i_d, label=f'$V_{{GS}}$ = {v_gs} V', linewidth=2)
    i_d = np.array([])
    
plt.xlabel('$V_{DS}$ (V)')
plt.ylabel('$I_D$ (mA)')
plt.title('Output characteristics using spice - 1')
plt.legend()
plt.grid(True, linestyle='--', alpha=0.6)
plt.tight_layout()
plt.savefig("task12.png", dpi=350)
plt.show()
