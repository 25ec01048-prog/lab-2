# Task -1 
Python : 3.13.12 \
numpy : 2.5.1   \
pandas : 3.0.5  \
matplotlib: 3.11.1 

![Task 1](task1.webp "plot - 1")

# Task -2

* e7a43da (HEAD -> main) removed line to checkup_setup.py
* 2976d4e added line to checkup_setup.py
* 879ce81 first commit

# Task -4 

![Task 4](task3.png )


# Task -5 


![Task 5](task5.png )

# Task -6
####     V_GS (V)  V_DS (V)  I_D (mA)
0       2.0       0.0      0.00\
1       2.0       0.5      0.48\
2       2.0       1.0      0.50\
3       2.0       1.5      0.51\
4       2.0       2.0      0.52\
<br>
Index(['V_GS (V)', 'V_DS (V)', 'I_D (mA)'], dtype='str')
<br>
(44, 3)
####       V_GS (V)   V_DS (V)   I_D (mA)
count  44.00000  44.000000  44.000000\
mean    3.50000   2.500000   7.841591\
std     1.13096   1.599418   7.904722\
min     2.00000   0.000000   0.000000\
25%     2.75000   1.000000   0.557500\
50%     3.50000   2.500000   4.605000\
75%     4.25000   4.000000  12.255000\
max     5.00000   5.000000  24.150000


# Task -7
 <br>

![Task 7](task7.png )


# Task -8
 ro = 1/gd :  0.2 KΩ 
 <br>

![Task 8](task8.png )

# Task -9

![Task 9](gm_transfer.png )

# Task - 10
```python
    v_t = np.array([])
    for v_ds, g in df.groupby('V_DS (V)'):
        v_t = np.append(v_t, np.polyfit(g['V_S (V)'], g['I_D (mA)'], 2)[0])
    print(round(v_t.mean(), 2) ,' V is the average threshold voltage')

```
Output = 1.11  V is the average threshold voltage

# Task - 11 

![Task 11](task11.png )
