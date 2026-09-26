import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

df = pd.read_csv(r'ed-1/MOSFET_ID_VDS.csv')

print(df.head()) # the first five rows
print(df.columns) # the exact column names -- check these!
print(df.shape) # (rows, columns)
print(df.describe()) # min, max, mean of every numeric column

plt.figure(figsize=(10, 6)) # a new window, 10 x 6 inches
# v_t = np.array([]) # threshold voltage array
for v_gs, group in df.groupby('V_GS (V)'):
    # v_t = np.append(v_t, np.polyfit(group['V_GS (V)'], group['I_D (mA)'], 2)[0]) 
    plt.plot(group['V_DS (V)'], group['I_D (mA)'], marker='o', linewidth=2, label=f'$_{{GS}}$ = {v_gs} V')


# print(round(v_t.mean(), 2) ,' V is the average threshold voltage')
plt.xlabel('$V_{DS}$ (V)')
plt.ylabel('$I_D$ (mA)')
plt.title('Output characteristics')
plt.legend()
plt.grid(True, linestyle='--', alpha=0.6)
plt.tight_layout()

plt.savefig("task7.png", dpi=300)
ro = 0
plt.figure(figsize=(10, 6)) # a new window, 10 x 6 inches
for v_gs, group in df.groupby('V_GS (V)'):
    i_d = group['I_D (mA)']
    v_ds = group['V_DS (V)']
    
    did_dvds = np.gradient(i_d, v_ds) # numerical derivative
    if v_gs == df['V_GS (V)'].max():
            ro = 1 / did_dvds.mean() 
     
    plt.plot(group['V_DS (V)'], did_dvds, marker='o', linewidth=2, label=f'$_{{GS}}$ = {v_gs} V')

print("The output resistance is: ro = 1/gd : ", round(ro, 2) ,"K_\u03A9")
plt.xlabel('Drain Source Voltage $V_{DS}$ (V)')
plt.ylabel('Conductance $g_{d}$ (mA/V)')
plt.title('Differential Conductance $g_{d}$ = d$I_D$/d$V_{DS}$')
plt.legend()
plt.grid(True, linestyle='--', alpha=0.6)
plt.tight_layout()

plt.savefig("task8.png", dpi=300)