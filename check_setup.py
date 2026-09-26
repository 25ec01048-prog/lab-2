import sys
import numpy as np
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
print("Python :", sys.version.split()[0])
print("numpy :", np.__version__)
print("pandas :", pd.__version__)
print("matplotlib:", matplotlib.__version__)
print("commit-3: 25EC01048")
print("25EC01048 merge check complete.")
print("birthday: 2024-06-05")
# a one-line smoke test of the plotting back-end
plt.plot([0, 1, 2, 3], [0, 1, 4, 9], marker="o")
plt.title("If you can see this window, the setup works")
plt.xlabel("x"); plt.ylabel("f(x) = x^2")
plt.grid(True)
plt.show()
