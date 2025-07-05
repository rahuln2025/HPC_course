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
    - First MPI implementation: distribute the grid in horizontal (bunch of rows) patches between MPI ranks. 
    - For all for loops that will be computed within the MPI ranks, apply OpenMP. 
    - Keep both versions separately for comparison: only MPI and hybrid.
6. Perform strong and weak scalability tests. 

### A glimpse of the simulation results

![Simulation GIF](assets/MPI_v0_500_1000_output.gif)

500x500 grid starting with 5 random cells being infected and how the infection spreads over 1000 steps. 



### Scaling

Ref. sequential time for 4000x4000 grid with 1000 steps: 708.891 ms

#### Strong scaling
The problem size: 4000x4000 grid with 1000 steps. MPI Only and hybrid. For hybrid ```OMP_NUM_THREADS=8``` for the same cases as that of MPI Only. 

![Strong Scaling](assets/strong_scaling3.png)

#### Weak scaling
The problem size is increase proportionally as the cores are increased. It is attempted to ensure that the per rank core grid remains 1000x1000. For hybrid ```OMP_NUM_THREADS=8``` for the same cases as that of MPI Only. 

![Weak Scaling](assets/weak_scaling2.png)


### Overview Pseudocode

1. Initialize Program
    - Setup MPI environment
    - Define simulation parameters
    - Setup random number generation

2. Setup Grid
    - Create initial grid on rank 0
    - Calculate distribution across ranks [Logic](#calculate-row-distribution-among-ranks)
    - Scatter grid portions to all ranks

3. Main Simulation Loop
    - Gather current state for output
    - Exchange ghost rows with neighbors [Logic](#exchange-the-ghost-rows-before-update)
    - Process local grid section
      - Handle infections
      - Process recoveries
      - Update immunity timers
    - Share boundary infections [Logic](#update-ghost-rows-from-neighboring-local-grids)
    - Update for next iteration

4. Finalize
    - Save final output
    - Cleanup MPI

#### Calculate row distribution among ranks

![Row Distribution](assets/local_row_dist.png)

In this diagram:
- The original 10×10 grid is divided horizontally among 4 ranks
- Each process gets ```int(10/2) = 2``` rows (plus 1 row distributed to all ranks with index less than 2)
- Each process owns a local section (some rows) of the complete grid
- The number of elements (```sendcounts```) and the row-start positions (```displs```) are also computed
- Using ```MPI_Scatterv```, the complete grid is distributed among all ranks

Pseudocode section: [pesudocode](#grid-distribution)

#### Exchange the ghost rows before update

![Ghost Row Exchange](assets/update_ghost_rows.png)

In this diagram, we are talking about rank 1, i.e. the actions rank 1 has to do. 

The general ghost row exchange process:
1. Each rank sends its top row to rank-1 and receives bottom row from rank-1
2. Each rank sends its bottom row to rank+1 and receives top row from rank+1
3. These ghost rows allow proper infection spread across ranks boundaries
4. Rank 0 does not need to send anything to prev. rank and last rank does not need to send anything to the next rank. Thus we get the for loop conditions.

Here's the relevant pseudocode:
```cpp
    // --- Exchange ghost rows ---
    if rank > 0:
        MPI_Sendrecv(first row of local_grid → rank-1,
                     recv_top ← rank-1's bottom row)
    
    if rank < size-1:
        MPI_Sendrecv(last row of local_grid → rank+1,
                     recv_bottom ← rank+1's top row)
```

#### Update ghost rows from neighboring local grids

![Ghost Row Updates](assets/first_exchange_ghost_rows.png)

The ghost row update process:
1. During computation, ranks track attempted infections across boundaries using the flags ```infect_bottom``` and ```infect_top```. 
2. After main computation, infection attempts are exchanged:
   - Send infection flags up/down to neighbors (```infect_bottom``` and ```infect_top```)
   - Receive infection flags from neighbors (in buffers ```recv_infect_top``` and ```recv_infect_bottom```.) 
3. Apply received infections to edge rows based on the info. recevied from buffers.
4. This ensures seamless infection spread across process boundaries. *Without this exhange, you will obtain banded disease spread indicating that the boundary (ghost) rows are not being updated.*

The variable names are a bit tricky, here I explain them:
- Flags know which edge rows of the prev. or next rank are going to be infected based on the updated states in the local grid.
    - ```infect_bottom```: flag for the bottom ghost row infections of a local grid.
    - ```infect_top```: flag for the top ghost row infections of a local grid.
- Buffers are present to receive the information from the flags to neighboring local grids. 
    - ```recv_infect_top``` stores the received flag ```infect_bottom``` from the prev. rank (top local grid).
    - ```recv_infect_bottom``` stores the received flag ```infect_top``` from the next rank (bottom local grid). 

I think this section is the most tricky part of the the whole assignment. 

Here's the relevant pseudocode. Check out the main simulation loop's process local grid part to see how the infection state is updated in the flags. Once we have the flags, now we exchange the info. and spread the edge infections: 
```cpp
    // --- Exchange infection information ---
    if rank > 0:
        MPI_Sendrecv(infect_top → rank-1,
                     recv_infect_top ← rank-1)
    
    if rank < size-1:
        MPI_Sendrecv(infect_bottom → rank+1,
                     recv_infect_bottom ← rank+1)
    
    // --- Apply received infections ---
    if rank > 0:
        for j = 0 to grid_size-1:
            if recv_infect_top[j] == 1 and new_local_grid[0][j] is SUSCEPTIBLE:
                new_local_grid[0][j] = INFECTED
    
    if rank < size-1:
        for j = 0 to grid_size-1:
            if recv_infect_bottom[j] == 1 and new_local_grid[local_rows-1][j] is SUSCEPTIBLE:
                new_local_grid[local_rows-1][j] = INFECTED
```

## Granular Pseudocode

### Initialization

```cpp
// Initialize MPI and get rank info
Initialize MPI
Get rank and size from MPI_COMM_WORLD

// Set simulation parameters
grid_size = 4000
steps = 1000
infection_prob (p) = 0.5
recovery_prob (q) = 0.3
immunity_duration (t) = 5
initial_infected = 5

// Initialize random number generator
rng = create random number generator with time-based seed
prob_dist = uniform distribution [0.0, 1.0]
grid_dist = uniform distribution [0, grid_size-1]

// Create full grid on rank 0
if rank == 0:
    full_grid = create 2D vector[grid_size][grid_size] initialized to SUSCEPTIBLE
    full_immune_period = create 2D vector[grid_size][grid_size] initialized to 0
    
    // Randomly place initial infections
    for k = 0 to initial_infected-1:
        do:
            x = random from grid_dist
            y = random from grid_dist
        while full_grid[x][y] is not SUSCEPTIBLE
        full_grid[x][y] = INFECTED
```

### Grid Distribution
```cpp
// Calculate distribution of rows among ranks
rows_per_rank = grid_size / size
extra_rows = grid_size % size
for each rank i:
    if i < extra_rows:
        sendcounts[i] = (rows_per_rank + 1) * grid_size
    else:
        sendcounts[i] = rows_per_rank * grid_size
    displs[i] = sum of previous sendcounts

// Get local row count for current rank
if rank < extra_rows:
    local_rows = rows_per_rank + 1
else:
    local_rows = rows_per_rank

// Initialize local grids
local_grid = create 2D vector[local_rows][grid_size] initialized to SUSCEPTIBLE
local_immune_period = create 2D vector[local_rows][grid_size] initialized to 0

// Distribute grid using MPI_Scatterv
if rank == 0:
    flatten full_grid to flat_full_grid
flat_local_grid = vector of size local_rows * grid_size
MPI_Scatterv(flat_full_grid, sendcounts, displs, MPI_INT,
             flat_local_grid, local_rows * grid_size, MPI_INT, 0, MPI_COMM_WORLD)

// Reconstruct local 2D grid from flat array
for i = 0 to local_rows-1:
    for j = 0 to grid_size-1:
        local_grid[i][j] = flat_local_grid[i * grid_size + j]
```

### Main Simulation Loop

```cpp
directions = [(−1,0), (1,0), (0,−1), (0,1)]  // Up, Down, Left, Right

for step = 0 to steps-1:
    // --- Gather grid state for output ---
    flatten local_grid to flat_local_grid
    if rank == 0:
        create flat_gathered_grid[grid_size * grid_size]
    
    MPI_Gatherv(flat_local_grid, local_grid_size, MPI_INT,
                flat_gathered_grid, sendcounts, displs, MPI_INT, 0, MPI_COMM_WORLD)
    
    if rank == 0 and step % 100 == 0:
        store flat_gathered_grid in output_matrix
        print current step
    
    // --- Create copies for next state ---
    new_local_grid = copy of local_grid
    new_local_immune_period = copy of local_immune_period
    
    // --- Exchange ghost rows ---
    if rank > 0:
        MPI_Sendrecv(first row of local_grid → rank-1,
                     recv_top ← rank-1's bottom row)
    
    if rank < size-1:
        MPI_Sendrecv(last row of local_grid → rank+1,
                     recv_bottom ← rank+1's top row)
    
    // --- Initialize infection flags ---
    infect_top = array[grid_size] initialized to 0
    infect_bottom = array[grid_size] initialized to 0
    
    // --- Process local grid ---
    for i = 0 to local_rows-1:
        for j = 0 to grid_size-1:
            if local_grid[i][j] is INFECTED:
                // Check all neighbors (up, down, left, right)
                for each direction in directions:
                    ni = i + direction[0]
                    nj = j + direction[1]
                    
                    // Get neighbor state based on location
                    if neighbor within local grid:
                        neighbor_val = local_grid[ni][nj]
                    else if ni == -1 and rank > 0:
                        neighbor_val = recv_top[nj]
                    else if ni == local_rows and rank < size-1:
                        neighbor_val = recv_bottom[nj]
                    
                    // Try to infect susceptible neighbors
                    if neighbor_val is SUSCEPTIBLE and random < p:
                        if neighbor within local grid:
                            new_local_grid[ni][nj] = INFECTED
                        else if ni == -1 and rank > 0:
                            infect_top[nj] = 1
                        else if ni == local_rows and rank < size-1:
                            infect_bottom[nj] = 1
                
                // Try to recover
                if random < q:
                    new_local_grid[i][j] = RECOVERED
                    new_local_immune_period[i][j] = t
            
            else if local_grid[i][j] is RECOVERED:
                new_local_immune_period[i][j] -= 1
                if new_local_immune_period[i][j] <= 0:
                    new_local_grid[i][j] = SUSCEPTIBLE
                    new_local_immune_period[i][j] = 0
    
    // --- Exchange infection information ---
    if rank > 0:
        MPI_Sendrecv(infect_top → rank-1,
                     recv_infect_top ← rank-1)
    
    if rank < size-1:
        MPI_Sendrecv(infect_bottom → rank+1,
                     recv_infect_bottom ← rank+1)
    
    // --- Apply received infections ---
    if rank > 0:
        for j = 0 to grid_size-1:
            if recv_infect_top[j] == 1 and new_local_grid[0][j] is SUSCEPTIBLE:
                new_local_grid[0][j] = INFECTED
    
    if rank < size-1:
        for j = 0 to grid_size-1:
            if recv_infect_bottom[j] == 1 and new_local_grid[local_rows-1][j] is SUSCEPTIBLE:
                new_local_grid[local_rows-1][j] = INFECTED
    
    // --- Update state for next iteration ---
    local_grid = new_local_grid
    local_immune_period = new_local_immune_period

// --- Save final output ---
if rank == 0:
    open file "MPI_v3_{grid_size}_1000_output.txt"
    for each row in output_matrix:
        write row to file with space-separated values
    close file
    print "Simulation complete"

Finalize MPI
```






