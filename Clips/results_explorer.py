import numpy as np
import matplotlib.pyplot as plt
from matplotlib import colors

def main():
    num_fire_ok = 0
    num_fire_ko = 0
    num_guess_ok = 0
    num_guess_ko = 0
    num_safe = 0
    num_sink = 0

    fire_x = []
    fire_y = []
    guess_x = []
    guess_y = []

    with open("debug.log") as file:  
        for line in file: 
            if "[STATISTICS]" in line:
                line = line.replace('[STATISTICS]','')
                num_fire_ok,num_fire_ko,num_guess_ok,num_guess_ko,num_safe,num_sink = line.split("|")
            elif "[FIRE]" in line:
                line = line.replace('[FIRE]--','').replace('\n','')
                x,y = line.split("|")
                fire_x.append(int(x))
                fire_y.append(int(y))
            elif "[GUESS]" in line:
                line = line.replace('[GUESS]--','').replace('\n','')
                x,y = line.split("|")
                guess_x.append(int(x))
                guess_y.append(int(y))
    print("num_fire_ok:",num_fire_ok,"\nnum_fire_ko:",num_fire_ko,"\nnum_guess_ok:",num_guess_ok,"\nnum_guess_ko:",num_guess_ko,"\nnum_safe:",num_safe,"\nnum_sink:",num_sink)      
    print("fire_x:",fire_x,"\nfire_y:",fire_y,"\nguess_x:",guess_x,"\nguess_y:",guess_y)

    m = [
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    ]


    i = 0
    for x in fire_x:
        m[x-1][fire_y[i]-1] = 1
        i+=1
    
    i = 0
    for x in guess_x:
        m[x-1][guess_y[i]-1] = 2
        i+=1

    cmap = colors.ListedColormap(['Blue','red','yellow'])
    plt.figure(figsize=(10,10))
    plt.pcolor(m,cmap=cmap,edgecolors='k', linewidths=3)
    plt.xticks(np.arange(1,10,step=1))
    plt.yticks(np.arange(1,10,step=1))
    plt.show()
if __name__ == "__main__":
    main()