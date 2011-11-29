package comm.aid;

import static org.junit.Assert.*;

import java.io.IOException;
import java.util.ArrayList;

import org.junit.Test;

public class ProfileManagerTest {

	@Test
	public void testReadFiles() throws IOException {
		ProfileManager pm = new ProfileManager("src/comm/aid");
		ArrayList<Profile> profiles = pm.getProfiles();
		assertEquals(1, profiles.size());
		Profile profile = profiles.get(0);
		assertEquals("Bob James", profile.getName());
		assertEquals("Joystick", profile.getInputType().toString());
		assertEquals("Beginner", profile.getLevel().toString());
		//fail("Not yet implemented");
	}

	@Test
	public void testCreateAndReadProfiles() throws IOException {
		ProfileManager pm = new ProfileManager("src/");
		ArrayList<Profile> profiles = pm.getProfiles();
		assertEquals(profiles.size(), 0);
		String name = "John Smith";
		String inputType = "Straw";
		String expLevel = "Advanced";
		pm.createAndSetProfile(name, inputType, expLevel);
		Profile currentProfile = pm.getCurrentProfile();
		assertEquals(name, currentProfile.getName().toString());
		assertEquals(inputType, currentProfile.getInputType().toString());
		assertEquals(expLevel, currentProfile.getLevel().toString());
		assertEquals(1, pm.getProfiles().size());
		
		// Create new profile manager to check if file was created and readable
		ProfileManager checkPM = new ProfileManager("src/");
		profiles = checkPM.getProfiles();
		assertEquals(1, profiles.size());
		Profile profile = profiles.get(0);
		assertEquals(name, profile.getName().toString());
		assertEquals(inputType, profile.getInputType().toString());
		assertEquals(expLevel, profile.getLevel().toString());
		
		pm.deleteProfile(name);
		
		// Recreate profile manager to check if file has been removed correctly
		checkPM = new ProfileManager("src/");
		profiles = checkPM.getProfiles();
		assertEquals(0, profiles.size());
		
		//fail("Not yet implemented");
	}

}
