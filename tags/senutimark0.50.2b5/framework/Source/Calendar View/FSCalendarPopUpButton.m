/* 
 * The FadingRed Shared Framework (FSFramework) is the legal property of its developers, whose names
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

#import "CalendarPopUpButton.h"
#import "CalendarPopupButtonWindow.h"

@interface CalendarPopUpButton (PRIVATE)
- (void)popupWindowSetNewValue:(id)sender;
@end

@implementation CalendarPopUpButton

- (id)initWithFrame:(NSRect)frameRect {
	if (self = [super initWithFrame:frameRect]) {
		[super setTarget:self];
		[super setAction:@selector(click:)];
		window = [[CalendarPopupButtonWindow alloc] init];

		[window setTarget:self];
		[window setAction:@selector(popupWindowSetNewValue:)];
		
		[window setReleasedWhenClosed:NO];
		
		return self;
	} else {
		return nil;
	}
}

- (void)dealloc {
	[window release];
	[super dealloc];
}

- (id)target {
	return target;
}

- (void)setTarget:(id)aTarget {
	if (target != aTarget)
	{
		[target release];
		target = [aTarget retain];
	}
}

- (SEL)action {
	return action;
}

- (void)setAction:(SEL)anAction {
	action = anAction;
}

- (id)objectValue {
	return [window objectValue];
}

- (void)setObjectValue:(id)value {
	[window setObjectValue:value];
}

- (void)click:(id)sender {
	NSPoint point = [self convertPoint:NSMakePoint(0,0) toView:nil];
	NSRect windowFrame = [[self window] frame];
	
	point.x += windowFrame.origin.x;
	point.y += windowFrame.origin.y;
	
	point.y -= [window frame].size.height + [self frame].size.height + 2;
	if (point.y < 0) { 	point.y += [window frame].size.height + [self frame].size.height + 4; }

	[window setFrameOrigin:point];
	[window orderFront:nil];
}

- (void)popupWindowSetNewValue:(id)sender {
//	// doing things this way makes the button unhighlight
//	// correctly when the view is closed by clicking inside
//	// sending the action to the target with [target performAction: with:]
//	// doesn't do it correctly
//	[super setTarget:target];
//	[super setAction:action];
//	[super performClick:nil];
//	[super setAction:@selector(click:)];
//	[super setTarget:self];
	
	[target performSelector:action withObject:self];
}

@end
