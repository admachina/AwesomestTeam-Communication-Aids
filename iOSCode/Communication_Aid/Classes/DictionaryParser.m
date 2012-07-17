//
//  DictionaryParser.m
//  Communication_Aid
//
//  Created by acellswo on 7/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DictionaryParser.h"


@implementation DictionaryParser

-(DictionaryParser*) initWithName:(NSString *)configFileName {
    self = [super init];
    
    //TODO: find a configFile within the user's documents on the ipad rather than from package
    
    configFileData = [NSData dataWithContentsOfFile:DEFAULT_CONFIG];
                       
    [self loadConfig];
    
    return self;
}

-(DictionaryParser*) init {
    DEFAULT_CONFIG = @"parserConfig.properties";
    return [self initWithName:DEFAULT_CONFIG];
}

-(void) loadConfig {
    NSError ** error;
    NSData* plistData = [NSPropertyListSerialization dataWithPropertyList:configFileData format:NSPropertyListOpenStepFormat options:NSPropertyListImmutable error:error];
    
    printf("printing the plist");
    printf(plistData);
    
    //TODO: fix static declaration of config
    nodesPerLevel = 4;
    
}

-(SelectionTree*) parse:(NSString *)dictionaryFileName {
    
    NSString* displayVal;
    NSString* printVal;
    SelectionTree* treeHead = [[SelectionTree alloc] init];
    
    NSError ** error;
    NSString* dictionaryData = [NSString stringWithContentsOfFile:dictionaryFileName encoding:NSStringEncodingConversionAllowLossy error:error];
    
    
    NSScanner* parser = [NSScanner scannerWithString:dictionaryData];
    
    NSCharacterSet* chars = [NSCharacterSet characterSetWithCharactersInString:@",\\n"];
    //[parser setCharactersToBeSkipped:chars]; 
    
    SelectionTree* currentNode = treeHead;
    
    while(true) {
        
        for( int i = 1; ( i< nodesPerLevel); i++) {
            
            
            if( [parser isAtEnd] ) {
                break; 
            }
            
            NSString* displayVal = [NSString alloc];
            NSString* printVal = [NSString alloc];
            
            [parser scanUpToCharactersFromSet:chars intoString:&displayVal];
            [parser scanUpToCharactersFromSet:chars intoString:&printVal];
            
            SelectionTree *newNode = [[SelectionTree alloc]  init:displayVal :printVal];
            
            
            [currentNode addNode:newNode]; 
            
        }
        currentNode = [currentNode addNode:DOWN_NODE];
    }
    
    return treeHead;
    
}

@end
