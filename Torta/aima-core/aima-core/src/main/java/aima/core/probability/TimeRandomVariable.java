package aima.core.probability;

public interface TimeRandomVariable extends RandomVariable {
	
	/**
	 * Return time step this variable refers to
	 * @return
	 */
	int getStep();
}
