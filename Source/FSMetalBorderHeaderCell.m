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

#import "FSMetalBorderHeaderCell.h"

@implementation FSMetalBorderHeaderCell

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
