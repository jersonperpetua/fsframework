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

#import "FSScrollView.h"

@interface FSScrollView (PRIVATE)

- (void)frameChange:(NSNotification *)notification;

@end

@implementation FSScrollView

- (void)setAutoHidesVerticalScroller:(BOOL)flag {
	vert = flag;
}

- (void)setAutoHidesHorizontalScroller:(BOOL)flag {
	horiz = flag;
}

- (void)setDocumentView:(NSView *)view {
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSViewFrameDidChangeNotification object:[super documentView]];
	[super setDocumentView:view];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(frameChange:) name:NSViewFrameDidChangeNotification object:view];
	
}

- (void)frameChange:(NSNotification *)notification {
	if (horiz) {
		if ([[self documentView] frame].size.width > [self frame].size.width) {
			[self setHasHorizontalScroller:TRUE];
		} else {
			[self setHasHorizontalScroller:FALSE];
		}
	}
	if (vert) {
		if ([[self documentView] frame].size.height > [self frame].size.height) {
			[self setHasVerticalScroller:TRUE];
		} else {
			[self setHasVerticalScroller:FALSE];
		}
	}
}

@end
