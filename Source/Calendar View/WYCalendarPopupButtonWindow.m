//
//  WYCalendarPopupButtonWindow.m
//  Temp
//
//  Created by Whitney Young on 8/20/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "WYCalendarPopupButtonWindow.h"
#import "WYCalendarView.h"


@interface WYCalendarPopupButtonWindow (PRIVATE)
- (void)calendarClick:(id)sender;
- (void)checkEvent:(NSEvent *)event;
@end

@implementation WYCalendarPopupButtonWindow

- (id)init {
	if (self = [super init]) {
	
		[super initWithContentRect:NSMakeRect(0,0,200,160) styleMask:NSTexturedBackgroundWindowMask | NSTitledWindowMask backing:NSBackingStoreBuffered defer:YES];
		[self setBackgroundColor:[NSColor whiteColor]];
		[self setAlphaValue:.90];
		calendar = [[WYCalendarView alloc] initWithFrame:NSMakeRect(0,0,200,160)];
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
