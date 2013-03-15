//
//  XMLTreeCreator.m
//  Communication_Aid
//
//  Created by admachin on 8/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "XMLTreeCreator.h"
#import "SelectionTree.h"
#import "SMXMLDocument.h"

@implementation XMLTreeCreator

+(SelectionTree*) createTree : (NSString*) xmlFileNameInDocuments
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* filePath = [documentsDirectory stringByAppendingPathComponent:xmlFileNameInDocuments];
    NSData* fileData = [[[NSData alloc] initWithContentsOfFile:filePath] autorelease];
    
    NSError *error = nil;
    SMXMLDocument *document = [SMXMLDocument documentWithData:fileData error:&error];
    
    if ( error )
    {
        NSLog(@"Error while parsing the document: %@", error);
        return NULL;
    }
    
    SMXMLElement *rootNode = document.root;
    return [XMLTreeCreator processTreeElement : rootNode];
}

+(SelectionTree*) processTreeElement : (SMXMLElement*) rootNode
{
    for (SMXMLElement *fileName in [rootNode childrenNamed:@"Filename"]) {
        return [XMLTreeCreator createTree:[fileName value]];
    }
    
    NSString* displayValue = [rootNode valueWithPath:@"DisplayValue"];
    if(displayValue == Nil) displayValue = @"";
    
    NSString* printValue = [rootNode valueWithPath:@"PrintValue"];
    if(printValue == Nil) printValue = @"";
    
    SelectionTree* tree = [[SelectionTree alloc] init : displayValue : printValue];
    
    Boolean isRoot = [[rootNode valueWithPath:@"IsRoot"] boolValue];
    Boolean isGoUp = [[rootNode valueWithPath:@"IsGoUp"] boolValue];
    
    [tree setRoot:isRoot];
    [tree setUpOneLevel:isGoUp];
    
    for (SMXMLElement *child in [[rootNode childNamed:@"Children"] childrenNamed:@"Tree"])
    {
        [tree addNode:[XMLTreeCreator processTreeElement : child] ];
    }
    
    return tree;
}

@end
