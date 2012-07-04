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
    
    return self;
}

-(SelectionTree *)init :(NSString *)displayValue
{
    self = [super init];
    
    _branches = [[NSMutableArray alloc] init];
    
    _printValue = @"";
    _displayValue = displayValue;
    
    return self;
}

-(SelectionTree *)init :(NSString *)displayValue :(NSString *)printValue
{
    self = [super init];
    
    _branches = [[NSMutableArray alloc] init];
    
    _printValue = printValue;
    _displayValue = displayValue;
    
    return self;
}

/*-(SelectionTree*)clone
{
    SelectionTree* copy = [[SelectionTree alloc] init];
    
    copy.
}*/

-(SelectionTree*)next :(int)branch
{
    return [_branches objectAtIndex:branch];
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

-(void)addNode:(SelectionTree *)addedTree
{
    [_branches addObject:(addedTree)];
}

-(void)addNode:(SelectionTree *)addedTree :(int)location
{
    [_branches insertObject:(addedTree) atIndex:(location)];
}
@end
