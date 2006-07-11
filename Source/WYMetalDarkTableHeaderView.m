//
//  WYMetalDarkTableHeaderView.m
//  WYAppFramework
//
//  Created by Whitney Young on 8/23/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "WYMetalDarkTableHeaderView.h"


@implementation WYMetalDarkTableHeaderView

- (void)drawRect:(NSRect)rect {
	int counter;
	for (counter = 0; counter < rect.size.height; counter++) {
		float val = .910 - (.367) * (float)counter / rect.size.height;
		[[NSColor colorWithCalibratedRed:val green:val blue:val alpha:1] set];
		[NSBezierPath fillRect:NSMakeRect(rect.origin.x, rect.origin.y + counter, rect.size.width, 1)];
	}
	
	[[NSColor colorWithCalibratedRed:0.4 green:0.4 blue:0.4 alpha:1] set];
	[NSBezierPath fillRect:NSMakeRect(rect.origin.x, rect.origin.y + rect.size.height - 1, rect.size.width, 1)];
	
}

@end
