import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

Is = 1e-12 # A
Vd = np.linspace(0, 0.8, 81) # V
idealityFactors = [1, 1.5, 2]
vt = 0.02585 # V

plt.figure(figsize=(10, 6)) # a new window, 10 x 6 inches
for n in idealityFactors:   
    I = Is * (np.exp(Vd/(n*vt)) - 1)
    gd = np.gradient(I, Vd)  
    x = plt.plot(Vd, I, label=f'Ideal factor n = {n}', linewidth=1,marker='o', alpha=0.2)
    plt.plot(Vd, gd, label=f'Conductance n = {n}', linewidth=2,marker='x', color=x[0].get_color()) 
plt.yscale('log')  # Set the y-axis to logarithmic scale
plt.xlabel('$V_D$ (V)')
plt.ylabel('$I$ (A)')
plt.title('Diode Current-Voltage Characteristics')
plt.legend()
plt.grid(True, linestyle='--', alpha=0.6)
plt.tight_layout()
plt.savefig("bt4.png", dpi=300)
