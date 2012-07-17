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
    
    printf("printing the plist\n");
    //printf(plistData);
    
    //TODO: fix static declaration of config
    nodesPerLevel = 4;
    
}

-(SelectionTree*) parse:(NSString *)dictionaryFileName {

    SelectionTree* treeHead = [[SelectionTree alloc] init];
    [treeHead setRoot:true];
    
    NSString* displayVal = [[NSString alloc] init];
    NSString* printVal = [[NSString alloc] init];
    
    NSError ** error;
    NSString *file = [[NSBundle mainBundle] pathForResource:dictionaryFileName ofType:@""];
    NSString* dictionaryData = [NSString stringWithContentsOfFile:file encoding:NSASCIIStringEncoding error:error];
    
    NSCharacterSet* chars = [NSCharacterSet characterSetWithCharactersInString:@",\n"]; 
    NSScanner* parser = [NSScanner scannerWithString:dictionaryData];
    [parser setCharactersToBeSkipped:chars];
    
    
    
    SelectionTree* currentNode = treeHead;
    
    while(true) {
        
        for( int i = 1; ( i< nodesPerLevel); i++) {
            
            
            if( [parser isAtEnd] ) {
                goto exiting; 
            }
            

            
            [parser scanUpToCharactersFromSet:chars intoString:&displayVal];
            //[parser scanCharactersFromSet:chars intoString:&printVal];
            [parser scanUpToCharactersFromSet:chars intoString:&printVal];
            
            SelectionTree *newNode = [[SelectionTree alloc]  init:displayVal :printVal];
            
            
            [currentNode addNode:newNode]; 
            
        }
        currentNode = [currentNode addNode:[DictionaryParser downNode]];
    }
exiting:
    return treeHead;
    
}

+(SelectionTree*) downNode {
    
    SelectionTree *toReturn = [[SelectionTree alloc] init:@"More" :@""];
    
    return toReturn;
}


@end
