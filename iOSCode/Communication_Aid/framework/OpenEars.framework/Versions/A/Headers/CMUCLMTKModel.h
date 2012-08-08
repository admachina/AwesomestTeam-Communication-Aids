//
//  CMUCLMTKModel.h
//  OpenEars _version 1.1_
//  http://www.politepix.com/openears
//
//  CMUCLMTKModel is a class which abstracts the conversion of vocabulary into language models
//  OpenEars
//
//  Copyright Politepix UG (haftungsbeschränkt) 2012. All rights reserved.
//  http://www.politepix.com
//  Contact at http://www.politepix.com/contact
//
//  This file is licensed under the Politepix Shared Source license found in the root of the source distribution.

@interface CMUCLMTKModel : NSObject {
    NSString *pathToDocumentsDirectory;
    int verbosity;
    NSString *algorithmType;
}

- (void) runCMUCLMTKOnCorpusFile:(NSString *)fileName;


@property (nonatomic, copy) NSString *pathToDocumentsDirectory;
@property (nonatomic, assign) int verbosity;
@property (nonatomic, copy) NSString *algorithmType;
@end
