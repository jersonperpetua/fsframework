//
//  WYCalendarPopUpButton.h
//  Cashbox
//
//  Created by Whitney Young on 3/30/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WYCalendarPopupButtonWindow;
@interface WYCalendarPopUpButton : NSButton {
	WYCalendarPopupButtonWindow *window;
	id target;
	SEL action;
}

@end