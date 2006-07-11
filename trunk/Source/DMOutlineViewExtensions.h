//
//  DMTableExtensions.h
//  WYAppFramework
//
//  Created by Whitney Young on 6/27/06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSOutlineView (DMExtensions)

- (id)realItemForOpaqueItem:(id)opaqueItem inColumn:(NSTableColumn *)column;

@end