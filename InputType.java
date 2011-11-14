
public enum InputType {
	JOYSTICK ("Joystick", 4, "Up", "Down", "Left", "Right"),
	PADDLES ("Paddles", 4, "Paddle1", "Paddle2", "Paddle3", "Paddle4"),
	STRAW ("Straw", 2, "Inhale", "Exhale");
	
	private String name;
	private int degreesOfInput; // can remove this later and use inputs.length instead
	private String[] inputs;
	
	InputType(String name, int degreesOfInput, String...inputs)
	{
		// Ensure the input length is the same as the degrees of input
		assert inputs.length == degreesOfInput;
		this.setName(name);
		this.setDegreesOfInput(degreesOfInput);
		this.setInputs(inputs);
	}

	private void setDegreesOfInput(int degreesOfInput) {
		this.degreesOfInput = degreesOfInput;
	}

	private int getDegreesOfInput() {
		return degreesOfInput;
	}

	private void setName(String name) {
		this.name = name;
	}

	private String getName() {
		return name;
	}
	
	public static InputType getInputType (String str)
	{
		for (InputType type:InputType.values())
		{
			if (type.getName().equals(str))
				return type;
		}
		throw new IllegalArgumentException("Invalid argument " + str + " passed into getInputType()");
	}

	public void setInputs(String[] inputs) {
		this.inputs = inputs;
	}

	public String[] getInputs() {
		return inputs;
	}
	
	public String toString(){
		return getName();
	}
}
