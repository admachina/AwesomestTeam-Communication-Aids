public class Alg
{
	private MyTree tree;
	private int numChoices;

	public Alg(int choices)
	{
		numChoices = choices;
		tree = new MyTree(choices);
	}

	public String choose(int choice, String newValues[]){
		tree = tree.next(choice);

		String printVal = tree.printValue();

		if(tree.isLeaf())
		{
			tree = tree.root();
		}

		for(int i=0; i<numChoices; i++)
		{
			newValues[i] = tree.next(i).display();
		}
		
	}
}
