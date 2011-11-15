import java.util.Vector;

public class Tree
{
	//Private Members
	private Vector<Tree> _branches;

	private String _printValue;
	private String _displayValue;


	// Constructors
	public Tree(String displayValue, String printValue)
	{
		_displayValue = displayValue;
		_printValue = printValue;
	}

	public Tree(String displayValue)
	{
		this(displayValue, "");
	}

	public Tree()
	{
		this("");
	}

	// Accessors
	public Tree next(int branch)
	{
		return _branches.elementAt(branch);
	}

	public String displayValue()
	{
		return _displayValue;
	}

	public String printValue()
	{
		return _printValue;
	}

	public boolean isLeaf()
	{
		return _branches.size() == 0;
	}

	// Mutators
	public void addNode(int location, Tree t)
	{
		_branches.add(location, t);
	}

	public void addNode(int location, String displayValue, String printValue)
	{
		addNode(location, new Tree(displayValue, printValue));
	}

	public void addNode(int location, String displayValue)
	{
		addNode(location, displayValue, "");
	}

	public void addNode(int location)
	{
		addNode(location, "");
	}

	public void addNode(String displayValue, String printValue)
	{
		addNode(_branches.size(), displayValue, printValue);
	}

	public void addNode(String displayValue)
	{
		addNode(displayValue, "");
	}

	public void addNode()
	{
		addNode("");
	}
}
