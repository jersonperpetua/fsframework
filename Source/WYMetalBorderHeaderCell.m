//
//  WYMetalBorderHeaderCell.m
//  WYAppFramework
//
//  Created by Whitney Young on 8/23/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "WYMetalBorderHeaderCell.h"

@implementation WYMetalBorderHeaderCell

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
	int counter;
	for (counter = 0; counter < cellFrame.size.height; counter++) {
		//		float val = .910 - (.367) * (float)counter / cellFrame.size.height;
		float val = .543 + (.367) * (float)counter / cellFrame.size.height;
		[[NSColor colorWithCalibratedRed:val green:val blue:val alpha:1] set];
		[NSBezierPath fillRect:NSMakeRect(cellFrame.origin.x, cellFrame.origin.y + counter, cellFrame.size.width, 1)];
	}
	
	[[NSColor colorWithCalibratedRed:0.4 green:0.4 blue:0.4 alpha:1] set];
	[NSBezierPath fillRect:NSMakeRect(cellFrame.origin.x, 0, cellFrame.size.width, 1)];
	
	NSDictionary *attr;
	NSMutableParagraphStyle *style;
	NSFont *font;
	float y;
	
	style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	[style setAlignment:[self alignment]];
	
	font = [self font];
	y = (cellFrame.size.height + 2 - [font pointSize]) / 2;
	
	attr = [[NSDictionary alloc] initWithObjectsAndKeys:style, NSParagraphStyleAttributeName, [self font], NSFontAttributeName, NSShadowAttributeName, [NSColor whiteColor], NSStrokeColorAttributeName, [NSColor whiteColor], NSObliquenessAttributeName, [NSNumber numberWithFloat:3], NSStrokeWidthAttributeName, [NSNumber numberWithFloat:3], nil];
	
	[[self stringValue] drawInRect:NSMakeRect(0, y, cellFrame.size.width, [font pointSize]) withAttributes:attr];
	
	[style release];
	[attr release];
}

@end
