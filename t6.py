import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv(r'ed-1/MOSFET_ID_VDS.csv')

print(df.head()) # the first five rows
print(df.columns) # the exact column names -- check these!
print(df.shape) # (rows, columns)
print(df.describe()) # min, max, mean of every numeric column

for v_gs, group in df.groupby('V_GS (V)'):
    print("V_GS =", v_gs, "has", len(group), "points")
     # a new window, 10 x 6 inches
    plt.plot(group['V_DS (V)'], group['I_D (mA)'], marker='o', linewidth=2, label=f'$_{{GS}}$ = {v_gs} V')

plt.xlabel('$V_{DS}$ (V)')
plt.ylabel('$I_D$ (mA)')
plt.title('Output characteristics')
plt.legend()
plt.grid(True, linestyle='--', alpha=0.6)
plt.tight_layout()

plt.savefig("task7.png", dpi=300)