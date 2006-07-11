//
//  WYScrollView.h
//  WYAppFramework
//
//  Created by Whitney Young on 8/23/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface WYScrollView : NSScrollView {
	bool horiz;
	bool vert;
}

// this is a quick fix with little functionality

// after setting these to false (after they were once true),
// you may have to explicitly specify whether you want the scroll
// bar to be visible or not

- (void)setAutoHidesVerticalScroller:(BOOL)flag;
- (void)setAutoHidesHorizontalScroller:(BOOL)flag;

@end
