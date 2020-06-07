package it.coluccia.ialab2020.torta.project;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import aima.core.probability.RandomVariable;
import aima.core.probability.bayes.BayesianNetwork;
import aima.core.probability.bayes.Node;
import aima.core.probability.bayes.exact.EliminationAsk;
import aima.core.probability.bayes.impl.BayesNet;

/**
 * It implements mindegree algorithm to order variables in a bayesian network
 *
 */
public class EliminationMinDegree extends EliminationAsk {

	@Override
	protected List<RandomVariable> order(BayesianNetwork bn, Collection<RandomVariable> vars) {

		BayesNet network = (BayesNet) bn;
		Map<RandomVariable, Node> nodes = network.getVarToNodeMap();

		List<RandomVariable> varsList = new ArrayList<RandomVariable>();

		int size = nodes.size();

		for (int counter = 0; counter < size; counter++) {
			// trovo nodo con meno vicini (che non sia stato gi� processato)
			RandomVariable var = findNodeWithLessNeighbours(nodes, varsList);

			// aggiungo arco ad ogni coppia di nodi che sono neighbours ma che
			// non sono adiacenti
			// non tengo in considerazioni i nodi presenti in varlist
			addEdgesToNeighbours(nodes, var, varsList);

			// aggiungo il nodo alla lista ordinata da ritornare
			varsList.add(var);
		}

		return varsList;
	}

	/**
	 * It modifies the network nodes connecting the non adjacent neighbours of node var
	 * connected. It doesn't consider the nodes in list notConsidered
	 * @param nodes
	 * @param notConsidered
	 * @return
	 */
	private void addEdgesToNeighbours(Map<RandomVariable,Node> nodes, RandomVariable var, List<RandomVariable> notConsidered){
		
		Set<Node> neighbours = getNeighbours(nodes.get(var), notConsidered);
		
		for(Node node : neighbours){
			Set<Node> neigh1 = getNeighbours(node,notConsidered);
			for(Node node2 : neighbours){
				if(node.equals(node2)){
					continue;
				}
				if(!neigh1.contains(node2)){
					//aggiungilo tra i children di neigh1
					//alla prossima iterazione comparir� tra i neighbours quindi non viene aggiunto due volte
					node.getChildren().add(node2);
				}
			}
		}
		
	}

	/**
	 * It return the RandomVariable associated to the node with less neighbours
	 * in nodes network. The nodes in notConsidered are not evaluated in this
	 * computation
	 * 
	 * @param nodes
	 * @param varsList
	 * @return
	 */
	private RandomVariable findNodeWithLessNeighbours(Map<RandomVariable, Node> nodes,
			List<RandomVariable> notConsidered) {
		RandomVariable lessNode = null;
		int minNumber = Integer.MAX_VALUE;
		for (RandomVariable var : nodes.keySet()) {
			if(notConsidered.contains(var)){
				continue;
			}
			Node node = nodes.get(var);
			int numberNeighbours = getNeighbours(node, notConsidered).size();
			if (numberNeighbours < minNumber) {
				minNumber = numberNeighbours;
				lessNode = var;
			}
		}

		return lessNode;
	}

	/**
	 * It returns the node neighbours not considering the nodes in notConsidered
	 * list
	 * 
	 * @param node
	 * @param notConsidered
	 * @return
	 */
	private Set<Node> getNeighbours(Node node, List<RandomVariable> notConsidered) {
		Set<Node> neighbours = new HashSet<>(node.getChildren());
		neighbours.addAll(node.getParents());

		Set<Node> filtered = neighbours.stream().filter(c -> !notConsidered.contains(c.getRandomVariable()))
				.collect(Collectors.toSet());

		return filtered;

	}
}
