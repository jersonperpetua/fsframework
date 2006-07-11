/*
Copyright (C) 2004-2005  Whitney Young

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

/* WYMetalTableHeaderCell */

#import "WYMetalTableHeaderCell.h"


@implementation WYMetalTableHeaderCell

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
	[super drawWithFrame:cellFrame inView:controlView];
	[[NSColor colorWithCalibratedRed:0.398 green:0.398 blue:0.398 alpha:1] set];
	[NSBezierPath fillRect:NSMakeRect(cellFrame.origin.x, cellFrame.origin.y + cellFrame.size.height - 1, cellFrame.size.width, 1)];
	[NSBezierPath fillRect:NSMakeRect(cellFrame.origin.x, cellFrame.origin.y, cellFrame.size.width, 1)];
}

@end
