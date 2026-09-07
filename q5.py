import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

df = pd.read_csv('q5.csv')

vds = ["V_D=0.05", "V_D=0.4"]
fig , ax = plt.subplots(1, 2, figsize=(8,6))
v_t = np.array([])
for i,v in enumerate(vds):
    df_v = df.sort_values(by=(v+" X"))
    y = ax[0].plot(df_v[v+" X"], df_v[v+" Y"], label=v+" (V)")
    gm = np.gradient( df_v[v+" Y"],df_v[v+" X"],) # numerical derivative
    
    highslope_gm = np.where(gm > 0.5 * gm.max())[0][0] # index of the last zero crossing
    
    coef = np.polyfit(df_v[v+ " X"][highslope_gm:], df_v[v+" Y"][highslope_gm:], 1)
    
    v_t_t = -coef[1]/coef[0] # threshold voltage from linear extrapolation
   
    v_t = np.append(v_t, v_t_t)
    polynomial = np.poly1d(coef)

    # 3. Define an extended X-range for extrapolation (e.g., up to x=10)
    x_extended = np.linspace(0, 3, 100)
    y_extrapolated = polynomial(x_extended)

    # 4. Plot the results
    # plt.scatter(x, y, color='blue', label='Original Data')
    ax[0].plot(x_extended, y_extrapolated, linestyle='--', label='Extrapolated Line', color=y[0].get_color())

print(v_t)
print(round(v_t.mean(), 2) ,' V is the average threshold voltage')
ax[0].text(0.5, 0.0005, f'$V_{{TH}} = {round(v_t.mean(), 2)} V$', fontsize=10, color='black', ha='center')
ax[0].set_xlabel(f'$V_{{GS}}$ V')
ax[0].set_ylabel(f'$I_{{D}}$ A')
ax[0].set_title(f'$I_{{D}}$ A - $V_{{GS}}$ V')
ax[0].grid(True, linestyle='--', alpha=0.6)
ax[0].legend()

## subthrehold loagrathmic graph
ax2 = ax[1].twinx()  # Create a secondary y-axis for the logarithmic plot
v_t = np.array([])
for i,v in enumerate(vds):
    df_v = df.sort_values(by=(v+" X"))
    y_log = df_v[v+" Y"].apply(lambda x: np.log10(x) if x > 0 else np.nan) # Apply log10 to Y values, handling non-positive values
    y = ax[1].plot(df_v[v+" X"], df_v[v+" Y"], label=v+" (V)")
    gm = np.gradient(y_log,df_v[v+" X"]) # numerical derivative
    # print(gm)
    highslope_gm_beg = np.where(gm > 0.9 * gm.max())[0][0] 
    highslope_gm_end = np.where(gm > 0.9 * gm.max())[0][-1] # index of the last zero crossing
    # print(highslope_gm)
    coef = np.polyfit(df_v[v+ " X"][highslope_gm_beg:highslope_gm_end],y_log[highslope_gm_beg:highslope_gm_end], 1)
    # print(coef)
    v_t_t = -coef[1]/coef[0] # threshold voltage from linear extrapolation
   
    v_t = np.append(v_t, v_t_t)
    polynomial = np.poly1d(coef)
    # print(polynomial.roots)
    # 3. Define an extended X-range for extrapolation (e.g., up to x=10)
    x_extended = np.linspace(v_t_t, df_v[v+" X"][highslope_gm_end]+0.5, 100)
    y_extrapolated = polynomial(x_extended)
    
    
    ax2.plot(x_extended, y_extrapolated, linestyle='--', label='Extrapolated Line', color=y[0].get_color())

ax[1].set_yscale('log')  # Set the y-axis to logarithmic scale
print(round(v_t.mean(), 2) ,' V is the average subthreshold voltage')
ax[1].text(0.5, 0.0005, f'$V_{{TH}} = {round(v_t.mean(), 2)} V$', fontsize=10, color='black', ha='center')
ax[1].set_xlabel(f'$V_{{GS}}$ V')
ax[1].set_ylabel(f'$I_{{D}}$ A')
ax[1].set_title(f'$I_{{D}}$ A - $V_{{GS}}$ V Characteristics ')
ax[1].grid(True, linestyle='--', alpha=0.6)
ax[1].legend()
plt.tight_layout()
plt.savefig('q5.png', dpi=600)
