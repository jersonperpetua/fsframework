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

#import "FSMetalDarkTableHeaderView.h"

@implementation FSMetalDarkTableHeaderView

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
