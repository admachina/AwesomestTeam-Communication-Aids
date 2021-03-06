package comm.aid;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.TextView;
import android.view.ViewGroup;
import android.text.TextUtils;

public class CommunicationAid extends Activity {
	public static CommunicationAid instance;
	public static String LOG_TAG = "CommunicationAid";
	private Button newAccountButton, newAccountButton2;
	private Button existingAccountButton;
	private AlertDialog selectAccountDialog;
	public ProfileManager profileManager;
	
	private OnClickListener OpenCreateProfileOnClickListener;
	
	/** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        instance = this;
        try
        {
        	profileManager = new ProfileManager();
        }
        catch( Exception e )
        {
        	Log.e(LOG_TAG, "Error reading in profile files");
        }
        
        //requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.login);
        
        OpenCreateProfileOnClickListener = new OnClickListener()
        {
        	public void onClick(View v) {
				// start Create New Account activity
				startActivityForResult(new Intent(CommunicationAid.instance, CreateAccount.class), 0);
			}
        };
        
        newAccountButton = (Button) this.findViewById(R.id.createNewAccount);
        newAccountButton.setOnClickListener(OpenCreateProfileOnClickListener);
        
        newAccountButton2 = (Button) this.findViewById(R.id.createNewAccount2);
        newAccountButton2.setOnClickListener(OpenCreateProfileOnClickListener);
        
        existingAccountButton = (Button) this.findViewById(R.id.loginAccount);
        existingAccountButton.setOnClickListener(new OnClickListener(){

			public void onClick(View v) {
				// create ListView with all existing accounts
				Builder builder = new AlertDialog.Builder(CommunicationAid.instance);
				ListView list = new ListView(CommunicationAid.instance);
				final String[] accountNames = profileManager.getProfileNames();	// TODO(VL): Make the list alphabetic order?
				ArrayAdapter<String> listadapter = new ArrayAdapter<String>(CommunicationAid.instance, android.R.layout.simple_list_item_1, accountNames);
			    
			    list.setAdapter(listadapter);
				builder.setTitle(R.string.select_profile_prompt);
				builder.setItems(accountNames, new DialogInterface.OnClickListener() {
					public void onClick(DialogInterface dialog, int which) {
						selectAccountDialog.dismiss();
						
						// set the current profile and load screen of profile's input type
						profileManager.setCurrentProfile(accountNames[which]);
						CommunicationAid.instance.displayInputScreenOfCurrProfile();
					}
				});
				
				builder.setNegativeButton("Back", new DialogInterface.OnClickListener() {
					public void onClick(DialogInterface dialog, int which) {
						selectAccountDialog.dismiss();
					}
					
				});
				
//				builder.setPositiveButton("OK", new DialogInterface.OnClickListener() {
//					public void onClick(DialogInterface dialog, int which) {
//					}
//				});
				selectAccountDialog = builder.show();
				
				// TODO: Handle suspend behavior of alert dialog. When the tablet is put to sleep while
				// the dialog is still up, it throws and exception (see logs) and the dialog is no longer up
				// when the application is resumed.
			}
        	
        });
        update();
    }
    
    public void update()
    {
    	int num_profiles = profileManager.getProfileNames().length;
    	if ( num_profiles <= 0 )
    	{
    		newAccountButton.setVisibility(View.GONE);
    		existingAccountButton.setVisibility(View.GONE);
    		newAccountButton2.setVisibility(View.VISIBLE);
    	}
    	else
    	{
    		newAccountButton2.setVisibility(View.GONE);
    		newAccountButton.setVisibility(View.VISIBLE);
    		existingAccountButton.setVisibility(View.VISIBLE);
      	}
    }
    
    // start input activity of current profile's input type
    public void displayInputScreenOfCurrProfile()
    {
		String input_type = profileManager.getCurrentProfile().getInputType().toString();
		if ( input_type.equals("Joystick") )
		{
			startActivityForResult(new Intent(CommunicationAid.instance, Joystick.class), 0);
		}
		else if ( input_type.equals("Paddles") )
		{
			startActivityForResult(new Intent(CommunicationAid.instance, Paddles.class), 0);
		}
		else
		{
			startActivityForResult(new Intent(CommunicationAid.instance, Straw.class), 0);
		}
    }
    
    public void onResume()
    {
    	super.onResume();
    	update();
    }
}
