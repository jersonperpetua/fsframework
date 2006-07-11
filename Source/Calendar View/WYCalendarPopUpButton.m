//
//  WYCalendarPopUpButton.m
//  Cashbox
//
//  Created by Whitney Young on 3/30/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "WYCalendarPopUpButton.h"
#import "WYCalendarPopupButtonWindow.h"

@interface WYCalendarPopUpButton (PRIVATE)
- (void)popupWindowSetNewValue:(id)sender;
@end

@implementation WYCalendarPopUpButton

- (id)initWithFrame:(NSRect)frameRect {
	if (self = [super initWithFrame:frameRect]) {
		[super setTarget:self];
		[super setAction:@selector(click:)];
		window = [[WYCalendarPopupButtonWindow alloc] init];

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
