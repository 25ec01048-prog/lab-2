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
    plt.plot(Vd, I, label=f'Ideal factor n = {n}', linewidth=2)
    
plt.xlabel('$V_D$ (V)')
plt.ylabel('$I$ (A)')
plt.title('Diode Current-Voltage Characteristics')
plt.legend()
plt.grid(True, linestyle='--', alpha=0.6)
plt.tight_layout()
plt.savefig("bt1.png", dpi=300)
plt.show()