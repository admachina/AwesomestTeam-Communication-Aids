import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;
import java.util.Scanner;


public class DictionaryParser {
	
	//defaults for external files
	static final String DEFAULT_DICTIONARY = "data/dictionary.txt";
	static final String DEFAULT_CONFIG = "parserConfig.properties";
	static final String NODES_KEY = "nodesPerLevel";
	
	private final Tree DOWN_NODE = new Tree("More...", ""); 
	
	private int nodesPerLevel;
	
	//variables for holding external files 
	private File dictionary, configFile;
	
	//both files being overridden
	DictionaryParser(String dictionaryFilename, String configFilename) {
		dictionary = new File(dictionaryFilename);
		configFile = new File(configFilename);
		loadConfig();
	}
	//both defaults
	DictionaryParser(){
		this(DEFAULT_DICTIONARY, DEFAULT_CONFIG);			
	}
	
	//TODO: setters for config/dictionary?
	
	private int getIntegerProperty( Properties props, String key) {
		return Integer.parseInt(props.getProperty(key));
	}
	
	void loadConfig() {
		Properties props = new Properties();
		
		//read properties in from file
		try{
			FileInputStream fis = new FileInputStream(configFile);			
			props.load(fis);
		} catch (IOException e) {
			System.err.println("could not open/read from config file: " + configFile.toString());
			e.printStackTrace();
		}
		
		//set the required vars from properties
		nodesPerLevel = getIntegerProperty(props, NODES_KEY);
		
	}
	
	Tree parse() {
		String displayVal;
		String printVal;
		Tree treeHead = new Tree();		
		
		Scanner parser = null;
		try {
			parser = new Scanner(dictionary);
		} catch (FileNotFoundException e1) {
			System.err.print("could not open dictionary file: " + dictionary.toString());
			e1.printStackTrace();
		}
		parser.useDelimiter(",|\\n");
		
		Tree currentNode = treeHead;

		scan: while(parser.hasNext()){
			
			for( int i = 1; (i < nodesPerLevel); i++){
				if(!parser.hasNext()){
					break scan;
				}
				
				displayVal = parser.next();
				printVal = parser.next();
				currentNode.addNode(displayVal, printVal);
			}
			//TODO:autoinserts?
			currentNode = currentNode.addNode(DOWN_NODE.clone());
		}
		
		return treeHead;
	}
	
	public static void main(String[] args) {
		
		DictionaryParser parser = new DictionaryParser();
		Tree tree = parser.parse();
	}
	

}
