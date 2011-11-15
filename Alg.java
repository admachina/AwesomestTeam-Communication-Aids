public class Alg
{
	private Tree _tree, _treeRoot;
	private int _numChoices;

	public Alg(int choices, Tree tree)
	{
		_numChoices = choices;
		_tree = tree;
		_treeRoot = tree;
	}

	public String choose(int choice, String newValues[]){
		_tree = _tree.next(choice);

		String printVal = _tree.printValue();

		if(_tree.isLeaf())
		{
			_tree = _treeRoot;
		}

		for(int i=0; i<_numChoices; i++)
		{
			newValues[i] = _tree.next(i).displayValue();
		}

		return printVal;
	}
}
