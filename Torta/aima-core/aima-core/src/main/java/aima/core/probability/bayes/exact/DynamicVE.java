package aima.core.probability.bayes.exact;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import aima.core.probability.Factor;
import aima.core.probability.RandomVariable;
import aima.core.probability.TimeRandomVariable;
import aima.core.probability.bayes.DynamicBayesianNetwork;
import aima.core.probability.proposition.AssignmentProposition;
import aima.core.probability.util.ProbabilityTable;

/**
 * It permits to apply Variable elimination algorithm on a DBN using rollup filtering
 * @author Miggianox94
 *
 */
@Deprecated
public class DynamicVE extends EliminationAsk {
	
	public static final ProbabilityTable _identity = new ProbabilityTable(
			new double[] { 1.0 });

	/**
	 * It executes VE algorithm for a single slice of dbn
	 * It create factors for X0 t and sumout them.
	 * @param dbn
	 * @param query
	 * @param obs
	 * @return
	 */
	public List<Factor> ask(DynamicBayesianNetwork dbn, TimeRandomVariable[] query, AssignmentProposition[] obs){
		Set<RandomVariable> hidden = new HashSet<RandomVariable>();
		List<RandomVariable> VARS = new ArrayList<RandomVariable>();
		calculateVariables(query, obs, dbn, hidden, VARS);
		List<RandomVariable> evidenceVars = new ArrayList<>();
		for(AssignmentProposition as : obs){
			evidenceVars.add(as.getTermVariable());
		}
		
		List<RandomVariable> order = order(dbn, VARS);
		System.out.println("Variable order: ");
		for(RandomVariable varord : order){
			System.out.println(varord);
		}

		// factors <- []
		List<Factor> factors = new ArrayList<Factor>();

		// for each var in ORDER(bn.VARS) do
		for (RandomVariable var : order) {
			// factors <- [MAKE-FACTOR(var, e) | factors]
			Factor singleFactor = makeFactor(var, obs, dbn);
			factors.add(0, singleFactor);
		}
		//boolean first = true;
		for (RandomVariable var : order) {
			/*if(evidenceVars.contains(var)){
				//non faccio sumout sulle variabili di evidenza
				continue;
			}
			if(Arrays.asList(query).contains(var)){
				//..an ordering of variables NOT IN Q
				continue;
			}*/
			if(dbn.getX_0().contains(var)){
				factors = sumOut(var, factors, dbn);	
			}
		}
		
		return factors;

		// return NORMALIZE(POINTWISE-PRODUCT(factors))
		//Factor product = pointwiseProduct(factors);
		// Note: Want to ensure the order of the product matches the
		// query variables
		//return ((ProbabilityTable) product.pointwiseProductPOS(_identity, X)).normalize();
		//return product;
	}
	
	
	public static Factor pointwiseProductStatic(List<Factor> factors) {

		Factor product = factors.get(0);
		for (int i = 1; i < factors.size(); i++) {
			product = product.pointwiseProduct(factors.get(i));
		}

		return product;
	}
}
