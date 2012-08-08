//
//  XMLTreeCreator.h
//  Communication_Aid
//
//  Created by admachin on 8/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SelectionTree.h"
#import "SMXMLDocument.h"

@interface XMLTreeCreator : NSObject {
    
}

+(SelectionTree*) createTree : (NSString*) xmlFileNameInDocuments;
+(SelectionTree*) processTreeElement : (SMXMLElement*) rootNode;

@end
