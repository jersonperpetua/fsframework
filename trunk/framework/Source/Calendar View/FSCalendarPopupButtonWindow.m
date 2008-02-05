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

#import "CalendarPopupButtonWindow.h"
#import "CalendarView.h"

@interface CalendarPopupButtonWindow (PRIVATE)
- (void)calendarClick:(id)sender;
- (void)checkEvent:(NSEvent *)event;
@end

@implementation CalendarPopupButtonWindow

- (id)init {
	if (self = [super init]) {
	
		[super initWithContentRect:NSMakeRect(0,0,200,160) styleMask:NSTexturedBackgroundWindowMask | NSTitledWindowMask backing:NSBackingStoreBuffered defer:YES];
		[self setBackgroundColor:[NSColor whiteColor]];
		[self setAlphaValue:.90];
		calendar = [[CalendarView alloc] initWithFrame:NSMakeRect(0,0,200,160)];
		[calendar setTarget:self];
		[calendar setAction:@selector(calendarClick:)];
		[calendar setEnabled:YES];
		[calendar setObjectValue:[NSCalendarDate date]];
		[self setContentView:calendar];
		[calendar release];
	
		return self;

	} else {
		return nil;
	}
}

- (BOOL)canBecomeKeyWindow {
	return NO;
}

- (BOOL)canBecomeMainWindow {
	return NO;
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
	return [calendar objectValue];
}

- (void)setObjectValue:(id)value {
	[calendar setObjectValue:value];
}

- (void)calendarClick:(id)sender {
	[target performSelector:action withObject:self];
#warning should have the calendar close when a numbered day is clicked
	//[self close];
}

- (void)orderFront:(id)sender {
	[super makeKeyAndOrderFront:sender];
	NSEvent *event = [self nextEventMatchingMask:NSAnyEventMask];
	[self checkEvent:event];
}

// close this when clicking outside of it
- (void)checkEvent:(NSEvent *)event {
	NSEventType type = [event type];
	if ((type == NSLeftMouseDown || type == NSRightMouseDown) && [event window] != self) {
		[self close];
		[NSApp sendEvent:event];
	} else {
		[NSApp sendEvent:event];
		NSEvent *event = [self nextEventMatchingMask:NSAnyEventMask];
		[self checkEvent:event];
	}
}

@end
