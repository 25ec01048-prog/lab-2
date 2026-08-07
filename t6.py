import pandas as pd

df = pd.read_csv(r'ed-1/MOSFET_ID_VDS.csv')

print(df.head()) # the first five rows
print(df.columns) # the exact column names -- check these!
print(df.shape) # (rows, columns)
print(df.describe()) # min, max, mean of every numeric column