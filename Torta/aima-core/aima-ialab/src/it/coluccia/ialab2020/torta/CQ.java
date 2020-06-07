package it.coluccia.ialab2020.torta;



import java.util.HashMap;
import java.util.List;

import aima.core.probability.CategoricalDistribution;
import aima.core.probability.RandomVariable;
import aima.core.probability.bayes.BayesInference;
import aima.core.probability.bayes.BayesianNetwork;
import aima.core.probability.bayes.exact.EliminationAsk;
import aima.core.probability.proposition.AssignmentProposition;
import it.coluccia.ialab2020.torta.bnparser.BifReader;

/**
 *
 * @author torta
 */
public class CQ {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        HashMap<String, RandomVariable> rvsmap = new HashMap<>();
        
        BayesianNetwork bn = BifReader.readBIF("cow.xml");
        List<RandomVariable> rvs = bn.getVariablesInTopologicalOrder();
        for (RandomVariable rv :rvs) {
            System.out.println(rv.getName());
            rvsmap.put(rv.getName(), rv);                
        }
        
        RandomVariable[] qrv = new RandomVariable[2];
        qrv[0] = rvsmap.get("Pregnancy");
        qrv[1] = rvsmap.get("Progesterone");
        AssignmentProposition[] ap = new AssignmentProposition[1];
        ap[0] = new AssignmentProposition(rvsmap.get("Blood"), "P");

        BayesInference bi = new EliminationAsk();

        CategoricalDistribution cd = bi.ask(qrv, ap, bn);

        System.out.print("<");
        for (int i = 0; i < cd.getValues().length; i++) {
            System.out.print(cd.getValues()[i]);
            if (i < (cd.getValues().length - 1)) {
                System.out.print(", ");
            } else {
                System.out.println(">");
            }
        }

    }
}