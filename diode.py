import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

df = pd.read_csv(r'ed-1/Diode_IV_Temperature.csv')

for t, group in df.groupby('T (C)'):
    # v_t = np.append(v_t, np.polyfit(group['V_GS (V)'], group['I_D (mA)'], 2)[0]) 
    plt.plot(group['V (V)'], group['I (mA)'], marker='o', linewidth=2, label=rf'$_{{T}}$ = {t}$^\circ$C')

plt.xlabel('Voltage $V$ (V)')
plt.ylabel('Current $I$ (mA)')
plt.title('Diode I-V Characteristics at Different Temperatures')
plt.legend()
plt.grid(True, linestyle='--', alpha=0.6)
plt.tight_layout()
plt.savefig("task11.png", dpi=350)