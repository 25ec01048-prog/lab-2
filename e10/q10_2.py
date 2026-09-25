import matplotlib.pyplot as plt
import numpy as np
import pandas as pd




## id_on

id_onoff = pd.read_csv('e10_2_idonoff.csv')
print("id_on=", np.format_float_scientific(np.mean(id_onoff['id_on_0'].array), precision=2), "when Q_f = 0 C/cm^2 ")
print("id_off=", np.format_float_scientific(np.mean(id_onoff['id_off_0'].array), precision=2), "when Q_f = 0 C/cm^2 ")
print("id_on=", np.format_float_scientific(np.mean(id_onoff['id_on_4.28'].array), precision=2), "when Q_f = 4.28e10 C/cm^2 ")
print("id_off=", np.format_float_scientific(np.mean(id_onoff['id_off_4.28'].array), precision=2), "when Q_f = 4.28e10 C/cm^2 ")

print("breakdown Q_f = 0 C/cm^2  ,  v = 0.056 v")
print("breakdown Q_f = 4.28e10 C/cm^2  , v = 0.064 v")

qf = ["Qf=0", "Qf=4.28e10"]
df_id_vd = pd.read_csv('e10_2_id_vd.csv')
figure,ax = plt.subplots(1,2,figsize=(11,6))


for i in qf:
    df_v = df_id_vd.sort_values(by=(i+"-X"))
    y = ax[0].plot(df_v[i+"-X"], df_v[i+"-Y"], label=i+" (V)")

ax[0].set_xlabel(f'$V_{{DS}}$ V')
ax[0].set_ylabel(f'$I_{{D}}$ A')
ax[0].set_title(f'Output Characteristics of MOSFET $V_{{GS}}$ = 1.5 V')
ax[0].grid(True, linestyle='--', alpha=0.6)
ax[0].legend()


df_id_vg = pd.read_csv('e10_2_id_vg.csv')

for i in qf:
    df_v = df_id_vg.sort_values(by=(i+"-X"))
    y = ax[1].plot(df_v[i+"-X"], df_v[i+"-Y"], label=i+" (V)")
    g = np.gradient(df_v[i+"-Y"],df_v[i+"-X"])
    gmax = g.max()
    
    g_range = np.where(g > 0.9 * gmax)[0]
    gLinearpolation = np.polyfit(df_v[i+"-X"][g_range], df_v[i+"-Y"][g_range], 1)
    
    x_intercept = -gLinearpolation[1] / gLinearpolation[0]
    ax[1].axvline(x=x_intercept, color=y[0].get_color(), linestyle=':', label=f'$V_{{TH}}$ ({x_intercept:.2f} V)')
    
    leploy = np.poly1d(gLinearpolation) 
    x_extrapolated = np.linspace(0, 3, 100)    
    y_extrapolated = leploy(x_extrapolated)
    ax[1].plot(x_extrapolated, y_extrapolated, linestyle='--', color=y[0].get_color(), label='Extrapolated Line')

ax[1].set_ylim(-0.0001,df_id_vg[[i+"-Y" for i in qf]].max().max()+0.0001 )  
ax[1].set_xlabel(f'$V_{{GS}}$ V')
ax[1].set_ylabel(f'$I_{{D}}$ A')
ax[1].set_title(f'Transfer Characteristics of MOSFET $V_{{DS}}$ = 0.4 V')
ax[1].grid(True, linestyle='--', alpha=0.6)
ax[1].legend()

plt.tight_layout()
plt.savefig('e10_2.png', dpi=600)
plt.show()