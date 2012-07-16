//
//  DictionaryParser.h
//  Communication_Aid
//
//  Created by acellswo on 7/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SelectionTree.h" 


@interface DictionaryParser : NSObject {
    NSString* DEFAULT_DICTIONARY;
    NSString* DEFAULT_CONFIG;
    NSString* NODES_KEY;
    
    SelectionTree* DOWN_NODE;
    
    int nodesPerLevel;
    
    NSData* configFileData;
    
}

-(DictionaryParser*) initWithName : (NSString*) configFileName;
-(DictionaryParser*) init ;

-(void) loadConfig;

-(SelectionTree*) parse : (NSString*) dictionaryFileName;



@end
