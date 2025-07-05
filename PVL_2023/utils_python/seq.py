import numpy as np
import matplotlib.pyplot as plt
import time

# Parameters
grid_size = 500
steps = 200 # number of simulation steps
p = 0.3 # probability of infection
q = 0.2 # probability of recovery
t = 5 # immune period

# encoding
# 0: susceptible, 1: infected, 2: recovered
susceptible = 0
infected = 2
recovered = 1

start = time.time()

# Initialize the random seed for reproducibility
np.random.seed(42)

# create a 2D grid
grid = np.zeros((grid_size, grid_size), dtype=int) # intially all susceptible
immune_period = np.zeros_like(grid, dtype=int) # track immune period

# initialize a few infected individuals
initial_infected = 10
for _ in range(initial_infected):
    # select random cell position
    x, y = np.random.randint(0, grid_size, size=2)
    # check if the cell is susceptible
    while grid[x, y] != susceptible:
        # if not, select another position
        x, y = np.random.randint(0, grid_size, size=2)
    # assign infected state to random cell
    grid[x, y] = infected
    
# visualize the initial state
plt.imshow(grid, cmap='viridis', vmin=0, vmax=2)
plt.title('Initial State')
plt.savefig('py_images/py_initial.png')
plt.close()

# directions for neighbor checking
directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]  # up, down, left, right

# try few steps
for step in range(steps):

    for i in range(grid_size):
        for j in range(grid_size):
            if grid[i, j] == infected:
                # attempt to infect neighbors
                for dx, dy in directions:
                    ni, nj = i + dx, j + dy
                    if 0 <= ni < grid_size and 0 <= nj < grid_size: # stay within bound of grid
                        # check if neighbor is susceptible and infect with probability p
                        if grid[ni, nj] == susceptible and np.random.rand() < p and immune_period[ni, nj] < t:
                            grid[ni, nj] = infected
                # attempt to recover infected cell with probability q
                if np.random.rand() < q:
                    grid[i, j] = recovered
                    immune_period[i, j] = t
                
            elif grid[i, j] == recovered:
                # decrease immune period
                immune_period[i, j] -= 1
                if immune_period[i, j] <= 0:
                    grid[i, j] = susceptible


    
    # visualize the grid at each step
    if step % 10 == 0:  # print progress every 10 steps
        print(f"Step {step + 1}/{steps}")
    
        # # change susceptible and recovered to same color
        # grid_color = np.where(grid == recovered, 0, grid)  # make susceptible 0
        plt.imshow(grid, cmap='viridis', vmin=0, vmax=2)
        plt.title(f'Step {step + 1}')
        # Add legend
        import matplotlib.patches as mpatches
        legend_labels = [
            mpatches.Patch(color=plt.cm.viridis(0/2), label='Susceptible'),
            mpatches.Patch(color=plt.cm.viridis(2/2), label='Infected'),
            mpatches.Patch(color=plt.cm.viridis(1/2), label='Recovered')
        ]
        plt.legend(handles=legend_labels, loc='upper right', bbox_to_anchor=(1.25, 1))
        plt.savefig(f'py_images/py_step_{step + 1}.png', bbox_inches='tight')
        plt.close()

end = time.time()
print(f"Simulation completed in {end - start:.2f} seconds.")