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