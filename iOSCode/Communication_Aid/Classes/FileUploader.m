//
//  FileUploader.m
//  Communication_Aid
//
//  Created by Victor Tong on 2013-03-21.
//
//

#import "FileUploader.h"

@implementation FileUploader
@synthesize dataToUpload;
@synthesize networkStream;
@synthesize fileBytes;
@synthesize fileBytesOffset;
@synthesize therapistName;

- (id)initWithData:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data:(NSString*)data therapistName:(NSString*)therapistName fileNameOnServer:(NSString*)fileNameOnServer {
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        networkStream = nil;
        self.therapistName =[[NSMutableString alloc ] initWithFormat:@"therapist1"];
        //numBytesReceivedSoFar = [[NSNumber alloc ] initWithInt:0];
        //[self downloadAllFilesForTherapist];
        self.fileBytesOffset = 0;
        
        self.fileBytes = [data dataUsingEncoding:NSUTF8StringEncoding];
        [self.fileBytes retain];
        
        NSMutableString* url = [self getTherapistURL];
        [url appendString:fileNameOnServer];
        NSString* urlStr = [NSString stringWithString:url];
        NSLog(urlStr);
        [self startNetworkStream:urlStr];
    }
    return self;
}

- (bool) isDone {
    return self.fileBytes.length == self.fileBytesOffset;
}

- (NSMutableString*) getTherapistURL {
    //therapistName =[NSMutableString stringWithFormat:@"therapist1"];
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"ftp://admin:Awesome1@commaid-1.cloudapp.net:21"];
    
    [urlStr appendString:@"/"];
    [urlStr appendString:therapistName];
    [urlStr appendString:@"/"];
    return urlStr;
}

- (void) startNetworkStream:(NSString*)url
{
    //self.listData = [NSMutableData data];
    CFURLRef urlRef = CFURLCreateWithString(NULL, (CFStringRef) url, NULL);
    self.networkStream = CFBridgingRelease(CFWriteStreamCreateWithFTPURL(NULL, (/*__bridge*/ CFURLRef) urlRef));
    self.networkStream.delegate = self;
    [self.networkStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.networkStream open];
    CFRelease(urlRef);
}

- (void) dealloc {
    if (self.networkStream != nil) {
        [self.networkStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.networkStream.delegate = nil;
        [self.networkStream close];
        self.networkStream = nil;
        //self.listData = nil;
    }
    [self.fileBytes release];
    [self.therapistName release];
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
// An NSStream delegate callback that's called when events happen on our
// network stream.
{
#pragma unused(aStream)
    assert(aStream == self.networkStream);
    
    switch (eventCode) {
        case NSStreamEventOpenCompleted: {
            //[self updateStatus:@"Opened connection"];
            NSLog(@"Opened connection");
        } break;
        case NSStreamEventHasBytesAvailable: {
            assert(NO);     // should never happen for the output stream
        } break;
        case NSStreamEventHasSpaceAvailable: {
            NSLog(@"Sending");
            //[self updateStatus:@"Sending"];
            
            // If we don't have any data buffered, go read the next chunk of data.
            
            /*if (self.bufferOffset == self.bufferLimit) {
                NSInteger   bytesRead;
                
                bytesRead = [self.fileStream read:self.buffer maxLength:kSendBufferSize];
                
                if (bytesRead == -1) {
                    [self stopSendWithStatus:@"File read error"];
                } else if (bytesRead == 0) {
                    [self stopSendWithStatus:nil];
                } else {
                    self.bufferOffset = 0;
                    self.bufferLimit  = bytesRead;
                }
            }*/
            
            // If we're not out of data completely, send the next chunk.
            
            if (self.fileBytesOffset != self.fileBytes.length) {
                NSInteger   bytesWritten;
                bytesWritten = [self.networkStream write:&self.fileBytes.bytes[self.fileBytesOffset] maxLength:self.fileBytes.length - self.fileBytesOffset];
                //assert(bytesWritten != 0);
                if (bytesWritten == -1) {
                    NSLog(@"Network write error");
                    //[self stopSendWithStatus:@"Network write error"];
                } else {
                    self.fileBytesOffset += bytesWritten;
                }
            }
        } break;
        case NSStreamEventErrorOccurred: {
            NSLog(@"Stream Open Error");
            //[self stopSendWithStatus:@"Stream open error"];
        } break;
        case NSStreamEventEndEncountered: {
            // ignore
        } break;
        default: {
            assert(NO);
        } break;
    }
}

@end
