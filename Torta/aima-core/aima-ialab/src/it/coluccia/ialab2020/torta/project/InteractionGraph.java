package it.coluccia.ialab2020.torta.project;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import aima.core.probability.RandomVariable;
import aima.core.probability.bayes.Node;

/**
 * It represents the interaction graph used in MinFill and MinDegre order for VA algorithm
 * @author Miggianox94
 *
 */
public class InteractionGraph {

	// key: randomVar; values: set of randomvar linked
	private Map<RandomVariable,Set<RandomVariable>> graph;
	private Set<RandomVariable> alreadyReturned;
	
	public InteractionGraph(Set<Node> nodes){
		this.graph = new HashMap<>();
		this.alreadyReturned = new HashSet<>();
		for(Node node : nodes){
			Set<RandomVariable> randVarOn = new HashSet<>(node.getCPD().getFor());
			graph.put(node.getRandomVariable(), randVarOn);
		}
	}
	
	public RandomVariable findNodeWithLessNeighbours(){
		RandomVariable lessNode = null;
		int minNumber = Integer.MAX_VALUE;
		for (RandomVariable var : graph.keySet()) {
			if(alreadyReturned.contains(var)){
				continue;
			}
			int numberNeighbours = getNeighbours(var).size();
			if (numberNeighbours < minNumber) {
				minNumber = numberNeighbours;
				lessNode = var;
			}
		}
		alreadyReturned.add(lessNode);
		return lessNode;
	}
	
	
	public RandomVariable findNodeWithLessAddedEdges() {
		RandomVariable lessNode = null;
		int minNumber = Integer.MAX_VALUE;
		for (RandomVariable var : graph.keySet()) {
			if(alreadyReturned.contains(var)){
				continue;
			}

			int numberEdges = countEdgesAddedToNeighbours(var);
			if (numberEdges < minNumber) {
				minNumber = numberEdges;
				lessNode = var;
			}
		}
		alreadyReturned.add(lessNode);
		return lessNode;
	}
	
	private int countEdgesAddedToNeighbours(RandomVariable var){
		int counter = 0;
		for(RandomVariable neighbour : this.graph.get(var)){
			if(alreadyReturned.contains(neighbour)){
				continue;
			}
			for(RandomVariable neighbour2 : this.graph.get(var)){
				if(alreadyReturned.contains(neighbour2)){
					continue;
				}
				//eseguo direttamente le add in quanto sono Set
				if(this.graph.get(neighbour) != null){
					if(!this.graph.get(neighbour).contains(neighbour2)){
						counter++;
					}	
				}
				if(this.graph.get(neighbour2) != null){	
					if(!this.graph.get(neighbour2).contains(neighbour)){
						counter++;
					}	
				}
			}
		}
		return counter;
		
	}
	
	/**
	 * It adds edges to neighbours of var that are not neighbours between them
	 * It not consider alreadyReturned
	 * @param var
	 */
	public void addEdgesToNeighbours(RandomVariable var){
		for(RandomVariable neighbour : this.graph.get(var)){
			if(alreadyReturned.contains(neighbour)){
				continue;
			}
			for(RandomVariable neighbour2 : this.graph.get(var)){
				if(alreadyReturned.contains(neighbour2)){
					continue;
				}
				//eseguo direttamente le add in quanto sono Set
				if(this.graph.get(neighbour) != null){
					this.graph.get(neighbour).add(neighbour2);	
				}else{
					this.graph.put(neighbour,new HashSet<>());
					this.graph.get(neighbour).add(neighbour2);	
				}
				if(this.graph.get(neighbour2) != null){
					this.graph.get(neighbour2).add(neighbour);	
				}else{
					this.graph.put(neighbour2,new HashSet<>());
					this.graph.get(neighbour2).add(neighbour);	
				}
			}
		}
	}
	
	/**
	 * It returns the var neigbours.
	 * It not consider the alreadyReturned as neighbour
	 * @param var
	 * @return
	 */
	private Set<RandomVariable> getNeighbours(RandomVariable var){
		Set<RandomVariable> neighbours = this.graph.get(var);
		neighbours.removeAll(alreadyReturned);
		return neighbours;
	}
	
}
