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
    
    NSString* _printValue;
    NSString* _displayValue;
}

//Constructors
-(SelectionTree*) init;
-(SelectionTree*) init: (NSString*) displayValue;
-(SelectionTree*) init: (NSString*) displayValue: (NSString*) printValue;

-(SelectionTree*) clone;

// Accessors
-(SelectionTree*) next: (int) branch;

-(NSString*) displayValue;
-(NSString*) printValue;
-(Boolean) isLeaf;

//Mutators
-(void) addNode: (SelectionTree*) addedTree: (int) location;
-(SelectionTree*) addNode: (SelectionTree*) addedTree;

@end
