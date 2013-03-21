//
//  ProfileViewController.m
//  Communication_Aid
//
//  Created by Victor Tong on 2013-02-24.
//
//

#import "ProfileViewController.h"
#import <sqlite3.h>
#import "Profile.h"
#import "TreeNavigator.h"
#import "DictionaryParser.h"
#import "SelectionTree.h"
#import "XMLTreeCreator.h"


@implementation ProfileViewController

@synthesize profiles;
@synthesize textInputViewController;
@synthesize syncButton;
@synthesize networkStream = _networkStream;
@synthesize therapistName;
@synthesize listData;
@synthesize listEntries;
/*
@synthesize numBytesReceivedSoFar;
@synthesize numBytesNeeding;
*/
/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.profiles = nil;
    }
    return self;
}*/


- (id)initWithTextInputView:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { 
        profiles = nil;
        networkStream = nil;
//        textInputViewController = [newTextInputViewController retain];
        therapistName =[[NSMutableString alloc ] initWithFormat:@"therapist1"];
        numBytesReceivedSoFar = [[NSNumber alloc ] initWithInt:0];
        //[self downloadAllFilesForTherapist];
    }
    return self;
}

- (NSMutableString*) getTherapistURL {
    //therapistName =[NSMutableString stringWithFormat:@"therapist1"];
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"ftp://admin:Awesome1@commaid-1.cloudapp.net:21"];
    
    [urlStr appendString:@"/"];
    [urlStr appendString:therapistName];
    [urlStr appendString:@"/"];
    return urlStr;
}

- (void) downloadAllFilesForTherapist {
    [self resetNetworkStream];
    self.listEntries = nil;
    self.listEntries = [NSMutableArray array];
    listingFiles = true;
    NSMutableString* urlStr = [self getTherapistURL];
    
    //[urlStr appendString:@"?passive"];
    
    NSString* immutableUrlStr = [NSString stringWithString:urlStr];
    
    NSLog(immutableUrlStr);
    
    [self startNetworkStream:immutableUrlStr];
}

- (void) startNetworkStream:(NSString*)url
{
    self.listData = [NSMutableData data];
    CFURLRef urlRef = CFURLCreateWithString(NULL, (CFStringRef) url, NULL);
    self.networkStream = CFBridgingRelease(CFReadStreamCreateWithFTPURL(NULL, (/*__bridge*/ CFURLRef) urlRef));
    self.networkStream.delegate = self;
    [self.networkStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.networkStream open];
    CFRelease(urlRef);
}

- (void) resetNetworkStream {
    if (self.networkStream != nil) {
        [self.networkStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.networkStream.delegate = nil;
        [self.networkStream close];
        self.networkStream = nil;
        self.listData = nil;
    }
}

- (void) downloadFile:(NSString*)file bytes:(NSNumber*)bytes {
    [self resetNetworkStream];
    numBytesReceivedSoFar = 0;
    numBytesNeeding = [bytes intValue];
    NSMutableString* urlStr = [self getTherapistURL];
    [urlStr appendString:file];
    //[urlStr appendString:@"/"];
    [self startNetworkStream:urlStr];
    /*while (numBytesReceivedSoFar < [bytes intValue]) {
        // Busy wait
    }*/
}

- (void) writeFile {
    //assert([bytes intValue] == [self.listData length]);
    NSString* file = [[self.listEntries objectAtIndex:(numFilesReceived)] objectForKey:(id) kCFFTPResourceName];
    NSString* pathForDirectory = [self getPathForDirectory];
    NSString* pathForFile = [self getPathForFile:file];
    
    NSError *error;
    
    // Use empty string to create file
    /*NSString* emptyString = @"";
    [emptyString writeToFile:pathForFile atomically:YES encoding:NSUTF8StringEncoding error:&error];
    */
    NSLog(pathForDirectory);
    NSLog(pathForFile);
    
    if (![[NSFileManager defaultManager] createDirectoryAtPath:pathForDirectory
                                   withIntermediateDirectories:YES
                                                    attributes:nil
                                                         error:&error])
    {
        NSLog(@"Create directory error: %@", error);
    }
    
    if (![[NSFileManager defaultManager] createFileAtPath:pathForFile contents:self.listData attributes:nil]) {
        NSLog(@"Failed to create file.");
    }
    
    /*
    
    NSOutputStream* fileStream = [NSOutputStream outputStreamToFileAtPath:pathForFile append:NO];
    
    
    uint8_t* buffer = self.listData.bytes;
    NSUInteger bytesToWrite = self.listData.length;
    
    
    NSInteger bytesWrittenSoFar = 0;
    NSInteger bytesWritten;
    do {
        bytesWritten = [fileStream write:&buffer[bytesWrittenSoFar] maxLength:(NSUInteger) (bytesToWrite - bytesWrittenSoFar)];
        //assert(bytesWritten != 0);
        if (bytesWritten == -1) {
            NSLog(@"Error writing file");
            //[self stopReceiveWithStatus:@"File write error"];
            break;
        } else {
            bytesWrittenSoFar += bytesWritten;
        }
    } while (bytesWrittenSoFar != bytesToWrite);
    
    [fileStream close];*/
    
    //[self.listData replaceBytesInRange:NSMakeRange(0, bytesToWrite) withBytes:NULL length:0];
}

- (NSString*) getPathForFile:(NSString*)file {
    NSStringCompareOptions options = NSBackwardsSearch;
    NSRange dotRange = [file rangeOfString:@"." options:options];
    NSUInteger dotIndex = dotRange.location;
    NSString* fileName = [file substringToIndex:dotIndex];
    NSString* fileExtension = [file substringFromIndex:dotIndex+1];
    //return [[NSBundle mainBundle] pathForResource:fileName ofType:fileExtension inDirectory:therapistName];
    //NSMutableString* filePath = [NSMutableString stringWithString:[[NSBundle mainBundle] bundlePath]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSMutableString* filePath = [NSMutableString stringWithString:documentsDirectory];
    
    
    [filePath appendString:@"/"];
    [filePath appendString:therapistName];
    [filePath appendString:@"/"];
    [filePath appendString:file];
    NSString* str = [NSString stringWithString:filePath];
    return str;
    //return [NSString stringWithString:filePath];
}

- (NSString*) getPathForDirectory {
    //return [[NSBundle mainBundle] pathForResource:fileName ofType:fileExtension inDirectory:therapistName];
    //NSMutableString* filePath = [NSMutableString stringWithString:[[NSBundle mainBundle] bundlePath]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSMutableString* filePath = [NSMutableString stringWithString:documentsDirectory];
    
    [filePath appendString:@"/"];
    [filePath appendString:therapistName];
    NSString* str = [NSString stringWithString:filePath];
    return str;
    //return [NSString stringWithString:filePath];
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
// An NSStream delegate callback that's called when events happen on our
// network stream.
{
//#pragma unused(aStream)
    assert(aStream == self.networkStream);
    
    switch (eventCode) {
        case NSStreamEventOpenCompleted: {
            NSLog(@"Opened Connection");
            //[self updateStatus:@"Opened connection"];
        } break;
        case NSStreamEventHasBytesAvailable: {
            NSLog(@"Has Bytes Available");
            
            NSInteger       bytesRead;
            uint8_t         buffer[32768];
            
            //[self updateStatus:@"Receiving"];
            
            // Pull some data off the network.
            
            bytesRead = [self.networkStream read:buffer maxLength:sizeof(buffer)];
            if (bytesRead < 0) {
                NSLog(@"Network read error");
            } else if (bytesRead == 0) {
                NSLog(@"No Bytes Read");
            } else {
                NSLog(@"Read %d bytes",bytesRead);
                if (listingFiles) {
                    assert(self.listData != nil);
                    
                    // Append the data to our listing buffer.
                    
                    [self.listData appendBytes:buffer length:(NSUInteger) bytesRead];
                    
                    // Check the listing buffer for any complete entries and update
                    // the UI if we find any.
                    
                    [self parseListData];
                } else {
                    assert(self.listData != nil);
                    [self.listData appendBytes:buffer length:(NSUInteger) bytesRead];
                    
                    numBytesNeeding -= bytesRead;
                    if (numBytesNeeding < 0) {
                        NSLog(@"Read more bytes than expected");
                    } else if (numBytesNeeding == 0) {
                        NSLog(@"Writing File");
                        [self writeFile];
                        numFilesReceived++;
                        if (numFilesReceived == [self.listEntries count]) {
                            // Done downloading all files
                            NSLog(@"Done downloading all files");
                            [self resetNetworkStream];
                            downloadingInProgress = false;
                        } else {
                            // Keep downloading more files
                            [self fetchNextFileInList];
                        }
                    }
                    
                }
            }
        } break;
        case NSStreamEventHasSpaceAvailable: {
            assert(NO);     // should never happen for the output stream
        } break;
        case NSStreamEventErrorOccurred: {
            NSLog(@"Event Error Occurred");
            NSError* error = [self.networkStream streamError];
            NSString* errorMessage = [NSString stringWithFormat:@"%@ (Code = %d)",
                                      [error localizedDescription],
                                      [error code]];
            NSLog(errorMessage);
            
            //[self stopReceiveWithStatus:@"Stream open error"];
        } break;
        case NSStreamEventEndEncountered: {
            // ignore
        } break;
        default: {
            assert(NO);
        } break;
    }
}

- (NSDictionary *)entryByReencodingNameInEntry:(NSDictionary *)entry encoding:(NSStringEncoding)newEncoding
// CFFTPCreateParsedResourceListing always interprets the file name as MacRoman,
// which is clearly bogus <rdar://problem/7420589>.  This code attempts to fix
// that by converting the Unicode name back to MacRoman (to get the original bytes;
// this works because there's a lossless round trip between MacRoman and Unicode)
// and then reconverting those bytes to Unicode using the encoding provided.
{
    NSDictionary *  result;
    NSString *      name;
    NSData *        nameData;
    NSString *      newName;
    
    newName = nil;
    
    // Try to get the name, convert it back to MacRoman, and then reconvert it
    // with the preferred encoding.
    
    name = [entry objectForKey:(id) kCFFTPResourceName];
    if (name != nil) {
        assert([name isKindOfClass:[NSString class]]);
        
        nameData = [name dataUsingEncoding:NSMacOSRomanStringEncoding];
        if (nameData != nil) {
            newName = [[NSString alloc] initWithData:nameData encoding:newEncoding];
        }
    }
    
    // If the above failed, just return the entry unmodified.  If it succeeded,
    // make a copy of the entry and replace the name with the new name that we
    // calculated.
    
    if (newName == nil) {
        assert(NO);                 // in the debug builds, if this fails, we should investigate why
        result = (NSDictionary *) entry;
    } else {
        NSMutableDictionary *   newEntry;
        
        newEntry = [entry mutableCopy];
        assert(newEntry != nil);
        
        [newEntry setObject:newName forKey:(id) kCFFTPResourceName];
        
        result = newEntry;
    }
    
    return result;
}

- (void)parseListData
{
    NSMutableArray *    newEntries;
    NSUInteger          offset;
    
    // We accumulate the new entries into an array to avoid a) adding items to the
    // table one-by-one, and b) repeatedly shuffling the listData buffer around.
    
    newEntries = [NSMutableArray array];
    assert(newEntries != nil);
    
    offset = 0;
    do {
        CFIndex         bytesConsumed;
        CFDictionaryRef thisEntry;
        
        thisEntry = NULL;
        
        assert(offset <= [self.listData length]);
        bytesConsumed = CFFTPCreateParsedResourceListing(NULL, &((const uint8_t *) self.listData.bytes)[offset], (CFIndex) ([self.listData length] - offset), &thisEntry);
        if (bytesConsumed > 0) {
            
            // It is possible for CFFTPCreateParsedResourceListing to return a
            // positive number but not create a parse dictionary.  For example,
            // if the end of the listing text contains stuff that can't be parsed,
            // CFFTPCreateParsedResourceListing returns a positive number (to tell
            // the caller that it has consumed the data), but doesn't create a parse
            // dictionary (because it couldn't make sense of the data).  So, it's
            // important that we check for NULL.
            
            if (thisEntry != NULL) {
                NSDictionary *  entryToAdd;
                
                // Try to interpret the name as UTF-8, which makes things work properly
                // with many UNIX-like systems, including the Mac OS X built-in FTP
                // server.  If you have some idea what type of text your target system
                // is going to return, you could tweak this encoding.  For example,
                // if you know that the target system is running Windows, then
                // NSWindowsCP1252StringEncoding would be a good choice here.
                //
                // Alternatively you could let the user choose the encoding up
                // front, or reencode the listing after they've seen it and decided
                // it's wrong.
                //
                // Ain't FTP a wonderful protocol!
                
                entryToAdd = [self entryByReencodingNameInEntry:(NSDictionary *) thisEntry encoding:NSUTF8StringEncoding];
                
                [newEntries addObject:entryToAdd];
                
                NSLog([entryToAdd objectForKey:(id) kCFFTPResourceName]);
            }
            
            // We consume the bytes regardless of whether we get an entry.
            
            offset += (NSUInteger) bytesConsumed;
        }
        
        if (thisEntry != NULL) {
            CFRelease(thisEntry);
        }
        
        if (bytesConsumed == 0) {
            // We haven't yet got enough data to parse an entry.  Wait for more data
            // to arrive.
            break;
        } else if (bytesConsumed < 0) {
            // We totally failed to parse the listing.  Fail.
            //[self stopReceiveWithStatus:@"Listing parse failed"];
            NSLog(@"Listing parse failed");
            break;
        }
    } while (YES);
    
    if ([newEntries count] != 0) {
        [self.listEntries addObjectsFromArray:newEntries];
        NSLog(@"%i", [newEntries count]);
        numFilesReceived = 0;
        [self fetchNextFileInList];
    }
    /*if (offset != 0) {
        [self.listData replaceBytesInRange:NSMakeRange(0, offset) withBytes:NULL length:0];
    }*/
}

- (void) fetchNextFileInList {
    listingFiles = false;
    
    //NSUInteger currentIndex = 0;
    NSUInteger currentIndex = numFilesReceived;
    
    if (currentIndex < [self.listEntries count]) {
        NSDictionary* listEntry = [self.listEntries objectAtIndex:(currentIndex)];
        NSString* name = [listEntry objectForKey:(id) kCFFTPResourceName];
        NSNumber* sizeNum = [listEntry objectForKey:(id) kCFFTPResourceSize];
        [self downloadFile:name bytes:sizeNum];
    }
}


/*
- (void)readStreamCallback:(CFReadStreamRef)readStream event:(CFStreamEventType)eventType info:(MyStreamInfo*)info
{
    
}*/

- (void)dealloc {
    if (profiles != nil) {
        [profiles release];
	}
    [textInputViewController release];
    [syncButton dealloc];
    [self resetNetworkStream];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self repopulateProfiles];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.profiles count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
    static NSString* MyIdentifier = @"ID";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
    }
    
    Profile* profile = (Profile*)[profiles objectAtIndex:indexPath.row];
    
    [cell setText:profile.name];
    
    return cell;
}

-(void) tableView:(UITableView*) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Make it initialize the TextInputViewController properly with the profile information.
//    DictionaryParser* parser = [[DictionaryParser alloc] init];
//    SelectionTree* basicTree = [parser parse:basicTreeFile:@"Basic"];
//    SelectionTree* coreWordsTree = [parser parse:coreWordsTreeFile:@"Core"];
//    
//    SelectionTree* mainMenu = [[SelectionTree alloc] init];
//    [mainMenu setRoot:TRUE];
//    
//    [mainMenu addNode:basicTree];
//    [mainMenu addNode:coreWordsTree];
    
    //Test code
    SelectionTree* tree = [[SelectionTree alloc]init : @"" : @""];
     [tree setRoot:true];
     [tree addNode:[[SelectionTree alloc] init:@"A" :@"A"]];
     [tree addNode:[[SelectionTree alloc] init:@"S" :@"S"]];
     [tree addNode:[[SelectionTree alloc] init:@"D" :@"D"]];
    [tree addNode:[[SelectionTree alloc] init:@"E" :@"E"]];
    [tree addNode:[[SelectionTree alloc] init:@"F" :@"F"]];
    [tree addNode:[[SelectionTree alloc] init:@"G" :@"G"]];
    [tree addNode:[[SelectionTree alloc] init:@"L" :@"L"]];
     SelectionTree* next = [tree addNode:[[SelectionTree alloc] init:@"More" :@""]];
    [next addNode:[[SelectionTree alloc] init:@"1" :@"1"]];
    [next addNode:[[SelectionTree alloc] init:@"2" :@"2"]];
    [next addNode:[[SelectionTree alloc] init:@"3" :@"3"]];
    [next addNode:[[SelectionTree alloc] init:@"4" :@"4"]];
    [next addNode:[[SelectionTree alloc] init:@"5" :@"5"]];
    [next addNode:[[SelectionTree alloc] init:@"6" :@"6"]];
    [next addNode:[[SelectionTree alloc] init:@"7" :@"7"]];
    SelectionTree* next2 = [next addNode:[[SelectionTree alloc] init:@"More" :@""]];
    [next2 addNode:[[SelectionTree alloc] init:@"11" :@"11"]];
    [next2 addNode:[[SelectionTree alloc] init:@"22" :@"23"]];
    [next2 addNode:[[SelectionTree alloc] init:@"33" :@"33"]];
    [next2 addNode:[[SelectionTree alloc] init:@"44" :@"44"]];
    [next2 addNode:[[SelectionTree alloc] init:@"55" :@"55"]];
    [next2 addNode:[[SelectionTree alloc] init:@"66" :@"66"]];
    [next2 addNode:[[SelectionTree alloc] init:@"77" :@"77"]];
    //End test code
//    TreeNavigator* navigator = [[TreeNavigator alloc] initWithTree:[XMLTreeCreator createTree:@"defaultTree.xml"]];
    TreeNavigator* navigator = [[TreeNavigator alloc] initWithTree:tree];
    
    Profile* profile = [profiles objectAtIndex:indexPath.row];
    textInputViewController = [[TextInputViewController alloc] initWithNavigator:@"TextInputViewController" bundle:[NSBundle mainBundle] navigator:navigator profile:profile];
    
    
    [self.view addSubview:[textInputViewController view]];
}
/*
-(void) tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section {
    
}*/

- (IBAction) buttonPressed:(id)sender
{
    NSLog(@"Button Pressed");
    if ((UIButton*) sender == syncButton) {
        // Sync the profiles from FTP server
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Connecting to server..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
        [alertView show];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.center = CGPointMake(alertView.bounds.size.width * 0.5f, alertView.bounds.size.height * 0.5f+5.0f);
        //spinner.center = CGPointMake(160, 240);
        spinner.hidesWhenStopped = YES;
        //[self.view addSubview:spinner];
        [spinner startAnimating];
        [alertView addSubview:spinner];
        [spinner release];
        downloadingInProgress = true;
        [self downloadAllFilesForTherapist];
        
        dispatch_queue_t downloadQueue = dispatch_queue_create("downloader", NULL);
        dispatch_async(downloadQueue, ^{
        //dispatch_async(dispatch_get_main_queue(), ^{
            
            // do our long running process here
            //[NSThread sleepForTimeInterval:3];
            
            //CFWriteStreamRef writeStream =
            while (downloadingInProgress) {
                // busy wait
            }
            
            // do any UI stuff on the main UI thread
            dispatch_async(dispatch_get_main_queue(), ^{
                //self.myLabel.text = @"After!";
                [self repopulateProfiles];
                //[self.view setNeedsDisplay];
                [self.tableView reloadData];
                [spinner stopAnimating];
                [alertView dismissWithClickedButtonIndex:0 animated:YES];
            });
        });
        dispatch_release(downloadQueue);
    }
}

- (void) repopulateProfiles
{
    // Setup sqlite db
    sqlite3* sqliteDb;
    NSString* sqlitePath = [self getPathForFile:@"profiles.sqlite"];
    //NSLog(sqlitePath);
    NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
    //NSLog(bundlePath);
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:sqlitePath];
    if (!fileExists || sqlite3_open([sqlitePath UTF8String], &sqliteDb) != SQLITE_OK) {
        sqlitePath = [[NSBundle mainBundle] pathForResource:@"profiles"ofType:@"sqlite"];
        //NSLog(sqlitePath);
        fileExists = [[NSFileManager defaultManager] fileExistsAtPath:sqlitePath];
        if (!fileExists || sqlite3_open([sqlitePath UTF8String], &sqliteDb) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
            return;
        }
    }
        self.profiles = [[NSMutableArray alloc] init];
        
        // Read sqlite file and store data
        NSString *query = @"SELECT profiles.profile_id, profiles.name, profiles.difficulty, profiles.dimensions, profile_tree.tree_path FROM profiles INNER JOIN profile_tree ON profiles.profile_id = profile_tree.profile_id ORDER BY profiles.profile_id ASC";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(sqliteDb, [query UTF8String], -1, &statement, nil)
            == SQLITE_OK) {
            Profile *info = nil;
            while (sqlite3_step(statement) == SQLITE_ROW) {
                int profileId = sqlite3_column_int(statement, 0);
                char *nameChars = (char *) sqlite3_column_text(statement, 1);
                char *difficultyChars = (char *) sqlite3_column_text(statement, 2);
                int profileDimensions = sqlite3_column_int(statement, 3);
                char *treePathChars = (char *) sqlite3_column_text(statement, 4);
                NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
                NSString *difficultyStr = [[NSString alloc] initWithUTF8String:difficultyChars];
                NSString *treepath = [[NSString alloc] initWithUTF8String:treePathChars];
                NSMutableArray* treepaths = [[NSMutableArray alloc] init];
                
                NSMutableString* fullTreePath = [NSMutableString stringWithString:treepath];
                [fullTreePath insertString:@"/" atIndex:0];
                [fullTreePath insertString:bundlePath atIndex:0];
                //NSLog(fullTreePath);
                NSString* fullTreePathImuutable = [NSString stringWithString:fullTreePath];
                //NSLog(fullTreePathImuutable);
                
                Difficulty difficulty = [Profile getDifficultyForString:difficultyStr];
                if (difficulty == INVALID) {
                    NSLog(@"%@, %@", @"Failed to process string", difficultyStr);
                    continue;
                }
                
                if (info != nil && [info profile_id] == profileId) {
                    // Do nothing. Reuse the same info
                    assert([info.name isEqualToString:name]);
                    assert(info.difficulty == difficulty);
                } else {
                info = [[Profile alloc]
                        initWithId:profileId name:name treepath:treepaths difficulty:difficulty dimensions:profileDimensions];
                }
                [info addToTreePaths:fullTreePathImuutable];
                [self.profiles addObject:info];
                [name release];
                [treepath release];
                [treepaths release];
                [info release];
                [difficultyStr release];
            }
            sqlite3_finalize(statement);
        }
        
        // Close db
        sqlite3_close(sqliteDb);
    
}

@end
