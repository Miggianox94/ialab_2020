package aima.core.probability.example;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import aima.core.probability.RandomVariable;
import aima.core.probability.bayes.DynamicBayesianNetwork;
import aima.core.probability.bayes.FiniteNode;
import aima.core.probability.bayes.impl.BayesNet;
import aima.core.probability.bayes.impl.DynamicBayesNet;
import aima.core.probability.bayes.impl.FullCPTNode;
import aima.core.probability.domain.BooleanDomain;
import aima.core.probability.util.RandVar;

/**
 * 
 * @author Ciaran O'Reilly
 *
 */
public class DynamicBayesNetExampleFactory {
	/**
	 * Return a Dynamic Bayesian Network of the Umbrella World Network.
	 * 
	 * @return a Dynamic Bayesian Network of the Umbrella World Network.
	 */
	public static DynamicBayesianNetwork getUmbrellaWorldNetwork() {
		FiniteNode prior_rain_tm1 = new FullCPTNode(ExampleRV.RAIN_tm1_RV,
				new double[] { 0.5, 0.5 });

		BayesNet priorNetwork = new BayesNet(prior_rain_tm1);

		// Prior belief state
		FiniteNode rain_tm1 = new FullCPTNode(ExampleRV.RAIN_tm1_RV,
				new double[] { 0.5, 0.5 });
		// Transition Model
		FiniteNode rain_t = new FullCPTNode(ExampleRV.RAIN_t_RV, new double[] {
				// R_t-1 = true, R_t = true
				0.7,
				// R_t-1 = true, R_t = false
				0.3,
				// R_t-1 = false, R_t = true
				0.3,
				// R_t-1 = false, R_t = false
				0.7 }, rain_tm1);
		// Sensor Model
		@SuppressWarnings("unused")
		FiniteNode umbrealla_t = new FullCPTNode(ExampleRV.UMBREALLA_t_RV,
				new double[] {
						// R_t = true, U_t = true
						0.9,
						// R_t = true, U_t = false
						0.1,
						// R_t = false, U_t = true
						0.2,
						// R_t = false, U_t = false
						0.8 }, rain_t);

		Map<RandomVariable, RandomVariable> X_0_to_X_1 = new HashMap<RandomVariable, RandomVariable>();
		X_0_to_X_1.put(ExampleRV.RAIN_tm1_RV, ExampleRV.RAIN_t_RV);
		Set<RandomVariable> E_1 = new HashSet<RandomVariable>();
		E_1.add(ExampleRV.UMBREALLA_t_RV);

		return new DynamicBayesNet(priorNetwork, X_0_to_X_1, E_1, rain_tm1);
	}
	
	
	@SuppressWarnings("unused")
	public static DynamicBayesianNetwork getDigitalCircuitNetExample() {
        /**
         * Number of nodes: 6
         * Number of arcs: 6
         */
		
		FiniteNode prior_J = new FullCPTNode(new RandVar("J_t-1", new BooleanDomain()),new double[] { 0.5, 0.5 });
		FiniteNode prior_I = new FullCPTNode(new RandVar("I_t-1", new BooleanDomain()),new double[] { 0.5, 0.5 });
		FiniteNode prior_Y = new FullCPTNode(new RandVar("Y_t-1", new BooleanDomain()),new double[] { 0.3, 0.7 });

		BayesNet priorNetwork = new BayesNet(prior_J,prior_I,prior_Y);

        /**
         * [RandomVariable]s declaration
         */
		RandVar jm1 = new RandVar("J_t-1", new BooleanDomain());
		RandVar im1 = new RandVar("I_t-1", new BooleanDomain());
		RandVar ym1 = new RandVar("Y_t-1", new BooleanDomain());
		RandVar j = new RandVar("J", new BooleanDomain());
		RandVar i = new RandVar("I", new BooleanDomain());
		RandVar y = new RandVar("Y", new BooleanDomain());
		RandVar z = new RandVar("Z", new BooleanDomain());

        /**
         * [FullCPTNode]s declaration
         */
		// Prior belief state
		FiniteNode node_J_tm1 = new FullCPTNode(jm1,new double[] { 0.5, 0.5 });
		FiniteNode node_I_tm1 = new FullCPTNode(im1,new double[] { 0.5, 0.5 });
		FiniteNode node_Y_tm1 = new FullCPTNode(ym1,new double[] { 0.3, 0.7 });
		
		// Transition Model
		FiniteNode node_J_t = new FullCPTNode(j,new double[] { 0.75, 0.25, 0.55, 0.45, 0.35, 0.65, 0.05, 0.95 },node_J_tm1,node_I_tm1);
		FiniteNode node_I_t = new FullCPTNode(i,new double[] { 0.98, 0.02, 0.98, 0.02, 0.98, 0.02, 0.02, 0.98 },node_J_tm1,node_Y_tm1);
		FiniteNode node_Y_t = new FullCPTNode(y,new double[] { 0.90, 0.10, 0.88, 0.12 },node_Y_tm1);
		
		// Sensor Model
		FiniteNode node_Z_t = new FullCPTNode(z,new double[] { 0.35, 0.65, 0.15, 0.85, 0.05, 0.95, 0.97, 0.03 },node_J_t,node_I_t);
		
		//specifico le equivalenze tra i nodi di t-1 e t
		Map<RandomVariable, RandomVariable> X_0_to_X_1 = new HashMap<RandomVariable, RandomVariable>();
		X_0_to_X_1.put(jm1, j);
		X_0_to_X_1.put(jm1, i);
		X_0_to_X_1.put(im1, j);
		X_0_to_X_1.put(ym1, i);
		X_0_to_X_1.put(ym1, y);
		Set<RandomVariable> E_1 = new HashSet<RandomVariable>();
		E_1.add(z);

		return new DynamicBayesNet(priorNetwork, X_0_to_X_1, E_1, node_J_tm1, node_I_tm1,node_Y_tm1);

    }
	
	@SuppressWarnings("unused")
	public static DynamicBayesianNetwork getAsiaNetwork() {
		FiniteNode prior_asia = new FullCPTNode(new RandVar("Asia_t-1", new BooleanDomain()),new double[] { 0.8, 0.2 });
		FiniteNode prior_smoke = new FullCPTNode(new RandVar("Smoke_t-1", new BooleanDomain()),new double[] { 0.5, 0.5 });
		FiniteNode prior_tub = new FullCPTNode(new RandVar("Tub_t-1", new BooleanDomain()),new double[] { 0.1, 0.9, 0.1, 0.9 },prior_asia);
		FiniteNode prior_lung = new FullCPTNode(new RandVar("Lung_t-1", new BooleanDomain()),new double[] { 0.6, 0.4, 0.6, 0.4 },prior_smoke);

		BayesNet priorNetwork = new BayesNet(prior_asia,prior_smoke);
		
        /**
         * [RandomVariable]s declaration
         */
		RandVar asia_m1 = new RandVar("Asia_t-1", new BooleanDomain());
		RandVar smoke_m1 = new RandVar("Smoke_t-1", new BooleanDomain());
		RandVar tub_m1 = new RandVar("Tub_t-1", new BooleanDomain());
		RandVar lung_m1 = new RandVar("Lung_t-1", new BooleanDomain());
		RandVar asia = new RandVar("Asia", new BooleanDomain());
		RandVar smoke = new RandVar("Smoke", new BooleanDomain());
		RandVar tub = new RandVar("Tub", new BooleanDomain());
		RandVar lung = new RandVar("Lung", new BooleanDomain());
		
		RandVar either = new RandVar("Either", new BooleanDomain());
		RandVar bronc = new RandVar("Bronc", new BooleanDomain());

		
		
        /**
         * [FullCPTNode]s declaration
         */
		// Prior belief state
		FiniteNode node_asia_m1 = new FullCPTNode(asia_m1,new double[] { 0.8, 0.2 });
		FiniteNode node_smoke_m1 = new FullCPTNode(smoke_m1,new double[] { 0.5, 0.5 });
		FiniteNode node_tub_m1 = new FullCPTNode(tub_m1,new double[] { 0.1, 0.9, 0.1, 0.9 },node_asia_m1);
		FiniteNode node_lung_m1 = new FullCPTNode(lung_m1,new double[] { 0.6, 0.4, 0.6, 0.4 }, node_smoke_m1);
		
		
		// Transition Model
		FiniteNode node_asia_t = new FullCPTNode(asia,new double[] { 0.95, 0.05, 0.05, 0.95 },node_smoke_m1);
		FiniteNode node_smoke_t = new FullCPTNode(smoke,new double[] { 0.98, 0.02, 0.98, 0.02, 0.98, 0.02, 0.02, 0.98 },node_asia_m1,node_smoke_m1);
		FiniteNode node_tub_t = new FullCPTNode(tub,new double[] { 0.98, 0.02, 0.98, 0.02, 0.98, 0.02, 0.98, 0.02 },node_lung_m1, node_asia_t);
		FiniteNode node_lung_t = new FullCPTNode(lung,new double[] { 0.6, 0.4, 0.6, 0.4, 0.6, 0.4, 0.6, 0.4}, node_tub_m1, node_smoke_t);

		// Sensor Model
		FiniteNode node_either_t = new FullCPTNode(either,new double[] { 0.95, 0.05, 0.05, 0.95, 0.05, 0.95, 0.05, 0.95 },node_tub_t,node_lung_t);
		FiniteNode node_bronc_t = new FullCPTNode(bronc,new double[] { 0.95, 0.05, 0.05, 0.95 },node_smoke_t);
		
		//specifico le equivalenze tra i nodi di t-1 e t
		Map<RandomVariable, RandomVariable> X_0_to_X_1 = new HashMap<RandomVariable, RandomVariable>();
		/*X_0_to_X_1.put(asia_m1, asia);
		X_0_to_X_1.put(smoke_m1, smoke);
		X_0_to_X_1.put(tub_m1, tub);
		X_0_to_X_1.put(lung_m1, lung);*/
		
		X_0_to_X_1.put(asia_m1, smoke);
		X_0_to_X_1.put(smoke_m1, smoke);
		X_0_to_X_1.put(smoke_m1, asia);
		X_0_to_X_1.put(lung_m1, tub);
		X_0_to_X_1.put(tub_m1, lung);
		

		Set<RandomVariable> E_1 = new HashSet<RandomVariable>();
		E_1.add(either);
		E_1.add(bronc);


		return new DynamicBayesNet(priorNetwork, X_0_to_X_1, E_1, false, node_asia_m1, node_smoke_m1);
	}
	
	
    public static DynamicBayesianNetwork getRainWindNet() {
    	
        RandVar WIND_tm1_RV = new RandVar("Wind_t-1",new BooleanDomain());
        RandVar WIND_t_RV = new RandVar("Wind_t",new BooleanDomain());
    	
        FiniteNode prior_rain_tm1 = new FullCPTNode(ExampleRV.RAIN_tm1_RV,
                new double[]{0.5, 0.5});
        FiniteNode prior_wind_tm1 = new FullCPTNode(WIND_tm1_RV,
                new double[]{0.5, 0.5});

        BayesNet priorNetwork = new BayesNet(prior_rain_tm1, prior_wind_tm1);

        // Prior belief state
        FiniteNode rain_tm1 = new FullCPTNode(ExampleRV.RAIN_tm1_RV,
                new double[]{0.5, 0.5});
        FiniteNode wind_tm1 = new FullCPTNode(WIND_tm1_RV,
                new double[]{0.5, 0.5});


        // Transition Model
        FiniteNode rain_t = new FullCPTNode(ExampleRV.RAIN_t_RV, new double[]{
            // R_t-1 = true, W_t-1 = true, R_t = true
            0.6,
            // R_t-1 = true, W_t-1 = true, R_t = false
            0.4,
            // R_t-1 = true, W_t-1 = false, R_t = true
            0.8,
            // R_t-1 = true, W_t-1 = false, R_t = false
            0.2,
            // R_t-1 = false, W_t-1 = true, R_t = true
            0.4,
            // R_t-1 = false, W_t-1 = true, R_t = false
            0.6,
            // R_t-1 = false, W_t-1 = false, R_t = true
            0.2,
            // R_t-1 = false, W_t-1 = false, R_t = false
            0.8
        }, rain_tm1, wind_tm1);

        FiniteNode wind_t = new FullCPTNode(WIND_t_RV, new double[]{
            // W_t-1 = true, W_t = true
            0.7,
            // W_t-1 = true, W_t = false
            0.3,
            // W_t-1 = false, W_t = true
            0.3,
            // W_t-1 = false, W_t = false
            0.7}, wind_tm1);
                
        // Sensor Model
        @SuppressWarnings("unused")
        FiniteNode umbrealla_t = new FullCPTNode(ExampleRV.UMBREALLA_t_RV,
                new double[]{
                    // R_t = true, U_t = true
                    0.9,
                    // R_t = true, U_t = false
                    0.1,
                    // R_t = false, U_t = true
                    0.2,
                    // R_t = false, U_t = false
                    0.8}, rain_t);

        Map<RandomVariable, RandomVariable> X_0_to_X_1 = new HashMap<RandomVariable, RandomVariable>();
        X_0_to_X_1.put(ExampleRV.RAIN_tm1_RV, ExampleRV.RAIN_t_RV);
        X_0_to_X_1.put(WIND_tm1_RV, ExampleRV.RAIN_t_RV);        
        X_0_to_X_1.put(WIND_tm1_RV, WIND_t_RV);
        Set<RandomVariable> E_1 = new HashSet<RandomVariable>();
        E_1.add(ExampleRV.UMBREALLA_t_RV);

        return new DynamicBayesNet(priorNetwork, X_0_to_X_1, E_1, rain_tm1, wind_tm1);

    }
    
    
	@SuppressWarnings("unused")
	public static DynamicBayesianNetwork getComplexNetExample() {
		FiniteNode prior_A = new FullCPTNode(new RandVar("A_t-1", new BooleanDomain()),new double[] { 0.8, 0.2});
		FiniteNode prior_B = new FullCPTNode(new RandVar("B_t-1", new BooleanDomain()),new double[] { 0.6, 0.4, 0.1, 0.9 }, prior_A);
		FiniteNode prior_C = new FullCPTNode(new RandVar("C_t-1", new BooleanDomain()),new double[] { 0.1, 0.9, 0.5, 0.5 }, prior_A);
		FiniteNode prior_D = new FullCPTNode(new RandVar("D_t-1", new BooleanDomain()),new double[] { 0.7, 0.3, 0.4, 0.6 }, prior_A);
		FiniteNode prior_E = new FullCPTNode(new RandVar("E_t-1", new BooleanDomain()),new double[] { 0.3, 0.7, 0.9, 0.1 }, prior_B);
		FiniteNode prior_F = new FullCPTNode(new RandVar("F_t-1", new BooleanDomain()),new double[] { 0.4, 0.6, 0.3, 0.7 }, prior_C);
		FiniteNode prior_G = new FullCPTNode(new RandVar("G_t-1", new BooleanDomain()),new double[] { 0.5, 0.5, 0.8, 0.2 }, prior_D);
		FiniteNode prior_H = new FullCPTNode(new RandVar("H_t-1", new BooleanDomain()),new double[] { 0.5, 0.5, 0.6, 0.4, 0.3, 0.7, 0.9, 0.1 }, prior_F, prior_G);
		FiniteNode prior_I = new FullCPTNode(new RandVar("I_t-1", new BooleanDomain()),new double[] { 0.9, 0.1, 0.5, 0.5 }, prior_H);
		FiniteNode prior_L = new FullCPTNode(new RandVar("L_t-1", new BooleanDomain()),new double[] { 0.8, 0.2, 0.1, 0.9 }, prior_G);
		

		BayesNet priorNetwork = new BayesNet(prior_A);
		
        /**
         * [RandomVariable]s declaration
         */
		RandVar A_m1 = new RandVar("A_t-1", new BooleanDomain());
		RandVar B_m1 = new RandVar("B_t-1", new BooleanDomain());
		RandVar C_m1 = new RandVar("C_t-1", new BooleanDomain());
		RandVar D_m1 = new RandVar("D_t-1", new BooleanDomain());
		RandVar E_m1 = new RandVar("E_t-1", new BooleanDomain());
		RandVar F_m1 = new RandVar("F_t-1", new BooleanDomain());
		RandVar G_m1 = new RandVar("G_t-1", new BooleanDomain());
		RandVar H_m1 = new RandVar("H_t-1", new BooleanDomain());
		RandVar I_m1 = new RandVar("I_t-1", new BooleanDomain());
		RandVar L_m1 = new RandVar("L_t-1", new BooleanDomain());
		
		RandVar A = new RandVar("A", new BooleanDomain());
		RandVar B = new RandVar("B", new BooleanDomain());
		RandVar C = new RandVar("C", new BooleanDomain());
		RandVar D = new RandVar("D", new BooleanDomain());
		RandVar E = new RandVar("E", new BooleanDomain());
		RandVar F = new RandVar("F", new BooleanDomain());
		RandVar G = new RandVar("G", new BooleanDomain());
		RandVar H = new RandVar("H", new BooleanDomain());
		RandVar I = new RandVar("I", new BooleanDomain());
		RandVar L = new RandVar("L", new BooleanDomain());
		
		RandVar evid1 = new RandVar("Evid1", new BooleanDomain());
		RandVar evid2 = new RandVar("Evid2", new BooleanDomain());

		
		
        /**
         * [FullCPTNode]s declaration
         */
		// Prior belief state
		FiniteNode nodem1_A = new FullCPTNode(A_m1,new double[] { 0.8, 0.2});
		FiniteNode nodem1_B = new FullCPTNode(B_m1,new double[] { 0.6, 0.4, 0.1, 0.9 }, nodem1_A);
		FiniteNode nodem1_C = new FullCPTNode(C_m1,new double[] { 0.1, 0.9, 0.5, 0.5 }, nodem1_A);
		FiniteNode nodem1_D = new FullCPTNode(D_m1,new double[] { 0.7, 0.3, 0.4, 0.6 }, nodem1_A);
		FiniteNode nodem1_E = new FullCPTNode(E_m1,new double[] { 0.3, 0.7, 0.9, 0.1 }, nodem1_B);
		FiniteNode nodem1_F = new FullCPTNode(F_m1,new double[] { 0.4, 0.6, 0.3, 0.7 }, nodem1_C);
		FiniteNode nodem1_G = new FullCPTNode(G_m1,new double[] { 0.5, 0.5, 0.8, 0.2 }, nodem1_D);
		FiniteNode nodem1_H = new FullCPTNode(H_m1,new double[] { 0.5, 0.5, 0.6, 0.4, 0.3, 0.7, 0.9, 0.1 }, nodem1_F, nodem1_G);
		FiniteNode nodem1_I = new FullCPTNode(I_m1,new double[] { 0.9, 0.1, 0.5, 0.5 }, nodem1_H);
		FiniteNode nodem1_L = new FullCPTNode(L_m1,new double[] { 0.8, 0.2, 0.1, 0.9 }, nodem1_G);
		
		
		// Transition Model
		FiniteNode node_A = new FullCPTNode(A,new double[] { 0.8, 0.2, 0.6, 0.4}, nodem1_A);
		FiniteNode node_B = new FullCPTNode(B,new double[] { 0.6, 0.4, 0.1, 0.9, 0.5, 0.5, 0.8, 0.2 }, node_A, nodem1_D);
		FiniteNode node_C = new FullCPTNode(C,new double[] { 0.1, 0.9, 0.5, 0.5, 0.7, 0.3, 0.4, 0.6 }, node_A, nodem1_C);
		FiniteNode node_D = new FullCPTNode(D,new double[] { 0.7, 0.3, 0.4, 0.6, 0.1, 0.9, 0.5, 0.5 }, node_A, nodem1_B);
		FiniteNode node_E = new FullCPTNode(E,new double[] { 0.3, 0.7, 0.9, 0.1, 0.1, 0.9, 0.5, 0.5}, node_B, nodem1_E);
		FiniteNode node_F = new FullCPTNode(F,new double[] { 0.4, 0.6, 0.3, 0.7, 0.1, 0.9, 0.5, 0.5 }, node_C, nodem1_F);
		FiniteNode node_G = new FullCPTNode(G,new double[] { 0.5, 0.5, 0.8, 0.2, 0.3, 0.7, 0.1, 0.9 }, node_D, nodem1_G);
		FiniteNode node_H = new FullCPTNode(H,new double[] { 0.5, 0.5, 0.6, 0.4, 0.3, 0.7, 0.9, 0.1, 0.4, 0.6, 0.3, 0.7, 0.1, 0.9, 0.5, 0.5 }, node_F, node_G, nodem1_H);
		FiniteNode node_I = new FullCPTNode(I,new double[] { 0.9, 0.1, 0.5, 0.5, 0.9, 0.1, 0.1, 0.9 }, node_H, nodem1_I);
		FiniteNode node_L = new FullCPTNode(L,new double[] { 0.8, 0.2, 0.1, 0.9, 0.9, 0.1, 0.5, 0.5 }, node_G, nodem1_L);

		// Sensor Model
		FiniteNode node_evid1 = new FullCPTNode(evid1,new double[] { 0.50, 0.50, 0.05, 0.95, 0.20, 0.80, 0.05, 0.95 },node_F,node_H);
		FiniteNode node_evid2 = new FullCPTNode(evid2,new double[] { 0.95, 0.05, 0.05, 0.95 },node_H);
		
		//specifico le equivalenze tra i nodi di t-1 e t
		Map<RandomVariable, RandomVariable> X_0_to_X_1 = new HashMap<RandomVariable, RandomVariable>();
		
		X_0_to_X_1.put(A_m1, A);
		X_0_to_X_1.put(D_m1, B);
		X_0_to_X_1.put(C_m1, C);
		X_0_to_X_1.put(B_m1, D);
		X_0_to_X_1.put(F_m1, F);
		X_0_to_X_1.put(G_m1, G);
		X_0_to_X_1.put(E_m1, E);
		X_0_to_X_1.put(L_m1, L);
		X_0_to_X_1.put(H_m1, H);
		X_0_to_X_1.put(I_m1, I);

		Set<RandomVariable> E_1 = new HashSet<RandomVariable>();
		E_1.add(evid1);
		E_1.add(evid2);


		return new DynamicBayesNet(priorNetwork, X_0_to_X_1, E_1, false, nodem1_A);
	}
}
