# plot_sir_simulation.py

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation

# Parameters (must match your C++ simulation)
grid_size = 10  # Change if your grid size is different

# Read sir_output.txt
with open("sir_MPI_v0_output.txt", "r") as f:
    data = [list(map(int, line.strip().split())) for line in f]

steps = len(data)
print(f"Loaded {steps} steps.")

# Convert to numpy array for easier slicing
data = np.array(data)
assert data.shape[1] == grid_size * grid_size, "Grid size mismatch!"

# Prepare figure
fig, ax = plt.subplots(figsize=(6, 6))
im = ax.imshow(data[0].reshape((grid_size, grid_size)), cmap='viridis', vmin=0, vmax=2)
ax.set_title("SIR Simulation")

def update(frame):
    im.set_data(data[frame].reshape((grid_size, grid_size)))
    ax.set_title(f"SIR Simulation - Step {frame+1}/{steps}")
    return [im]

ani = animation.FuncAnimation(fig, update, frames=steps, interval=10, blit=True)
ani.save("sir_simulation_MPI_v0_output.gif", fps=10)