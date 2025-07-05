# plot_sir_simulation.py

import numpy as np
import matplotlib.pyplot as plt
import sys
import os
#import matplotlib.animation as animation


print("Script name:", sys.argv[0])

if len(sys.argv) > 3:
    grid_size = int(sys.argv[1])
    print(f"Grid size set to {grid_size} from command line argument.")
    output_file = str(sys.argv[2])
    n_snaps = int(sys.argv[3])

# Read sir_output.txt
with open(output_file, "r") as f:
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


snapshot_dir = "snapshots"
os.makedirs(snapshot_dir, exist_ok=True)
subdir = os.path.join(snapshot_dir, output_file[:-4])
os.makedirs(subdir, exist_ok=True)

def update(frame):
    im.set_data(data[frame].reshape((grid_size, grid_size)))
    ax.set_title(f"SIR Simulation - Step {frame+1}/{steps}")
    path = os.path.join(subdir, f"snapshot_{frame+1}.png")
    plt.savefig(path, dpi = 100)
    return [im]



for i in np.linspace(0, steps-1, num = n_snaps, dtype=int):
    update(i)

# ani = animation.FuncAnimation(fig, update, frames=steps, interval=10, blit=True)
# ani.save("sir_simulation_MPI_v0_output.gif", fps=10)