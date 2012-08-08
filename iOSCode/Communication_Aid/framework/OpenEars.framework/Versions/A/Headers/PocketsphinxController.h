//  OpenEars _version 1.1_
//  http://www.politepix.com/openears
//
//  PocketsphinxController.h
//  OpenEars
//
//  PocketsphinxController is a class which controls the creation and management of
//  a continuous speech recognition loop.
//
//  Copyright Politepix UG (haftungsbeschränkt) 2012. All rights reserved.
//  http://www.politepix.com
//  Contact at http://www.politepix.com/contact
//
//  This file is licensed under the Politepix Shared Source license found in the root of the source distribution.

#import <Foundation/Foundation.h>
#import "OpenEarsEventsObserver.h"
#import "ContinuousModel.h"
#import "AudioConstants.h"

@interface PocketsphinxController : NSObject <OpenEarsEventsObserverDelegate> {

	NSThread *voiceRecognitionThread; // The loop would lock if run on the main thread so it has a background thread in which it always runs.
	ContinuousModel *continuousModel; // The continuous model is the actual recognition loop.
	OpenEarsEventsObserver *openEarsEventsObserver; // We use an OpenEarsEventsObserver here to get important information from other objects which may be instantiated.
    float secondsOfSilenceToDetect;
    BOOL returnNbest;
    int nBestNumber;
    int calibrationTime; // This can only be one of the values '1', '2', or '3'. Defaults to 1.
    BOOL verbosePocketSphinx;
}

// These are the OpenEars methods for controlling Pocketsphinx. You should use these.

- (void) stopListening; // Exits from the recognition loop.
- (void) startListeningWithLanguageModelAtPath:(NSString *)languageModelPath dictionaryAtPath:(NSString *)dictionaryPath languageModelIsJSGF:(BOOL)languageModelIsJSGF;  // Starts the recognition loop.
- (void) suspendRecognition; // Stops interpreting sounds as speech without exiting from the recognition loop. You do not need to call these methods on behalf of Flite.
- (void) resumeRecognition; // Starts interpreting sounds as speech after suspending recognition with the preceding method. You do not need to call these methods on behalf of Flite.
- (void) changeLanguageModelToFile:(NSString *)languageModelPathAsString withDictionary:(NSString *)dictionaryPathAsString; // If you have already started the recognition loop and you want to switch to a different language model, you can use this and the model will be changed at the earliest opportunity. Will not have any effect unless recognition is already in progress.

// Here are all the multithreading methods, you should never do anything with any of these.
- (void) startVoiceRecognitionThreadWithLanguageModelAtPath:(NSString *)languageModelPath dictionaryAtPath:(NSString *)dictionaryPath languageModelIsJSGF:(BOOL)languageModelIsJSGF;
- (void) stopVoiceRecognitionThread;
- (void) waitForVoiceRecognitionThreadToFinish;
- (void) startVoiceRecognitionThreadAutoreleasePoolWithArray:(NSArray *)arrayOfLanguageModelItems; // This is the autorelease pool in which the actual business of our loop is handled.

// Suspend and resume that is initiated by Flite. Do not call these directly.
- (void) suspendRecognitionForFliteSpeech;
- (void) resumeRecognitionForFliteSpeech;

// Do not call this directly, set it by assigning a float value to secondsOfSilenceToDetect
- (void) setSecondsOfSilence;

- (Float32) pocketsphinxInputLevel; // This gives the input metering levels. This can only be run in a background thread that you create, otherwise it will block recognition

// Run one synchronous recognition pass on a recording from its beginning to its end and stop.

- (void) runRecognitionOnWavFileAtPath:(NSString *)wavPath usingLanguageModelAtPath:(NSString *)languageModelPath dictionaryAtPath:(NSString *)dictionaryPath languageModelIsJSGF:(BOOL)languageModelIsJSGF;

@property (nonatomic, retain) NSThread *voiceRecognitionThread; // The loop would lock if run on the main thread so it has a background thread in which it always runs.
@property (nonatomic, retain) ContinuousModel *continuousModel; // The continuous model is the actual recognition loop.
@property (nonatomic, retain) OpenEarsEventsObserver *openEarsEventsObserver; // We use an OpenEarsEventsObserver here to get important information from other objects which may be instantiated.
@property (nonatomic, assign) float secondsOfSilenceToDetect;
@property (nonatomic, assign) BOOL returnNbest;
@property (nonatomic, assign) int nBestNumber;
@property (nonatomic, assign) int calibrationTime; // This can only be one of the values '1', '2', or '3'. Defaults to 1.
@property (nonatomic, assign) BOOL verbosePocketSphinx;
@end
