package comm.aid;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.regex.Pattern;
import java.io.*;

public class ProfileManager {
	private static String profileFileNameSuffix = "-comm-aid.txt";
	private static String profileNameStr = "name";
	private static String profileInputTypeStr = "inputType";
	private static String profileExperienceLevelStr = "expLevel";
	
	private String startDir = "androidDir";
	
	// FileFilter for filtering profile files
	class ProfileFileFilter implements FileFilter{
		@Override
		public boolean accept(File file) {
			if (Pattern.matches(".*" + profileFileNameSuffix, file.getName())){
				return true;
			}
			return false;
		}
	};
	
	private Profile currentProfile = null;
	private ArrayList<Profile> profiles = new ArrayList<Profile>();
	
	public ProfileManager() throws IOException{
		readProfiles();
	}
	
	// For unit test cases ONLY
	public ProfileManager(String path) throws IOException{
		startDir = path;
		readProfiles();
	}
	
	// Imports profiles
	private void readProfiles() throws IOException{
		File dir = new File(startDir);
		System.out.println(dir.getAbsolutePath());
		if (!dir.exists()) throw new IOException("Invalid directory");
		
		File[] files = dir.listFiles(new ProfileFileFilter());
		for (int i=0;i<files.length;i++)
		{
			processProfileFile(files[i]);
		}
	}
	
	// Parses a file and adds it to profiles
	// Note: Public for unit testing purposes
	public void processProfileFile(File file) throws IOException
	{
		FileReader fr = new FileReader(file);
		BufferedReader br = new BufferedReader(fr);
		HashMap <String, String> inputMap = new HashMap<String, String>();
		while (true)
		{
			String line = br.readLine();
			if (line == null) break;
			StringTokenizer st = new StringTokenizer(line, "=");
			String key = null;
			String value = null;
			try
			{
				key = Utils.getNextSTToken(st);
				value = Utils.getNextSTToken(st);
			}
			catch(IOException e)
			{
				// Log it?
				continue;
			}
			inputMap.put(key.trim(), value.trim());
		}
		String name = inputMap.get(profileNameStr);
		String inputType = inputMap.get(profileInputTypeStr);
		String expLevel = inputMap.get(profileExperienceLevelStr);
		profiles.add(new Profile(name, inputType, expLevel));
		br.close();
		fr.close();
	}
	
	// Name of the person
	private String getFileName(Profile profile)
	{
		return profile.getName() + profileFileNameSuffix;
	}
	
	public void createProfile(String name, String inputType, String expLevel) throws IOException
	{
		Profile newProfile = new Profile(name, inputType, expLevel);
		profiles.add(newProfile);
		writeProfile(newProfile);
	}
	
	public void createAndSetProfile(String name, String inputType, String expLevel) throws IOException
	{
		createProfile(name, inputType, expLevel);
		currentProfile = profiles.get(profiles.size()-1); // Newly added profile is the current profile
	}
	
	private void writeProfile(Profile profile) throws IOException{
		File file = new File(startDir + getFileName(profile));
		if (file.exists())
		{
			boolean result = file.delete();
			if (!result)
			{
				// Log failure?
			}
		}
		file.createNewFile();
		FileWriter fw = new FileWriter(file);
		BufferedWriter bw = new BufferedWriter(fw);
		bw.write(profileNameStr + " = " + profile.getName() + Utils.getLineEnding());
		bw.write(profileInputTypeStr + " = " + profile.getInputType().toString() + Utils.getLineEnding());
		bw.write(profileExperienceLevelStr + " = " + profile.getLevel().toString());
		bw.close();
		fw.close();
	}
	
	private void exportProfiles() throws IOException{
		for (int i=0;i<profiles.size();i++)
			writeProfile(profiles.get(i));
	}
	
	public void clearCurrentProfile() throws IOException{
		exportProfiles();
		currentProfile = null;
	}

	public Profile getCurrentProfile() {
		return currentProfile;
	}
	
	public void setCurrentProfile(String name)
	{
		// Use a hashmap to store profiles by name for faster access
		for (int i=0;i<profiles.size();i++)
		{
			if (profiles.get(i).getName().equals(name))
			{
				currentProfile = profiles.get(i);
			}
		}
		// Log error or exception?
	}
	
	// Assumes profile exists
	public void deleteProfile(String name)
	{
		Profile profileToRemove = null;
		// Use a hashmap to store profiles by name for faster access
		for (int i=0;i<profiles.size();i++)
		{
			if (profiles.get(i).getName().equals(name))
			{
				profileToRemove = profiles.get(i);
				profiles.remove(i);
			}
		}
		
		File file = new File(startDir + getFileName(profileToRemove));
		file.delete();
	}
	
	public void updateCurrentProfile(String name, String inputType, String level) throws IOException
	{
		currentProfile.setName(name);
		currentProfile.setInputType(inputType);
		currentProfile.setLevel(level);
		
		writeProfile(currentProfile);
	}
		
	public ArrayList<Profile> getProfiles()
	{
		return profiles;
	}
	
	public String[] getProfileNames()
	{
		String[] names = new String[profiles.size()];
		for (int i=0;i<profiles.size();i++){
			names[i] = profiles.get(i).getName();
		}
		return names;
	}
}
