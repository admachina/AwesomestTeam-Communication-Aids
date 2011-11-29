package comm.aid;

import java.io.IOException;
import java.io.InputStream;
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
	private InputStream dictionary, configFile;
	
	//both files being overridden
	DictionaryParser(String dictionaryFilename, String configFilename) {
		//TODO: protect for file not existing
		dictionary = getClass().getResourceAsStream(dictionaryFilename);
		configFile = getClass().getResourceAsStream(configFilename);
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
			props.load(configFile);
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
		
		Scanner parser = new Scanner(dictionary);
		
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
	
	/*
	public static void main(String[] args) {
		
		DictionaryParser parser = new DictionaryParser();
		Tree tree = parser.parse();
	}
	*/
}
