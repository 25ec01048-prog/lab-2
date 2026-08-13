import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

df = pd.read_csv(r'ed-1/MOSFET_ID_VGS.csv')

fig, ax = plt.subplots(1,2,figsize=(11, 4.2)) 
v_gs_gm_max = 0
gm_max = 0
v_t = np.array([]) # threshold voltage array
for v_ds, g in df.groupby('V_DS (V)'):
    g = g.sort_values('V_GS (V)') # ALWAYS sort the sweep axis
    gm = np.gradient(g['I_D (mA)'], g['V_GS (V)']) # numerical derivative
    
    highslope_gm = np.where(gm > 0.7 * gm.max())[0][0] # index of the last zero crossing
    
    coef = np.polyfit(g['V_GS (V)'][highslope_gm:], g['I_D (mA)'][highslope_gm:], 1)
    
    v_t_t = -coef[1]/coef[0] # threshold voltage from linear extrapolation
   
    v_t = np.append(v_t, v_t_t)
    polynomial = np.poly1d(coef)

    # 3. Define an extended X-range for extrapolation (e.g., up to x=10)
    x_extended = np.linspace(1, 5, 100)
    y_extrapolated = polynomial(x_extended)

    # 4. Plot the results
    # plt.scatter(x, y, color='blue', label='Original Data')
    ax[0].plot(x_extended, y_extrapolated, linestyle='--', label='Extrapolated Line')
        
        
    if gm_max < gm.max():
        gm_max = gm.max()
        v_gs_gm_max = g['V_GS (V)'].iloc[gm.argmax()]
    
        
    ax[0].plot(g['V_GS (V)'], g['I_D (mA)'], linewidth=2,label=f'$V_{{DS}}$ = {v_ds} V')
    ax[1].plot(g['V_GS (V)'], gm, linewidth=2, label=f'$V_{{DS}}$ = {v_ds} V')
ax[0].set_ylim(-1, df['I_D (mA)'].max() + 0.5)

print(v_t)
print(round(v_t.mean(), 2) ,' V is the average threshold voltage')
ax[0].set_title('Transfer characteristics', fontweight='bold')
ax[0].set_xlabel('$V_{GS}$ (V)'); ax[0].set_ylabel('$I_D$ (mA)')
ax[1].set_title('Transconductance $g_m = dI_D/dV_{GS}$', fontweight='bold')
ax[1].set_xlabel('$V_{GS}$ (V)'); ax[1].set_ylabel('$g_m$ (mA/V)')
ax[1].annotate('Peak $g_m$ ('+ str(round(gm_max, 2)) + "mA/V ," + str(round(v_gs_gm_max, 2))+" V)", xy=(v_gs_gm_max, gm_max), xytext=(v_gs_gm_max + 0.5, gm_max + 0.1),
             arrowprops=dict(facecolor='black', shrink=0.05),)

for a in ax:
    a.grid(True, linestyle='--', alpha=0.6)
    a.legend(fontsize=9)
plt.tight_layout()
plt.savefig('gm_transfer.png', dpi=300) # save BEFORE showplt.show()
