import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

folder_1 = r'0~1m, step 0.2m, 240KHz sampling/'

def extract_files(folder_name, low, high):
    files = []
    low = int(low*5)
    high = int(high*5)
    for i in range(low, high+1):
        j = i/5.0
        if j.is_integer():
            j = int(j)
            files.append(folder_name + str(j) + 'm.txt')
        else:
            k = round(j, 2)
            files.append(folder_name + str(k) + 'm.txt')
    return files

extracted = extract_files(folder_1, 0.0, 0.2)
fig, ax = plt.subplots(len(extracted))
k = 0

for file in extracted:
    df = pd.read_csv(file, skiprows=8, delimiter=' ')
    ax[k].plot(df)
    ax[k].set_title(round(k*0.2, 2))
    k+=1
fig.set_size_inches(30, 15)
