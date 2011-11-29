package comm.aid;

public class Profile {
	private String name;
	private InputType inputType;
	private ExperienceLevel level; // for the user level (beginner, intermediate, advanced)
								   // which may change the tree we display to the user (i.e. less returns for advanced users)
	//private Image avatar; // In the future, we can add an avatar for a profile
	
	public Profile(String name, InputType inputType, ExperienceLevel level)
	{
		setName(name);
		setInputType(inputType);
		setLevel(level);
	}
	
	public Profile(String name, String inputType, String level)
	{
		setName(name);
		setInputType(inputType);
		setLevel(level);
	}
	
	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return name;
	}
	public void setInputType(InputType inputType) {
		this.inputType = inputType;
	}
	
	public void setInputType(String inputType)
	{
		this.inputType = InputType.getInputType(inputType);
	}
	public InputType getInputType() {
		return inputType;
	}
	public void setLevel(ExperienceLevel level) {
		this.level = level;
	}
	
	public void setLevel(String level)
	{
		this.level = ExperienceLevel.getExpLevel(level);
	}
	public ExperienceLevel getLevel() {
		return level;
	}
	
}
