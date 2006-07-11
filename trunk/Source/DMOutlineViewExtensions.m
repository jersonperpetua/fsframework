//
//  DMTableExtensions.m
//  WYAppFramework
//
//  Created by Whitney Young on 6/27/06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import "DMOutlineViewExtensions.h"

@interface NSOutlineView (DMExtensions_Private)
- (NSTreeController *)_treeControllerForColumn:(NSTableColumn *)column;
- (id)_realItemForOpaqueItem:(id)findOpaqueItem outlineRowIndex:(int *)outlineRowIndex
                       items:(NSArray *)items forColumn:(NSTableColumn *)column;
@end


@implementation NSOutlineView (DMExtensions)

- (id)realItemForOpaqueItem:(id)opaqueItem inColumn:(NSTableColumn *)column
{
    if (column == nil) { column = [[self tableColumns] objectAtIndex:0]; }
    int outlineRowIndex = 0;
    return [self _realItemForOpaqueItem:opaqueItem outlineRowIndex:&outlineRowIndex
                                  items:[[self _treeControllerForColumn:column] content]
                              forColumn:column];
}

- (NSTreeController *)_treeControllerForColumn:(NSTableColumn *)column;
{
    NSLog([(NSTreeController *)[[column infoForBinding:@"value"]
      objectForKey:@"NSObservedObject"] description]);
    return (NSTreeController *)[[column infoForBinding:@"value"]
      objectForKey:@"NSObservedObject"];
}

- (id)_realItemForOpaqueItem:(id)findOpaqueItem outlineRowIndex:(int *)outlineRowIndex
                       items:(NSArray *)items forColumn:(NSTableColumn *)column;
{
    NSLog(@"here");
    unsigned int itemIndex;
    for (itemIndex = 0; itemIndex < [items count] && *outlineRowIndex < [self numberOfRows];
         itemIndex++, (*outlineRowIndex)++) {
        id realItem = [items objectAtIndex:itemIndex];
        id opaqueItem = [self itemAtRow:*outlineRowIndex];
        if (opaqueItem == findOpaqueItem)
            return realItem;
        if ([self isItemExpanded:opaqueItem]) {
            realItem = [self _realItemForOpaqueItem:findOpaqueItem outlineRowIndex:outlineRowIndex
                                              items:[realItem valueForKeyPath:[[self _treeControllerForColumn:column] childrenKeyPath]]
                                          forColumn:column];
            if (realItem)
                return realItem;
        }
    }
    
    NSLog(@"nil");
    return nil;
}

@end