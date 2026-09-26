import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
df = pd.read_csv(r'ed-1/MOSFET_ID_VDS.csv')

tox = 10e-7 # 10 nm
Na = 1e16 # 1e17 cm^-3
qf = 1e12 # cm^-2
w = 4*1e-6 # 4 um
L = 0.18 * 1e-6 # 0.18 um
un = 400 # 400 cm^2/Vs
alGate = 4.1
phims = alGate - 4.95  # phis = 4.95 V
phif = 0.0259 * np.log(Na / 1e10) + (6 * 0.0259 ) # V
cox = (1e-12/3)/tox  # F/cm^2
vfb = phims - 1.6*1e-19*qf/cox 
phiox = (np.sqrt(4*phif*1.6*1e-19*Na*1e-12)/cox)
vt = vfb + 2*phif + phiox
lambda_ = 0.1 # V^-1

print(f"Vt = {vt:.3f} V")
print(f"Vfb = {vfb:.3f} V")
print (f"Phif = {phif:.3f} V")
print(f"Phims = {phims:.3f} V")
print(f"Phiox = {phiox:.3f} V")
print(f"Cox = {cox:.3e} F/cm^2")
fig, ax = plt.subplots(1,1,figsize=(10, 6)) 
#SPICE-level 1
vGs = [1,2,3]
vDs = np.linspace(0, 4, 100)
i_d = np.array([])

for v_gs in vGs:
    for v_ds in vDs:
        if v_gs - vt >= v_ds:
            i_d = np.append(i_d, un * w / L * (cox) * (1+lambda_ * v_ds)* (((v_gs - vt) * v_ds) - (0.5 * (v_ds ** 2))))
        else:
            i_d = np.append(i_d, un * w / L * (cox) * (0.5 * (v_gs - vt) ** 2)*(1+lambda_ * v_ds))

    plt.plot(vDs, i_d, label=f'$V_{{GS}}$ = {v_gs} V - spice 1', linewidth=2)
    i_d = np.array([])
    
plt.xlabel('$V_{DS}$ (V)')
plt.ylabel('$I_D$ (mA)')
plt.title('Output characteristics using spice - 1 without')


# for v_gs in vGs:
#     for v_ds in vDs:
#         if v_gs - vt >= v_ds:
#             i_d = np.append(i_d, un * w / L * (cox) * (1+lambda_ * v_ds)*(((v_gs - vt) * v_ds) - (0.5 * (v_ds ** 2))))
#         else:
#             i_d = np.append(i_d, un * w / L * (cox) * (0.5 * (v_gs - vt) ** 2)*(1+lambda_ * v_ds))

#     plt.plot(vDs, i_d, label=f'$V_{{GS}}$ = {v_gs} V', linewidth=2)
#     i_d = np.array([])
    
# plt.set_xlabel('$V_{DS}$ (V)')
# plt.set_ylabel('$I_D$ (mA)')
# plt.set_title('Output characteristics using spice - 1 -with lamda')
alpha = 1 + ( np.sqrt(2* 1e-12 * 1.6 * 1e-19 * Na) / cox)/ (2*np.sqrt(phif))
print(f"alpha = {alpha:.3f}")
# x
# # spice level 3
# plt.figure(figsize=(10, 6)) # a new window, 10 x 6 inches
for v_gs in vGs:
    for v_ds in vDs:
        # print(((v_gs - vt)/alpha),",", v_ds)
        if ((v_gs - vt)/(alpha))> v_ds:
            i_d = np.append(i_d, (un * w / L * (cox) *(1+lambda_ * v_ds)* (((v_gs - vt) * v_ds) - (alpha *0.5* (v_ds ** 2)))) )
        else:
            i_d = np.append(i_d, un * (w /(alpha* 2 * L)) * (cox) * ( (v_gs - vt) ** 2)*(1 + lambda_ * v_ds))

    # ax[1].plot(vDs, i_d, label=f'$V_{{GS}}$ = {v_gs} V', linewidth=2)
    plt.plot(vDs, i_d, label=f'$V_{{GS}}$ = {v_gs} V - spice 3', linewidth=2, linestyle='--')
    i_d = np.array([])
    
# ax[1].set_xlabel('$V_{DS}$ (V)')
# ax[1].set_ylabel('$I_D$ (mA)')
# ax[1].set_title('Output characteristics using spice - 3')





plt.grid(True, linestyle='--', alpha=0.6)
plt.legend(fontsize=9)
plt.tight_layout()
plt.savefig('t12.png', dpi=300) # save BEFORE showplt.show()
plt.show()
