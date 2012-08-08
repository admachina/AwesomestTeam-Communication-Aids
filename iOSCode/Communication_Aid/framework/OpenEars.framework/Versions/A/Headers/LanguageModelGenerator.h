//  OpenEars _version 1.1_
//  http://www.politepix.com/openears
//
//  LanguageModelGenerator.h
//  OpenEars
//
//  LanguageModelGenerator is a class which creates new grammars
//
//  Copyright Politepix UG (haftungsbeschränkt) 2012. All rights reserved.
//  http://www.politepix.com
//  Contact at http://www.politepix.com/contact
//
//  This file is licensed under the Politepix Shared Source license found in the root of the source distribution.

@interface LanguageModelGenerator : NSObject {
    BOOL verboseLanguageModelGenerator;

}
@property(nonatomic,assign)    BOOL verboseLanguageModelGenerator;
- (NSError *) generateLanguageModelFromArray:(NSArray *)languageModelArray withFilesNamed:(NSString *)fileName;
@end
