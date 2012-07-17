//
//  TreeNavigator.h
//  Communication_Aid
//
//  Created by admachin on 7/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SelectionTree.h"


@interface TreeNavigator : NSObject {
    SelectionTree* treeRoot;
    SelectionTree* currentLocation;
    
    NSMutableArray* rootStack;
}

-(TreeNavigator*) initWithTree : (SelectionTree*) tree;

// "choose" takes integer choice and empty array for values to be displayed next on menu, returns value added to text stream or NULL if an invalid choice was provided (empty button)
-(NSString*) choose : (int) choice : (NSMutableArray*) valuesToDisplay;
-(SelectionTree*) currentTree;


@end
