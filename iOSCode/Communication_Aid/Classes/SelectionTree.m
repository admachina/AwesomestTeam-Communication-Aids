//
//  SelectionTree.m
//  Communication_Aid
//
//  Created by admachin on 7/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectionTree.h"


@implementation SelectionTree
    
-(SelectionTree *)init
{
    self = [super init];
    
    _branches = [[NSMutableArray alloc] init];
    
    _printValue = @"";
    _displayValue = @"";
    
    isRoot = false;
    isUpOneLevel = false;
    
    return self;
}

-(SelectionTree *)init :(NSString *)displayValue
{
    self = [super init];
    
    _branches = [[NSMutableArray alloc] init];
    
    _printValue = @"";
    _displayValue = displayValue;
    
    isRoot = false;
    isUpOneLevel = false;
    
    return self;
}

-(SelectionTree *)init :(NSString *)displayValue :(NSString *)printValue
{
    self = [super init];
    
    _branches = [[NSMutableArray alloc] init];
    
    _printValue = printValue;
    _displayValue = displayValue;
    
    isRoot = false;
    isUpOneLevel = false;
    
    return self;
}

-(SelectionTree*)next :(int)branch
{
    if(branch < [_branches count])
    {
        return [_branches objectAtIndex:branch];
    }
    
    return NULL;
}

-(NSString*)displayValue
{
    return _displayValue;
}

-(NSString*)printValue
{
    return _printValue;
}

-(Boolean)isLeaf
{
    return [_branches count] == 0;
}

-(Boolean)isRoot
{
    return isRoot;
}

-(Boolean)isUpOneLevel
{
    return isUpOneLevel;
}

-(int)branchCount
{
    return [_branches count];
}

-(SelectionTree*)addNode:(SelectionTree *)addedTree
{
    [_branches addObject:(addedTree)];
    return addedTree;
}

-(void)setRoot:(Boolean)rootState
{
    isRoot = rootState;
}

-(void)setUpOneLevel:(Boolean)upOneLevelState
{
    isUpOneLevel = upOneLevelState;
}

@end
