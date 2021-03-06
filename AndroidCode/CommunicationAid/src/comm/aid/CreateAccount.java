package comm.aid;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;

public class CreateAccount extends Activity {
	// profile information
	private String inputType = "", experienceLevel = "";
	
	// screen widgets
	private EditText nameText;
	private Spinner inputDeviceSpinner;
	private Spinner experienceLevelSpinner;
	private Button createAccountButton;
	
	/** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        setContentView(R.layout.create_account);
        
        // load and initialize screen widgets
        nameText = (EditText) this.findViewById(R.id.account_name);
        
        inputDeviceSpinner = (Spinner) findViewById(R.id.input_device_spinner);
        ArrayAdapter<CharSequence> input_device_adapter = ArrayAdapter.createFromResource(CommunicationAid.instance, R.array.input_device_types, android.R.layout.simple_spinner_item);
        input_device_adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
    	inputDeviceSpinner.setAdapter(input_device_adapter);
    	
    	inputDeviceSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener(){

			public void onItemSelected(AdapterView<?> arg0, View arg1, int pos, long arg3) {
				inputType = arg0.getItemAtPosition(pos).toString();
			}

			public void onNothingSelected(AdapterView<?> arg0) {}
			
        });
    	
    	experienceLevelSpinner = (Spinner) findViewById(R.id.experience_level_spinner);
        ArrayAdapter<CharSequence> experience_level_adapter = ArrayAdapter.createFromResource(CommunicationAid.instance, R.array.experience_level_types, android.R.layout.simple_spinner_item);
        experience_level_adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        experienceLevelSpinner.setAdapter(experience_level_adapter);
        
        experienceLevelSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener(){

			public void onItemSelected(AdapterView<?> arg0, View arg1, int pos, long arg3) {
				experienceLevel = arg0.getItemAtPosition(pos).toString();
			}

			public void onNothingSelected(AdapterView<?> arg0) {}
			
        });
        
        createAccountButton = (Button) this.findViewById(R.id.createAccountButton);
        createAccountButton.setOnClickListener(new OnClickListener(){

			public void onClick(View v) {
				// start Create New Account activity
				try
				{
					CommunicationAid.instance.profileManager.createProfile(nameText.getText().toString(), inputType, experienceLevel);
					// Log.i(CommunicationAid.LOG_TAG, "Created profile with Name = " + nameText.getText() + ", Input Type = " + inputType + " and Experience Level = " + experienceLevel);
					
					// set the current profile and display screen of profile's input type 
					CommunicationAid.instance.profileManager.setCurrentProfile(nameText.getText().toString());
					CommunicationAid.instance.displayInputScreenOfCurrProfile();
					finish();
				}
				catch(Exception e)
				{
					Log.e(CommunicationAid.LOG_TAG, e.getMessage());
					Log.e(CommunicationAid.LOG_TAG, "Failed to create profile with Name = " + nameText.getText() + ", Input Type = " + inputType + " and Experience Level = " + experienceLevel);
				}
			}
        	
        });
    }
}
