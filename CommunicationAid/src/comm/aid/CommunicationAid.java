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
        //Log.i(LOG_TAG, "Opening Login screen");
        setContentView(R.layout.login);
        
        newAccountButton = (Button) this.findViewById(R.id.createNewAccount);
        newAccountButton.setOnClickListener(new OnClickListener(){

			public void onClick(View v) {
				// start Create New Account activity
				startActivityForResult(new Intent(CommunicationAid.instance, CreateAccount.class), 0);
			}
        	
        });
        
        newAccountButton2 = (Button) this.findViewById(R.id.createNewAccount2);
        newAccountButton2.setOnClickListener(new OnClickListener(){

			public void onClick(View v) {
				// start Create New Account activity
				startActivityForResult(new Intent(CommunicationAid.instance, CreateAccount.class), 0);
			}
        	
        });
        
        existingAccountButton = (Button) this.findViewById(R.id.loginAccount);
        existingAccountButton.setOnClickListener(new OnClickListener(){

			public void onClick(View v) {
				// create ListView with all accounts
				Builder builder = new AlertDialog.Builder(CommunicationAid.instance);
				ListView list = new ListView(CommunicationAid.instance);
//				String[] accountNames = {"John Smith", "Mary Brown", "Mark Red", "Ivan Blue", "Tom Yellow", "Rob Green"};
				String[] accountNames = profileManager.getProfileNames();	// TODO(VL): Make the list alphabetic order?
				ArrayAdapter<String> listadapter = new ArrayAdapter<String>(CommunicationAid.instance, android.R.layout.simple_list_item_1, accountNames);
//				{
//			
//			            /* (non-Javadoc)
//			             * @see android.widget.ArrayAdapter#getView(int,
//			             * android.view.View, android.view.ViewGroup)
//			             */
//			            @Override
//			            public View getView( int position, View convertView, ViewGroup parent )
//			            {
//			            	TextView text = (TextView) super.getView(position, convertView, parent);
//			            	if (text != null){
//			            		text.setTextSize(18);
//			            		text.setMaxLines(1);
//				                text.setHorizontallyScrolling(true);
//			            		text.setEllipsize(TextUtils.TruncateAt.MIDDLE);
//			            	}
//			            	return text;
//			            }
//			
//			    };
			    
			    list.setAdapter(listadapter);
				builder.setTitle("Select Profile");
				builder.setItems(accountNames, new DialogInterface.OnClickListener() {
					public void onClick(DialogInterface dialog, int which) {
						Log.i(LOG_TAG, "Selected " + which);
						selectAccountDialog.dismiss();
						
						// TODO(VL): load selected profile's input type
						startActivityForResult(new Intent(CommunicationAid.instance, Joystick.class), 0);
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
				
				// TODO(VL): Handle suspend behavior of alert dialog. When the tablet is put to sleep while
				// the dialog is still up, it throws and exception and the dialog is no longer up
				// when the application is resumed.
			}
        	
        });
        update();
    }
    
    public void update()
    {
//      int num_profiles = 1;
      int num_profiles = profileManager.getProfileNames().length;
      Log.i(CommunicationAid.LOG_TAG, "UPDATE: Checking account number");
      if ( num_profiles <= 0 )
//      if (profileManager.getProfileNames() == null )
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
    
    public void onResume()
    {
    	super.onResume();
    	update();
    }
}
