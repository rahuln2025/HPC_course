import matplotlib.pyplot as plt
import numpy as np

def plot_scaling(
    core_counts,
    runtimes,
    labels,
    scaling_type='strong',
    baseline_index=0,
    title='Scaling Plot',
    save_as=None
):
    """
    Plot strong or weak scaling curves.
    
    Parameters:
        core_counts: list of arrays, total cores for each config
        runtimes: list of arrays, matching runtime (sec) data
        labels: list of str, label per config (e.g. "Pure MPI", "Hybrid 2x4")
        scaling_type: 'strong' or 'weak'
        baseline_index: index to use for ideal reference line
        title: title of plot
        save_as: filename to save (if any)
    """
    plt.figure(figsize=(8, 6))
    colors = plt.cm.tab10.colors

    for i, (cores, times, label) in enumerate(zip(core_counts, runtimes, labels)):
        plt.plot(cores, times, marker='o', label=label, color=colors[i % 10])

    # Add ideal scaling line
    base_cores = core_counts[baseline_index][0]
    base_time = runtimes[baseline_index][0]

    if scaling_type == 'strong':
        ideal_times = [base_time * base_cores / c for c in core_counts[baseline_index]]
        ideal_label = f"Ideal (1/P from {base_cores} cores)"
    elif scaling_type == 'weak':
        ideal_times = [base_time for _ in core_counts[baseline_index]]
        ideal_label = f"Ideal (constant time)"
    else:
        raise ValueError("scaling_type must be 'strong' or 'weak'")

    plt.plot(core_counts[baseline_index], ideal_times, linestyle='--', color='gray', label=ideal_label)

    plt.xscale('log')
    plt.yscale('log')
    plt.xlabel("Total cores (MPI ranks × threads)")
    plt.ylabel("Runtime [s]")
    # plt.xticks(core_counts[0], rotation=0)
    plt.title(title)
    plt.grid(True, which="both", ls=":")
    plt.legend()
    if save_as:
        plt.savefig(save_as, dpi=300)
    plt.tight_layout()
    plt.show()


# Strong scaling example (fixed 4000x4000 grid)
cores = [ [8, 16, 32, 64],       # Pure MPI
          [8, 16, 32, 64] ]          # Hybrid MPI+OpenMP
times = [ [20.685, 24.458, 28.001, 62.098],     # Example times (MPI) 20.685, 24.458, 28.001, 62.098
          [117.04, 136.652, 197.274, 249.3] ]        # Example times (Hybrid)

labels = ['Pure MPI OMP_NUM_THREADS=1', 'Hybrid (1x8) OMP_NUM_THREADS=8']

plot_scaling(core_counts=cores,
             runtimes=times,
             labels=labels,
             scaling_type='weak',
             baseline_index=0,
             title='Weak Scaling Plot',
             save_as='./snapshots/weak_scaling.png')
