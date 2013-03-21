//
//  OptionsTree.h
//  Communication_Aid
//
//  Created by Victoria Lee on 13-03-15.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SelectionTree.h"

@interface OptionsTree : NSObject {
    SelectionTree* optionsTree;
    NSString* optionsTreeFile;
}



//creates the options tree and returns
-(OptionsTree*) init : (int) dimensions;

-(void) createOptionsTree :(int) dimensions;

//returns the selection treer] "baseTree" with the options added to its top level
-(SelectionTree*) addOptionsTreeToSelectionTree : (SelectionTree*) baseTree;

@end
