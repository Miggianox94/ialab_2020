package aima.core.probability.bayes.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import aima.core.probability.CategoricalDistribution;
import aima.core.probability.Factor;
import aima.core.probability.RandomVariable;
import aima.core.probability.bayes.BayesianNetwork;
import aima.core.probability.bayes.Node;
import aima.core.probability.bayes.exact.EliminationAsk;
import aima.core.probability.proposition.AssignmentProposition;

public class IalabDBN extends DynamicBayesNet {

	// It is the current slice of the rollupfiltering algorithm
	private DynamicBayesNet currentSlice;


	public IalabDBN(BayesianNetwork priorNetwork, Map<RandomVariable, RandomVariable> X_0_to_X_1,
			Set<RandomVariable> E_1, Node[] rootNodes) {
		super(priorNetwork, X_0_to_X_1, E_1, rootNodes);
		this.currentSlice = new DynamicBayesNet(priorNetwork, X_0_to_X_1, E_1, rootNodes);

	}

	public IalabDBN(BayesianNetwork priorNetwork, Map<RandomVariable, RandomVariable> X_0_to_X_1,
			Set<RandomVariable> E_1, Node[] rootNodes, DynamicBayesNet currentSlice) {
		super(priorNetwork, X_0_to_X_1, E_1, rootNodes);
		this.currentSlice = currentSlice;

	}

	
	/**
	 * It brings the network one slice forward
	 * @param observations
	 * @param inference
	 * @param factors_last_step
	 * @param queryVars
	 * @return
	 */
	public List<Factor> forward(AssignmentProposition[] observations, EliminationAsk inference, Set<Factor> factors_last_step,List<RandomVariable> queryVars) {

		List<Factor> factors = new ArrayList<>();

		factors = inference.eliminationAskWithFactors(queryVars.toArray(new RandomVariable[queryVars.size()]), observations, currentSlice, new HashSet<>(factors_last_step));
		
		return factors;
		
		

	}

	public DynamicBayesNet getCurrentSlice() {
		return currentSlice;
	}

}
