//
//  WYCalendarPopupButtonWindow.h
//  Temp
//
//  Created by Whitney Young on 8/20/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WYCalendarView;
@interface WYCalendarPopupButtonWindow : NSWindow {
	WYCalendarView *calendar;
	NSButton *done;
	
	id target;
	SEL action;

	id objectValue;
}

- (id)target;
- (void)setTarget:(id)aTarget;

- (SEL)action;
- (void)setAction:(SEL)anAction;

- (id)objectValue;
- (void)setObjectValue:(id)value;

@end
