from scipy.optimize import minimize
from quantum import sampleMethod
import networkx as nx
# HostPython represents the namespace of the Q# program
# sampleMethod  represents the method that we are taking from Q# - in this program this should be the method with the quantum circuits
# Remember to change the names of these 2 

def makeGraph(): ## Not flexible, must edit this code based on problem before running
    graph = nx.Graph()
    graph.add_nodes_from([0, 1, 2, 3]) 
    graph.add_edges_from([(0, 1), (1, 2), (2, 3), (3, 0)])
    nx.draw(graph, with_labels=True, alpha=0.8, node_size=500) ## Don't need to edit this

    return graph


def compute_expectation(counts, graph):
    """Computes expectation value based on measurement results
    Args:
        counts: (dict) key as bit string, val as count
        graph: networkx graph
    Returns:
        avg: float
             expectation value
    """
    avg = 0
    sum_count = 0
    for bit_string, count in counts.items():
        obj = maxcut_obj(bit_string, graph)
        avg += obj * count
        sum_count += count

    return avg/sum_count

def main():
    measurement = sampleMethod.simulate() ## This will the execution of the quantum circuit and return the measurements
    counts = measurement.results().get_counts()
    graph = makeGraph()

    expectation = compute_expectation(counts, graph) ## graph is a diagram of our nodes
    res = minimize(expectation,[1.0, 1.0], method='COBYLA')

    return res ## optimized value

main()

