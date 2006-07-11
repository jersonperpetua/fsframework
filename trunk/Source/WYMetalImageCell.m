//
//  WYMetalImageCell.m
//  Senuti
//
//  Created by Whitney Young on 1/10/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "WYMetalImageCell.h"


@implementation WYMetalImageCell

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
	[[NSColor colorWithCalibratedRed:0.875 green:0.875 blue:0.875 alpha:1] set];
	[[NSBezierPath bezierPathWithRect:NSMakeRect(cellFrame.origin.x+1, cellFrame.origin.y, cellFrame.size.width-2, 1)] fill];
	[[NSBezierPath bezierPathWithRect:NSMakeRect(cellFrame.origin.x, cellFrame.origin.y+1, 1, cellFrame.size.height-2)] fill];
	[[NSBezierPath bezierPathWithRect:NSMakeRect(cellFrame.origin.x+cellFrame.size.width-1, cellFrame.origin.y+1, 1, cellFrame.size.height-2)] fill];

	[[NSColor colorWithCalibratedRed:0.574 green:0.574 blue:0.574 alpha:1] set];
	[[NSBezierPath bezierPathWithRect:NSMakeRect(cellFrame.origin.x+1, cellFrame.origin.y+cellFrame.size.height-1, cellFrame.size.width-2, 1)] fill];

	[[NSColor colorWithCalibratedRed:0.398 green:0.398 blue:0.398 alpha:1] set];
	[[NSBezierPath bezierPathWithRect:NSMakeRect(cellFrame.origin.x+1, cellFrame.origin.y+1, cellFrame.size.width-2, cellFrame.size.height-2)] fill];

	[[NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1] set];
	[[NSBezierPath bezierPathWithRect:NSMakeRect(cellFrame.origin.x+2, cellFrame.origin.y+2, cellFrame.size.width-4, cellFrame.size.height-4)] fill];

	[super drawWithFrame:NSMakeRect(cellFrame.origin.x+2, cellFrame.origin.y+2, cellFrame.size.width-4, cellFrame.size.height-4) inView:controlView];
}

@end
