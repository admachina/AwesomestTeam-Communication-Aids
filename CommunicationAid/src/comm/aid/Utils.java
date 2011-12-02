package comm.aid;

import java.io.IOException;
import java.util.StringTokenizer;

public class Utils {
	
	// Retrieve the next string tokenizer token
	// Throws an IOException if none is found
	public static String getNextSTToken(StringTokenizer st) throws IOException
	{
		if (st.hasMoreTokens())
			return st.nextToken();
		throw new IOException ("No ST Token found");
	}
	
	// Returns the correct line endings depending on the OS
	public static String getLineEnding(){
		if (System.getProperty("os.name").contains("Windows"))
		{
			return "\r\n";
		}
		return "\n";
	}
	
	// Returns if a string is empty or null
	public static boolean isStringEmptyOrNull(String str)
	{
		return str.equals("") || str == null;
	}
}
