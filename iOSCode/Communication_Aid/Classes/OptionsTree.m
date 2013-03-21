//
//  OptionsTree.m
//  Communication_Aid
//
//  Created by Alex on 13-03-15.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "OptionsTree.h"
#import "SelectionTree.h"
#import "DictionaryParser.h"

@implementation OptionsTree

-(OptionsTree*) init : (int) dimensions {

    
    optionsTreeFile = @"defaultOptions.txt";
    
    
    [self createOptionsTree : dimensions];
    

    
    return self;
    
}


-(void) createOptionsTree : (int) dimensions{
    
    //TODO: create options tree using editor??
    
    //options in text file for easy creation
    DictionaryParser* parser = [[DictionaryParser alloc] initWithName: @"Options" :dimensions];
    SelectionTree* basicTree = [parser parse:optionsTreeFile:@"Options"];
    
    optionsTree = basicTree;
    
    return;
}

-(SelectionTree*) addOptionsTreeToSelectionTree:(SelectionTree *)baseTree {
    
    int nodesInTopLevel = [ baseTree branchCount];
    
    //TODO: assumes that all the trees will be of size 4 or <4 at the very top level...
    //might not be good enough, should check if any are More... but no easy way to do that.
    if( nodesInTopLevel == [baseTree maxBranchCount] ) {
        
        //add a more... and then put options in lower level
        SelectionTree* bump = [baseTree next: [baseTree maxBranchCount]];
        [baseTree removeNode];  //get rid of one node, replace with more..
        
        SelectionTree* nextLevel = [[SelectionTree alloc] init: @"More"];
        [nextLevel setRoot:TRUE];
        [nextLevel addNode:bump];
        [nextLevel addNode:optionsTree];
        SelectionTree* goUp = [[SelectionTree alloc] init : @"Go Back"];
        [goUp setUpOneLevel:true];
        [nextLevel addNode: goUp];
        
        [baseTree addNode: nextLevel];
        
    } else {
        //just add the options at top level
        [baseTree addNode:optionsTree];
        
    }
    
    return baseTree;
}

@end
