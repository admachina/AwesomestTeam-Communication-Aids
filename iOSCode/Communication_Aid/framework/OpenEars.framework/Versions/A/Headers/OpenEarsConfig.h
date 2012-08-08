//  OpenEars _version 1.1_
//  http://www.politepix.com/openears
//
//  OpenEarsConfig.h
//  OpenEars
//
//  OpenEarsConfig.h controls all of the OpenEars compile-time settings
//
//  Copyright Politepix UG (haftungsbeschränkt) 2012. All rights reserved.
//  http://www.politepix.com
//  Contact at http://www.politepix.com/contact
//
//  This file is licensed under the Politepix Shared Source license found in the root of the source distribution.

// ********************************************************************************************************************************************************************
// ********************************************************************************************************************************************************************
// ********************************************************************************************************************************************************************
// IMPORTANT NOTE: This version of OpenEars has a low-latency audio driver for recognition. However, it is not compatible with the Simulator.
// Because I understand that it can be very frustrating to not be able to debug application logic in the Simulator, I have provided a second driver that is based on
// Audio Queue Services instead of Audio Units for use with the Simulator exclusively. However, this is purely provided as a convenience for you: please do not evaluate
// OpenEars' recognition quality based on the Simulator because it is better on the device, and please do not report Simulator-only bugs since I only actively support 
// the device driver and generally, audio code should never be seriously debugged on the Simulator since it is just hosting your own desktop audio devices. Thanks!
// ********************************************************************************************************************************************************************
// ********************************************************************************************************************************************************************
// ********************************************************************************************************************************************************************

// Uncomment only the voices you use in your app so that your binary size is as small as possible (commenting out a voice you use will cause a crash, so don't comment these out unless you know you aren't making any requests to use them with FliteController):
#define cmu_us_awb8k // Uncomment this in order to use the (faster) 8k version of the us_awb voice
#define cmu_us_rms8k // Uncomment this in order to use the (faster) 8k version of the us_rms voice
#define cmu_us_slt8k // Uncomment this in order to use the (faster) 8k version of the us_slt voice
#define cmu_time_awb // Uncomment this in order to use the 16k awb time voice
#define cmu_us_awb //  Uncomment this in order to use the 16k us_awb voice
#define cmu_us_kal //  Uncomment this in order to use the 8k us_kal voice
#define cmu_us_kal16 // Uncomment this in order to use the 16k us_kal voice
#define cmu_us_rms // Uncomment this in order to use the 16k us_rms voice
#define cmu_us_slt // Uncomment this in order to use the 16k us_slt voice
