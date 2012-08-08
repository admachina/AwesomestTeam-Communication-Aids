//  OpenEars _version 1.1_
//  http://www.politepix.com/openears
//
//  GraphemeGenerator.h
//  OpenEars
// 
//  GraphemeGenerator is a class which creates pronunciations for words which aren't in the dictionary
//
//  Copyright Politepix UG (haftungsbeschränkt) 2012. All rights reserved.
//  http://www.politepix.com
//  Contact at http://www.politepix.com/contact
//
//  This file is licensed under the Politepix Shared Source license found in the root of the source distribution.

#import "AudioConstants.h"

@interface GraphemeGenerator : NSObject {
}
- (NSString *) convertGraphemes:(NSString *)phrase;
@end
