//
//  TreeNavigator.m
//  Communication_Aid
//
//  Created by admachin on 7/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TreeNavigator.h"


@implementation TreeNavigator

-(TreeNavigator*) init:(SelectionTree *)tree
{
    self = [super init];
    
    treeRoot = tree;
    currentLocation = tree;
    
    rootStack = [[NSMutableArray alloc] init];
    
    return self;
}

-(NSString*) choose:(int)choice :(NSMutableArray *)valuesToDisplay
{
    if([valuesToDisplay count] > 0)
    {
        [valuesToDisplay removeAllObjects];
        printf("TreeNavigator.choose passed non-empty array");
    }
    
    SelectionTree* nextNode = [currentLocation next:(choice)];
    
    // Invalid Choice (Can be for empty button press, not a code failure)
    if(nextNode == NULL)
    {
        return NULL;
    }
       
    // Add to root stack
    if([currentLocation isRoot])
    {
        [rootStack addObject:(currentLocation)];
    }
    
    currentLocation = nextNode;
    
    NSString* printVal = [currentLocation printValue];
    
    // If needs to skip closest root level (advance backwards in menus)
    if([currentLocation isUpOneLevel])
    {
        [rootStack removeLastObject];
        currentLocation = [rootStack lastObject];
        [rootStack removeLastObject];
    }
    //If needs to return to closest root level
    else if([currentLocation isLeaf])
    {
        currentLocation = [rootStack lastObject];
        [rootStack removeLastObject];
    }
    
    for (int i = 0; i < [currentLocation branchCount]; i++) {
        [valuesToDisplay addObject:([[currentLocation next:(i)] displayValue])];
    }
    
    return printVal;
}

@end
