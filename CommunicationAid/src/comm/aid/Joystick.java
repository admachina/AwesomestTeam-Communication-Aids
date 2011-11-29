package comm.aid;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class Joystick extends Activity {
	private EditText message;
	private Button charButtonUp;
	private Button charButtonDown;
	private Button charButtonLeft;
	private Button charButtonRight;
	
	private OnClickListener AddCharOnClickListener;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        //Log.i(CommunicationAid.LOG_TAG, "Opening Joystick screen");
        setContentView(R.layout.joystick);
        
        AddCharOnClickListener = new OnClickListener()
        {

			@Override
			public void onClick(View v) {
				Button b = (Button) v;
				String newText = getMessageText() + b.getText();
				setMessageText(newText);
			}
        	
        };
        
        // load screen widgets
        message = (EditText) this.findViewById(R.id.message);
        charButtonUp = (Button) this.findViewById(R.id.charButtonUp);
        charButtonUp.setOnClickListener(AddCharOnClickListener);
        charButtonDown = (Button) this.findViewById(R.id.charButtonDown);
        charButtonDown.setOnClickListener(AddCharOnClickListener);
        charButtonLeft = (Button) this.findViewById(R.id.charButtonLeft);
        charButtonLeft.setOnClickListener(AddCharOnClickListener);
        charButtonRight = (Button) this.findViewById(R.id.charButtonRight);
        charButtonRight.setOnClickListener(AddCharOnClickListener);
    }
    
    // Message widget methods
 
    public void setMessageText(String newText)
    {
    	message.setTextKeepState(newText, TextView.BufferType.EDITABLE);
		message.setSelection(newText.length());
    }
    
    public String getMessageText()
    {
    	return message.getText().toString();
    }
    
    // Button widgets method
    
    // 0 = up, 1 = right, 2 = down, 3 = left
    public void setButtonOption(int option, String optionText)
    {
    	switch( option ){
    	case 0:
    		charButtonUp.setText( optionText );
    	case 1:
    		charButtonRight.setText( optionText );
    	case 2:
    		charButtonDown.setText( optionText );
    	case 3:
    		charButtonLeft.setText( optionText );
    	}
    }
}