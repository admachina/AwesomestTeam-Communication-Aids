
public class Driver {
	InputType inputType;
	Driver(InputType inputType)
	{
		this.inputType = inputType;
	}
	
	// Make this return an Event or something later for Android
	// Currently returns the position of the inputValue in the inputType
	// e.g.
	// 		For input type JOYSTICK, the four inputs are Up, Down, Left, and Right
	//		The returned values for these strings are 1, 2, 3 and 4, respectively
	String getValue(String inputValue)
	{
		String[] inputs = inputType.getInputs();
		for (int i=0;i<inputs.length;i++)
		{
			if (inputs[i].equals(inputValue)){
				return Integer.toString(i+1); // return one more than the index
			}
		}
		throw new IllegalArgumentException("Invalid argument " + inputValue + " passed into getValue().");
	}
	
}
