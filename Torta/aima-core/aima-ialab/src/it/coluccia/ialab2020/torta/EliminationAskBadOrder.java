package it.coluccia.ialab2020.torta;

import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

import aima.core.probability.RandomVariable;
import aima.core.probability.bayes.BayesianNetwork;
import aima.core.probability.bayes.exact.EliminationAsk;

public class EliminationAskBadOrder extends EliminationAsk {
	
	@Override
	protected List<RandomVariable> order(BayesianNetwork bn,
			Collection<RandomVariable> vars) {
		//odds variable first
		List<RandomVariable> varsList = new ArrayList<RandomVariable>(vars);
		LinkedList<RandomVariable> toRet = new LinkedList<>();
		for(int i = 0; i < varsList.size(); i++){
			if(i % 2 == 0){
				toRet.addFirst(varsList.get(i));
			}else{
				toRet.addLast(varsList.get(i));
			}
		}

		return toRet;
	}
}
