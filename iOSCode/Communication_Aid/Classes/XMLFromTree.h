//
//  XMLFromTree.h
//  Communication_Aid
//
//  Created by acellswo on 8/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SelectionTree.h"

@interface XMLFromTree : NSObject {
    
}

+(Boolean) createXMLFromMenu : (SelectionTree*) mainMenu;

+(NSString*) createXMLFromTree : (SelectionTree*) tree: (NSString*) fileName;

@end
