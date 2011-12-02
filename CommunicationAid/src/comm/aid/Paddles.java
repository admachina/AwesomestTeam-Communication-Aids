package comm.aid;

import android.app.Activity;
import android.os.Bundle;
import android.view.Window;
import android.widget.TextView;

public class Paddles extends Activity {
	private TextView usernameText;
	
	 /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.paddles);
        
        usernameText = (TextView) this.findViewById(R.id.username);
        usernameText.setText(CommunicationAid.instance.profileManager.getCurrentProfile().getName());
    }

}
