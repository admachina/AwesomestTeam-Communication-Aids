//  OpenEars _version 1.1_
//  http://www.politepix.com/openears
//
//  FliteController.h
//  OpenEars
//
//  FliteController is a class which manages text-to-speech
//
//  Copyright Politepix UG (haftungsbeschränkt) 2012. All rights reserved.
//  http://www.politepix.com
//  Contact at http://www.politepix.com/contact
//
//  This file is licensed under the Politepix Shared Source license found in the root of the source distribution.

#import <AVFoundation/AVFoundation.h>

#import "OpenEarsEventsObserver.h"
#import "AudioConstants.h"

@interface FliteController : NSObject <AVAudioPlayerDelegate, OpenEarsEventsObserverDelegate> {

	AVAudioPlayer *audioPlayer; // Plays back the speech
	OpenEarsEventsObserver *openEarsEventsObserver; // Observe status changes from audio sessions and Pocketsphinx
	NSData *speechData;
	BOOL speechInProgress;
	float duration_stretch;
	float target_mean;
	float target_stddev;
    BOOL userCanInterruptSpeech;
}

// These are the only methods to be called directly by an OpenEars project
- (void) say:(NSString *)statement withVoice:(NSString *)voice;
- (Float32) fliteOutputLevel;
// End methods to be called directly by an OpenEars project

// Interruption handling
- (void) interruptionRoutine:(AVAudioPlayer *)player;
- (void) interruptionOverRoutine:(AVAudioPlayer *)player;

// Handling not doing voice recognition on Flite speech, do not directly call
- (void) sendResumeNotificationOnMainThread;
- (void) sendSuspendNotificationOnMainThread;
- (void) interruptTalking;
@property (nonatomic, assign) BOOL speechInProgress;
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;  // Plays back the speech
@property (nonatomic, retain) OpenEarsEventsObserver *openEarsEventsObserver; // Observe status changes from audio sessions and Pocketsphinx
@property (nonatomic, retain) NSData *speechData;
@property (nonatomic, assign) float duration_stretch;
@property (nonatomic, assign) float target_mean;
@property (nonatomic, assign) float target_stddev;
@property (nonatomic, assign) BOOL userCanInterruptSpeech;

@end





