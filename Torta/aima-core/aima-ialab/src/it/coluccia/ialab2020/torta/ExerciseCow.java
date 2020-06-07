package it.coluccia.ialab2020.torta;

import aima.core.probability.CategoricalDistribution;
import aima.core.probability.RandomVariable;
import aima.core.probability.bayes.FiniteNode;
import aima.core.probability.bayes.exact.EliminationAsk;
import aima.core.probability.bayes.impl.BayesNet;
import aima.core.probability.bayes.impl.FullCPTNode;
import aima.core.probability.domain.BooleanDomain;
import aima.core.probability.proposition.AssignmentProposition;
import aima.core.probability.util.RandVar;

/**
 * il programma deve:
 * creare la BN dell’esercizio su ArtificialInsemination(cow.net disponibile su Moodle)
 * inferire la distribuzione P(Pregnancy, Progesterone| blood) con il metodo per eliminazione di variabili
 * confrontare i risultati con quelli ottenuti dalla rete cowPlus.net (disponibile su Moodle)
 *
 */

public class ExerciseCow {
	public static void main(String[] args){
		
		RandVar bloodvar = new RandVar("Blood",new BooleanDomain());
		
		FiniteNode pregnancy = new FullCPTNode(new RandVar("Pregnancy",new BooleanDomain()),
				new double[] { 0.87, 0.13 });
		FiniteNode progesterone = new FullCPTNode(new RandVar("Progesterone",new BooleanDomain()),
				new double[] { 0.9, 0.1, 0.01, 0.99 }, pregnancy);
		FiniteNode scan = new FullCPTNode(new RandVar("Scan",new BooleanDomain()),
				new double[] { 0.9, 0.1, 0.01, 0.99 }, pregnancy);
		FiniteNode blood = new FullCPTNode(bloodvar,
				new double[] { 0.7, 0.3, 0.1, 0.9 }, progesterone);
		FiniteNode urine = new FullCPTNode(new RandVar("Urine",new BooleanDomain()),
				new double[] { 0.8, 0.2, 0.1, 0.9 }, progesterone);
		
		BayesNet network = new BayesNet(pregnancy);
		
		EliminationAsk bayesInferenceElimination = new EliminationAsk();
		
		CategoricalDistribution d1 = bayesInferenceElimination
				.ask(new RandomVariable[] { new RandVar("Pregnancy",new BooleanDomain()), new RandVar("Progesterone",new BooleanDomain()) },
								new AssignmentProposition[] {new AssignmentProposition(bloodvar, true)}, network);

		System.out.println(d1.getValues()[0]+"||"+d1.getValues()[1]+"||"+d1.getValues()[2]+"||"+d1.getValues()[3]);
		//con samiam
		//truetrue:93.9 | falsefalse:0.09 | truefalse:3.69 | falsetrue:2.32
	}
}
