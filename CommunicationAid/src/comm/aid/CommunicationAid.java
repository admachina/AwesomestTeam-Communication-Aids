package comm.aid;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;

public class CommunicationAid extends Activity {
	public static CommunicationAid instance;
	public static String LOG_TAG = "CommunicationAid";
	private Button newAccountButton;
	private Button existingAccountButton;
	
	/** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        instance = this;
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        //Log.i(LOG_TAG, "Opening Login screen");
        setContentView(R.layout.login);
        
        newAccountButton = (Button) this.findViewById(R.id.createNewAccount);
        newAccountButton.setOnClickListener(new OnClickListener(){

			@Override
			public void onClick(View v) {
				// display Create New Account screen
				startActivityForResult(new Intent(CommunicationAid.instance, CreateAccount.class), 0);
				//CommunicationAid.instance.getDir("Accounts", 0);
			}
        	
        });
        
        existingAccountButton = (Button) this.findViewById(R.id.loginAccount);
        existingAccountButton.setOnClickListener(new OnClickListener(){

			@Override
			public void onClick(View v) {
				// create ListView with all accounts
				setContentView(R.layout.joystick);
			}
        	
        });
    }
}
