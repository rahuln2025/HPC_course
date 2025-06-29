# PVL for HPC Course

The problem is a disease spread model called as SIR:
- Susceptible (Healthy): Can be infected.
- Infected: Can infect other cells and will become healthy after certain time.
- Recovered (Immune): Temporarily immune after recovering from infection.

We have to simulate a probabilistic model with following rules for state changes: 

1. Infection: A healthy cell adjacent to an infected cell becomes infected with a probability $p$ in the next time step.
2. Recovery: An infected cell has a probability $q$ to become healthy in the next time step.
3. Immunity: Once a cell recovers, it becomes immune for $t$ time steps. After this immunitiy period, the cell becomes susecptible again. 

Simulation runs for a predefined number of time steps or until a steady state is reached. Initially, a few cells are randomly marked infected to start disease spread. 

In my opinion, it is more like a cellular automata problem. 

## Steps for the project: 

1. Try $p = 0.2, q = 0.3, t = 10$ and start with 5 initial infections at random cells. 
2. First, a Python code to implement the problem and get a quick understanding. This code will be sequential. 
3. Translate Python code to C++, but again sequential in nature. Check if the implementation is correct and add visualization. 
4. Select a grid size such that the sequential run time is between 100s to 400s. 
5. Perform hybrid MPI/OpenMP parallelization:
    a. First MPI implementation: distribute the grid in horizontal (bunch of rows) patches between MPI ranks. Set up MPI Send/Receive or other communication means between rows at boundaries of patches. 
    b. For all for loops that will be computed within the MPI ranks, apply OpenMP. 
    c. Keep both versions separately for comparison: only MPI and hybrid.
6. Perform strong and weak scalability tests. 

### Some glimpses of the results

### Banded Rows issue

To fix the "banded output" issue caused by improper ghost row handling, I took these steps:

Tracked Infection Attempts Across Boundaries:
I introduced two buffers, infect_top and infect_bottom, to record when an infection should spread into a neighboring rank’s ghost row (i.e., when a cell at the edge of a local grid tries to infect a cell just outside its boundary).

Marked Ghost Row Infections During Update:
During the infection loop, if an infection would spread into a ghost row (above the first row or below the last row of the local grid), I set the corresponding entry in infect_top or infect_bottom to 1.

Exchanged Infection Buffers With Neighbors:
After the main update loop, I used MPI_Sendrecv to exchange the infect_top and infect_bottom buffers with neighboring ranks. This way, each rank receives information about which of its edge cells should become infected due to neighbor activity.

Applied Received Infections to Edge Rows:
After receiving infection buffers from neighbors, I updated the first and last rows of the local grid accordingly, setting cells to INFECTED if the received buffer indicated an infection and the cell was still SUSCEPTIBLE.

Result:
This ensures that infections propagate across rank boundaries in the same simulation step, eliminating the artificial "banded" pattern and producing a smooth, physically correct spread.

### Pseudocode

#### initialization

```sql
Initialize MPI
Get rank and size
Parse command-line arguments: grid_size, steps, infection_prob (p), recovery_prob (q), immunity_duration (t)

Divide the grid among MPI ranks:
    local_rows = grid_size / number_of_ranks
    Allocate local_grid[local_rows][grid_size]
    Allocate local_immune_period[local_rows][grid_size]

Initialize local_grid with initial infected state (e.g., a central infection)
Initialize output_matrix if rank == 0
```

#### main simulation loop
``` sql

directions = [(−1,0), (1,0), (0,−1), (0,1)] // Up, Down, Left, Right

for step in 0 to steps-1:
    
    // --------- Collect and Gather Data (for output) ---------
    Flatten local_grid to flat_local_grid
    Gather all local grids to flat_gathered_grid on root (MPI_Gatherv)

    if rank == 0 and step % 100 == 0:
        Append flat_gathered_grid to output_matrix

    // --------- Initialize Grid Copies for Updates ---------
    new_local_grid = local_grid
    new_local_immune_period = local_immune_period

    // --------- Exchange Ghost Rows ---------
    if rank > 0:
        Send top row to rank-1 and receive its bottom row as recv_top

    if rank < size-1:
        Send bottom row to rank+1 and receive its top row as recv_bottom

    // --------- Initialize Infection Flags for Ghosts ---------
    infect_top = [0] * grid_size
    infect_bottom = [0] * grid_size

    // --------- Loop Over Local Grid ---------
    for i in 0 to local_rows-1:
        for j in 0 to grid_size-1:

            if cell is INFECTED:
                For each direction (ni, nj):
                    if neighbor is inside local_grid:
                        get neighbor_val
                    else if neighbor is in recv_top or recv_bottom:
                        get neighbor_val

                    if neighbor_val is SUSCEPTIBLE and random < p:
                        Infect it in new_local_grid or mark in infect_top / infect_bottom

                if random < q:
                    Recover current cell and set immune period

            else if cell is RECOVERED:
                Decrease immune counter
                If immune period is over → become SUSCEPTIBLE

    // --------- Exchange Infection Flags ---------
    if rank > 0:
        Send infect_top to rank-1 and receive recv_infect_top from rank-1

    if rank < size-1:
        Send infect_bottom to rank+1 and receive recv_infect_bottom from rank+1

    // --------- Apply Received Ghost Infections ---------
    if rank > 0:
        Infect top row from recv_infect_top if cell was SUSCEPTIBLE

    if rank < size-1:
        Infect bottom row from recv_infect_bottom if cell was SUSCEPTIBLE

    // --------- Finalize Step ---------
    local_grid = new_local_grid
    local_immune_period = new_local_immune_period
```

#### save output

```sql
if rank == 0:
    Write output_matrix to text file ("MPI_v0_1000_1000_output.txt")

Finalize MPI
return 0
```