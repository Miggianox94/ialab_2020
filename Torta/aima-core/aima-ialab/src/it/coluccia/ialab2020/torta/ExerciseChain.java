package it.coluccia.ialab2020.torta;

import aima.core.probability.CategoricalDistribution;
import aima.core.probability.RandomVariable;
import aima.core.probability.bayes.FiniteNode;
import aima.core.probability.bayes.exact.EliminationAsk;
import aima.core.probability.bayes.exact.EnumerationAsk;
import aima.core.probability.bayes.impl.BayesNet;
import aima.core.probability.bayes.impl.FullCPTNode;
import aima.core.probability.domain.BooleanDomain;
import aima.core.probability.proposition.AssignmentProposition;
import aima.core.probability.util.RandVar;
import it.coluccia.ialab2020.torta.project.EliminationMinDegree;

public class ExerciseChain {
	
	final static int inputNumber = 25;

	/**
	 * creare un programma Java che utilizzi la libreria aima-core
	 * il programma deve:
	 * ricevere in input un numero intero n
	 * creare una BN a "catena" (vedi slide) con Nnodi X1, �, Xn
	 * inferire la distribuzione P(X1 | xn) con i metodi:
	 * per enumerazione
	 * per eliminazione di variabili
	 * confrontare i tempi impiegati dai due metodi al crescere di n
	 * @param args
	 */
	public static void main(String[] args){
		
		for(int i = 5; i <= 10; i+=5){
			System.out.println("Trying with "+i+" nodes");
			testAsk(i, true);
		}
		
		System.out.println("\n------------------------n");
		
		
		/**
		 * 
		 * creare poi questa variante:	
		 * cambiare l�ordinamento delle variabili, provando in particolare quello �pessimo� visto a lezione
		 * confrontare i tempi impiegati dai due metodi al crescere di n
		 */
		for(int i = 5; i <= 15; i+=5){
			System.out.println("Trying bad order with "+i+" nodes");
			testAsk(i, false);
		}
	}
	
	
	private static void testAsk(int numberNodes, boolean defaultOrder){
		int counter = numberNodes;
		FiniteNode lastNode = null;
		RandVar first = null;
		RandVar last = null;
		FiniteNode firstNode = null;
		while(counter > 0){
			//creo nodo
			if(lastNode == null){
				first = new RandVar("Node"+counter,new BooleanDomain());
				firstNode = new FullCPTNode(first,
						new double[] { 0.5, 0.5 });
				lastNode = firstNode;
			}else{
				last = new RandVar("Node"+counter,new BooleanDomain());

				FiniteNode node = new FullCPTNode(last,
						new double[] { 0.5, 0.5, 0.5, 0.5 }, lastNode);
				lastNode = node;
			}
			counter--;
		}
		BayesNet netword = new BayesNet(firstNode);
		
		EnumerationAsk bayesInferenceEnumeration = new EnumerationAsk();
		EliminationAsk bayesInferenceElimination = null;
		if(defaultOrder){
			bayesInferenceElimination = new EliminationAsk();
		}else{
			//bayesInferenceElimination = new EliminationAskBadOrder(); //con questa da errore perch� faccio processare le variabili "due volte"
			bayesInferenceElimination = new EliminationMinDegree();
			//bayesInferenceElimination = new EliminationFill();
		}
		
		long startTime = System.nanoTime();
		
		CategoricalDistribution d = bayesInferenceEnumeration
				.ask(new RandomVariable[] { first },
						new AssignmentProposition[] {new AssignmentProposition(last, true)}, netword);
		long stopTime = System.nanoTime();
		System.out.println("Time for enumeration: "+(stopTime - startTime));
		System.out.println(d.getValues()[0]+"||"+d.getValues()[1]);
		
		startTime = System.nanoTime();
		CategoricalDistribution d1 = bayesInferenceElimination
				.ask(new RandomVariable[] { first },
								new AssignmentProposition[] {new AssignmentProposition(last, true)}, netword);
		stopTime = System.nanoTime();
		System.out.println("Time for elimination: "+(stopTime - startTime));
		System.out.println(d1.getValues()[0]+"||"+d1.getValues()[1]);
	}
}
