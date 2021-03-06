package it.coluccia.ialab2020.torta.project;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
		
		Set<Node> nodesSet = new HashSet<>();
		for(RandomVariable var : nodes.keySet()){
			nodesSet.add(bn.getNode(var));
		}

		int size = nodes.size();
		
		InteractionGraph interGraph = new InteractionGraph(nodesSet);

		for (int counter = 0; counter < size; counter++) {
			// trovo nodo con meno vicini (che non sia stato gi� processato)
			RandomVariable var = interGraph.findNodeWithLessNeighbours();

			// aggiungo arco ad ogni coppia di nodi che sono neighbours ma che
			// non sono adiacenti
			// non tengo in considerazione i nodi presenti in alreadyReturned
			interGraph.addEdgesToNeighbours(var);

			// aggiungo il nodo alla lista ordinata da ritornare
			varsList.add(var);
		}

		/*System.out.println("VARIABLE ELIMINATION MINDEGREE ORDER: ");
		String order = "";
		for(RandomVariable var : varsList){
			order+="|"+var;
		}
		System.out.println(order);*/
		return varsList;
	}

	
}
