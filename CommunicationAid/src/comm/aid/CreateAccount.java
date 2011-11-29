package comm.aid;

import android.app.Activity;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.Spinner;

public class CreateAccount extends Activity {
	private Spinner inputDeviceSpinner;
	private Spinner difficultyLevelSpinner;
	
	/** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        setContentView(R.layout.create_account);
        
        inputDeviceSpinner = (Spinner) findViewById(R.id.input_device_spinner);
        ArrayAdapter<CharSequence> input_device_adapter = ArrayAdapter.createFromResource(CommunicationAid.instance, R.array.input_device_types, android.R.layout.simple_spinner_item);
        input_device_adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
    	inputDeviceSpinner.setAdapter(input_device_adapter);
    	
    	difficultyLevelSpinner = (Spinner) findViewById(R.id.difficulty_level_spinner);
        ArrayAdapter<CharSequence> difficulty_level_adapter = ArrayAdapter.createFromResource(CommunicationAid.instance, R.array.difficulty_level_types, android.R.layout.simple_spinner_item);
        input_device_adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        difficultyLevelSpinner.setAdapter(difficulty_level_adapter);
    }
}
