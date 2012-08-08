//  OpenEars _version 1.1_
//  http://www.politepix.com/openears
//
//  OpenEarsErrorDictionary.h
// 
//  OpenEarsErrorDictionary is a class which defines OpenEars-specific NSErrors
//
//  Copyright Politepix UG (haftungsbeschränkt) 2012. All rights reserved.
//  http://www.politepix.com
//  Contact at http://www.politepix.com/contact
//
//  This file is licensed under the Politepix Shared Source license found in the root of the source distribution.

#define kOpenEarsErrorDomain @"OpenEarsErrorDomain"

#define kOpenEarsErrorLanguageModelHasNoContentCode 100
#define kOpenEarsErrorLanguageModelHasNoContentMessage @"Requested language model has no content"
#define kOpenEarsErrorLanguageModelHasNoContent [NSError errorWithDomain:kOpenEarsErrorDomain code:kOpenEarsErrorLanguageModelHasNoContentCode userInfo:[NSDictionary dictionaryWithObject:kOpenEarsErrorLanguageModelHasNoContentMessage forKey:NSLocalizedDescriptionKey]];
