//
//  SelectionTree.h
//  Communication_Aid
//
//  Created by admachin on 7/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectionTree : NSObject {
    NSMutableArray* _branches;
    
    
    //TODO:
    int maxBranches; //this is determined by the calibration (ie degrees of motion)
    
    NSString* _printValue;
    NSString* _displayValue;
    
    Boolean isRoot;
    Boolean isUpOneLevel;
}

//Constructors
-(SelectionTree*) init;
-(SelectionTree*) init: (NSString*) displayValue;
-(SelectionTree*) init: (NSString*) displayValue: (NSString*) printValue;

// Accessors
-(SelectionTree*) next: (int) branch;

-(NSString*) displayValue;
-(NSString*) printValue;
-(Boolean) isLeaf;
-(Boolean) isRoot;
-(Boolean) isUpOneLevel; //Used to pass a root on the stack (advance backwards through menus)
-(int) branchCount;
-(int) maxBranchCount;

//Mutators
-(SelectionTree*) addNode: (SelectionTree*) addedTree;
-(void) setRoot: (Boolean) rootState;
-(void) setUpOneLevel: (Boolean) upOneLevelState;

//removes the most recently inserted node from tree
-(void) removeNode;

@end
