/* 
 * The Fadingred.org Shared Framework (FSFramework) is the legal property of its developers, whose names
 * are listed in the copyright file included with this source distribution.
 * 
 * This program is free software; you can redistribute it and/or modify it under the terms of the GNU
 * General Public License as published by the Free Software Foundation; either version 2 of the License,
 * or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even
 * the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
 * Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along with this program; if not,
 * write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

#import "FSMetalImageCell.h"

@implementation FSMetalImageCell

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
