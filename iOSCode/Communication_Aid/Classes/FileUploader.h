//
//  FileUploader.h
//  Communication_Aid
//
//  Created by Victor Tong on 2013-03-21.
//
//

#import <Foundation/Foundation.h>

@interface FileUploader : NSObject<NSStreamDelegate> {
    NSString* dataToUpload;
    NSInputStream* networkStream;
    NSString* fileNameOnServer;
    NSString* therapistName;
    NSData* fileBytes;
    size_t fileBytesOffset;
}
@property(nonatomic, retain) NSString* dataToUpload;
@property (nonatomic, strong, readwrite) NSInputStream* networkStream;
@property(atomic, retain) NSString* therapistName;
@property(nonatomic, retain) NSData* fileBytes;
@property(nonatomic) size_t fileBytesOffset;

- (id)initWithData:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data:(NSString*)data therapistName:(NSString*)therapistName fileNameOnServer:(NSString*)fileNameOnServer;

- (void) startNetworkStream:(NSString*)url;

- (bool) isDone;

@end
