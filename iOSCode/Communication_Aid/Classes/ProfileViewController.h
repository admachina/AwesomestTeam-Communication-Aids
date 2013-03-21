//
//  ProfileViewController.h
//  Communication_Aid
//
//  Created by Victor Tong on 2013-02-24.
//
//

#import <UIKit/UIKit.h>
#import "TextInputViewController.h"
/*

typedef struct MyStreamInfo {
    CFWriteStreamRef  writeStream;
    
    CFReadStreamRef   readStream;
    
    CFDictionaryRef   proxyDict;
    
    SInt64            fileSize;
    
    UInt32            totalBytesWritten;
    
    UInt32            leftOverByteCount;
    
    UInt8             buffer[32768];
} MyStreamInfo;*/

@interface ProfileViewController : UITableViewController<NSStreamDelegate> {
    NSMutableArray* profiles;
    TextInputViewController* textInputViewController;
    IBOutlet UIButton* syncButton;
    NSInputStream* networkStream;
    NSMutableString* therapistName;
    NSMutableData* listData;
    NSMutableArray* listEntries;
    bool listingFiles;
    int numBytesReceivedSoFar;
    int numBytesNeeding;
    bool downloadingInProgress;
    int numFilesReceived;
    /*NSNumber* numBytesReceivedSoFar;
    NSNumber* numBytesNeeding;*/
    //MyStreamInfo streamInfo;
}

@property(nonatomic, retain) NSMutableArray* profiles;
@property(nonatomic, retain) TextInputViewController* textInputViewController;
@property(nonatomic, retain) UIButton* syncButton;
@property (nonatomic, strong, readwrite) NSInputStream* networkStream;
@property(atomic, retain) NSMutableString* therapistName;
@property (nonatomic, strong, readwrite) NSMutableData *   listData;
@property (nonatomic, strong, readwrite) NSMutableArray *  listEntries;
/*@property(nonatomic) NSNumber* numBytesReceivedSoFar;
@property(nonatomic) NSNumber* numBytesNeeding;*/
//@property(nonatomic) MyStreamInfo streamInfo;

- (id)initWithTextInputView:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil textInputViewController:(TextInputViewController *)newTextInputViewController;
- (void) repopulateProfiles;
- (IBAction) buttonPressed:(id)sender;
//- (void)readStreamCallback:(CFReadStreamRef)readStream event:(CFStreamEventType)eventType info:(MyStreamInfo*)info;

- (void)parseListData;
- (NSDictionary *)entryByReencodingNameInEntry:(NSDictionary *)entry encoding:(NSStringEncoding)newEncoding;

- (void) downloadAllFilesForTherapist;
- (void) resetNetworkStream;
- (NSMutableString*) getTherapistURL;
- (void) startNetworkStream:(NSString*)url;

@end
