import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class DriverProto {


	/**
	 * @param args
	 */
	public static void main(String[] args) {
		/*if (args.length < 1 )
		{
			System.err.println("Invalid number of arguments.");
			return;
		}
		System.out.println(args[0]);*/ // Get input via command line argument
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		Driver driver = null;
		try {
			do
			{
				try
				{
					driver = new Driver (InputType.getInputType(br.readLine()));
				}
				catch (IllegalArgumentException e)
				{
					System.out.print(e.toString());
					System.out.println(" Try again.");
				}
			}
			while (driver == null);
		} catch (IOException ioe) {
			System.out.println("IO error trying to read");
		}
		while (true)
		{
			try {
				String input = br.readLine();
				String mappedValue = driver.getValue(input);
				System.out.println("The mapped value of " + input + " is " + mappedValue);
			} catch (IOException ioe) {
				System.out.println("IO error trying to read");
			}
		}
	}

}
