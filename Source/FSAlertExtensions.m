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

#import "FSAlertExtensions.h"

@interface FSAlertExtensions (PRIVATE)
+ (FSAlertExtensions *)sharedRunAlertWindow;
// do things
- (int)runModal;
- (void)beginSheetForWindow:(NSWindow *)docWindow modalDelegate:(id)modalDelegate didEndSelector:(SEL)didEndSelector didDismissSelector:(SEL)didDismissSelector contextInfo:(void *)contextInfo;
- (void)setupWindowForTitle:(NSString *)title message:(NSString *)msg defaultButton:(NSString *)defaultButton otherButton:(NSString *)otherButton checkboxString:(NSString *)checkboxString checkboxState:(BOOL *)checkboxState detailsString:(NSString *)detailsString detailsButtonTitle:(NSString *)detailsButtonTitle detialsState:(BOOL *)detailsState;
// fix things
- (void)details:(id)sender;
- (void)defaultAction:(id)sender;
- (void)otherAction:(id)sender;
@end

@implementation FSAlertExtensions


static FSAlertExtensions *sharedRunAlertWindow;
+ (FSAlertExtensions *)sharedRunAlertWindow {
	return sharedRunAlertWindow?sharedRunAlertWindow:(sharedRunAlertWindow = [[self alloc] init]);
}

- (id)init {
	self = [super init];

	_window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0,0,420,131) styleMask:NSTitledWindowMask backing:NSBackingStoreBuffered defer:YES];
	[_window setReleasedWhenClosed:NO];
	NSView *content = [_window contentView];
	_title = [[NSTextField alloc] initWithFrame:NSMakeRect(107,99,284,17)];
		[_title setAutoresizingMask:NSViewMinYMargin];
		[_title setEditable:NO];
		[_title setSelectable:NO];
		[_title setBordered:NO];
		[_title setDrawsBackground:NO];
		[_title setFont:[NSFont boldSystemFontOfSize:13]];
		[[_title cell] setWraps:YES];
		[content addSubview:_title];
		[_title release];
	_msg = [[NSTextField alloc] initWithFrame:NSMakeRect(107,62,284,28)];
		[_msg setAutoresizingMask:NSViewMinYMargin];
		[_msg setEditable:NO];
		[_msg setSelectable:NO];
		[_msg setBordered:NO];
		[_msg setDrawsBackground:NO];
		[_msg setFont:[NSFont systemFontOfSize:11]];
		[[_msg cell] setWraps:YES];
		[content addSubview:_msg];
		[_msg release];
	_defaultButton = [[NSButton alloc] initWithFrame:NSMakeRect(316,11,90,34)];
		[_defaultButton setKeyEquivalent:@"\r"];
		[_defaultButton setTarget:self];
		[_defaultButton setAction:@selector(defaultAction:)];
[_defaultButton setBezelStyle:NSRoundedBezelStyle];
		[_defaultButton setFont:[NSFont systemFontOfSize:13]];
		[content addSubview:_defaultButton];
		[_defaultButton release];
	_otherButton = [[NSButton alloc] initWithFrame:NSMakeRect(224,11,90,34)];
		[_otherButton setKeyEquivalent:@"."];
		[_otherButton setKeyEquivalentModifierMask:NSCommandKeyMask];
		[_otherButton setTarget:self];
		[_otherButton setAction:@selector(otherAction:)];
[_otherButton setBezelStyle:NSRoundedBezelStyle];
		[_otherButton setFont:[NSFont systemFontOfSize:13]];
		[content addSubview:_otherButton];
		[_otherButton release];
	_check = [[NSButton alloc] initWithFrame:NSMakeRect(24,20,78,20)];
		[_check setButtonType:NSSwitchButton];
		[[_check cell] setControlSize:NSSmallControlSize];
		[_check setFont:[NSFont systemFontOfSize:11]];
		[content addSubview:_check];
		[_check release];
	NSScrollView *container = [[NSScrollView alloc] initWithFrame:NSMakeRect(107,60,298,60)];
		[container setHasVerticalScroller:YES];
		[container setBorderType:NSBezelBorder];
		[content addSubview:container];
		[container release];
	_detailsText = [[NSTextView alloc] initWithFrame:NSMakeRect(0,0,10,10)];
		[_detailsText setAutoresizingMask:NSViewMinYMargin];
		[_detailsText setEditable:NO];
		[container setDocumentView:_detailsText];
		[_detailsText release];
	_detailsButton = [[NSButton alloc] initWithFrame:NSMakeRect(107,62,13,13)];
		[_detailsButton setAutoresizingMask:NSViewMinYMargin];
		[_detailsButton setTarget:self];
		[_detailsButton setAction:@selector(details:)];
		[_detailsButton setTitle:@""];
		[_detailsButton setButtonType:NSOnOffButton];
		[_detailsButton setBezelStyle:NSDisclosureBezelStyle];
		[content addSubview:_detailsButton];
		[_detailsButton release];
	_detailsButtonText = [[NSButton alloc] initWithFrame:NSMakeRect(119,62,13,13)];
		[_detailsButtonText setAutoresizingMask:NSViewMinYMargin];
		[_detailsButtonText setTarget:self];
		[_detailsButtonText setAction:@selector(details:)];
		[[_detailsButtonText cell] setHighlightsBy:NSCellDisabled];
		[[_detailsButtonText cell] setBordered:NO];
		[_detailsButtonText setFont:[NSFont systemFontOfSize:11]];
		[content addSubview:_detailsButtonText];
		[_detailsButtonText release];
	_image = [[NSImageView alloc] initWithFrame:NSMakeRect(24,51,64,64)];
		[_image setAutoresizingMask:NSViewMinYMargin];
		[_image setImage:[NSApp applicationIconImage]];
		[content addSubview:_image];
		[_image release];

	return self;
}

// we don't really ever get here, but oh well.  might as well write it
- (void)dealloc {
	if (![_otherButton isDescendantOf:[_window contentView]]) { [_otherButton release]; }
	if (![_check isDescendantOf:[_window contentView]]) { [_check release]; }
	if (![_detailsText isDescendantOf:[_window contentView]]) { [[[_detailsText superview] superview] release]; }
	if (![_detailsButton isDescendantOf:[_window contentView]]) { [_detailsButton release]; }
	if (![_detailsButtonText isDescendantOf:[_window contentView]]) { [_detailsButtonText release]; }
	[_window release]; _window = nil;
	[super dealloc];
}

#pragma mark ending alert panels
- (void)defaultAction:(id)sender {
	if (self == sharedRunAlertWindow)
	{
		if (_checkValue) { *_checkValue = [[_check objectValue] boolValue]; }
		if (_detailsState) { *_detailsState = [_detailsButton state]; }
		[NSApp stopModalWithCode:NSAlertDefaultReturn];
		[_window close];
	} else {
		[NSApp endSheet:_window];
		if (_modalDelegate && _didEndSelector)
		{
			int returnCode = NSAlertDefaultReturn;
			BOOL checkboxValue, detailsState;
			NSMethodSignature *sign = [[_modalDelegate class] instanceMethodSignatureForSelector:_didEndSelector];
			NSInvocation *invoke = [NSInvocation invocationWithMethodSignature:sign];
			unsigned num_args = [sign numberOfArguments];
			
			[invoke setTarget:_modalDelegate];
			[invoke setSelector:_didEndSelector];
			[invoke setArgument:&_window atIndex:2];
			[invoke setArgument:&returnCode atIndex:3];
			if (num_args == 5) {
				[invoke setArgument:&_contextInfo atIndex:4];
			} else if (num_args == 6) {
				if (_sendCheckValue) {
					checkboxValue = [[_check objectValue] boolValue];
					[invoke setArgument:&checkboxValue atIndex:4];
				} else {
					detailsState = [[_detailsButton objectValue] boolValue];
					[invoke setArgument:&detailsState atIndex:4];
				}
				[invoke setArgument:&_contextInfo atIndex:5];
			} else if (num_args == 7) {
				checkboxValue = [[_check objectValue] boolValue];
				detailsState = [[_detailsButton objectValue] boolValue];
				[invoke setArgument:&checkboxValue atIndex:4];
				[invoke setArgument:&detailsState atIndex:5];
				[invoke setArgument:&_contextInfo atIndex:6];
			}
			[invoke invoke];
		}
		[_window close];
		if (_modalDelegate && _didDismissSelector)
		{
			int returnCode = NSAlertDefaultReturn;
			BOOL checkboxValue, detailsState;
			NSMethodSignature *sign = [[_modalDelegate class] instanceMethodSignatureForSelector:_didDismissSelector];
			NSInvocation *invoke = [NSInvocation invocationWithMethodSignature:sign];
			unsigned num_args = [sign numberOfArguments];
			
			[invoke setTarget:_modalDelegate];
			[invoke setSelector:_didDismissSelector];
			[invoke setArgument:&_window atIndex:2];
			[invoke setArgument:&returnCode atIndex:3];
			[invoke setArgument:&_contextInfo atIndex:4];
			if (num_args == 5) {
				[invoke setArgument:&_contextInfo atIndex:4];
			} else if (num_args == 6) {
				if (_sendCheckValue) {
					checkboxValue = [[_check objectValue] boolValue];
					[invoke setArgument:&checkboxValue atIndex:4];
				} else {
					detailsState = [[_detailsButton objectValue] boolValue];
					[invoke setArgument:&detailsState atIndex:4];
				}
				[invoke setArgument:&_contextInfo atIndex:5];
			} else if (num_args == 7) {
				checkboxValue = [[_check objectValue] boolValue];
				detailsState = [[_detailsButton objectValue] boolValue];
				[invoke setArgument:&checkboxValue atIndex:4];
				[invoke setArgument:&detailsState atIndex:5];
				[invoke setArgument:&_contextInfo atIndex:6];
			}
			[invoke invoke];
		}
		[self release];
	}
}

- (void)otherAction:(id)sender {
	if (self == sharedRunAlertWindow)
	{
		if (_checkValue) { *_checkValue = [[_check objectValue] boolValue]; }
		if (_detailsState) { *_detailsState = [_detailsButton state]; }
		[NSApp stopModalWithCode:NSAlertOtherReturn];
		[_window close];
	} else {
		[NSApp endSheet:_window];
		if (_modalDelegate && _didEndSelector)
		{
			int returnCode = NSAlertOtherReturn;
			BOOL checkboxValue, detailsState;
			NSMethodSignature *sign = [[_modalDelegate class] instanceMethodSignatureForSelector:_didEndSelector];
			NSInvocation *invoke = [NSInvocation invocationWithMethodSignature:sign];
			unsigned num_args = [sign numberOfArguments];
			
			[invoke setTarget:_modalDelegate];
			[invoke setSelector:_didEndSelector];
			[invoke setArgument:&_window atIndex:2];
			[invoke setArgument:&returnCode atIndex:3];
			[invoke setArgument:&_contextInfo atIndex:4];
			if (num_args == 5) {
				[invoke setArgument:&_contextInfo atIndex:4];
			} else if (num_args == 6) {
				if (_sendCheckValue) {
					checkboxValue = [[_check objectValue] boolValue];
					[invoke setArgument:&checkboxValue atIndex:4];
				} else {
					detailsState = [[_detailsButton objectValue] boolValue];
					[invoke setArgument:&detailsState atIndex:4];
				}
				[invoke setArgument:&_contextInfo atIndex:5];
			} else if (num_args == 7) {
				checkboxValue = [[_check objectValue] boolValue];
				detailsState = [[_detailsButton objectValue] boolValue];
				[invoke setArgument:&checkboxValue atIndex:4];
				[invoke setArgument:&detailsState atIndex:5];
				[invoke setArgument:&_contextInfo atIndex:6];
			}
			[invoke invoke];
		}
		[_window close];
		if (_modalDelegate && _didDismissSelector)
		{
			int returnCode = NSAlertOtherReturn;
			BOOL checkboxValue, detailsState;
			NSMethodSignature *sign = [[_modalDelegate class] instanceMethodSignatureForSelector:_didDismissSelector];
			NSInvocation *invoke = [NSInvocation invocationWithMethodSignature:sign];
			unsigned num_args = [sign numberOfArguments];
			
			[invoke setTarget:_modalDelegate];
			[invoke setSelector:_didDismissSelector];
			[invoke setArgument:&_window atIndex:2];
			[invoke setArgument:&returnCode atIndex:3];
			[invoke setArgument:&_contextInfo atIndex:4];
			if (num_args == 5) {
				[invoke setArgument:&_contextInfo atIndex:4];
			} else if (num_args == 6) {
				if (_sendCheckValue) {
					checkboxValue = [[_check objectValue] boolValue];
					[invoke setArgument:&checkboxValue atIndex:4];
				} else {
					detailsState = [[_detailsButton objectValue] boolValue];
					[invoke setArgument:&detailsState atIndex:4];
				}
				[invoke setArgument:&_contextInfo atIndex:5];
			} else if (num_args == 7) {
				checkboxValue = [[_check objectValue] boolValue];
				detailsState = [[_detailsButton objectValue] boolValue];
				[invoke setArgument:&checkboxValue atIndex:4];
				[invoke setArgument:&detailsState atIndex:5];
				[invoke setArgument:&_contextInfo atIndex:6];
			}
			[invoke invoke];
		}
		[self release];
	}
}

#pragma mark running different alert panels
int RunAlertPanel(NSString *title, NSString *msg, NSString *defaultButton, NSString *otherButton) {
	return RunAlertPanelWithCheckboxAndDetails(title, msg, defaultButton, otherButton, nil, 0, nil, nil, 0);
}
int RunAlertPanelWithCheckbox(NSString *title, NSString *msg, NSString *defaultButton, NSString *otherButton, NSString *checkboxString, BOOL *checkboxState) {	
	return RunAlertPanelWithCheckboxAndDetails(title, msg, defaultButton, otherButton, checkboxString, checkboxState, nil, nil, 0);
}
int RunAlertPanelWithDetails(NSString *title, NSString *msg, NSString *defaultButton, NSString *otherButton, NSString *detailsString, NSString *detailsButtonTitle, BOOL *detailsState) {
	return RunAlertPanelWithCheckboxAndDetails(title, msg, defaultButton, otherButton, nil, 0, detailsString, detailsButtonTitle, detailsState);
}
int RunAlertPanelWithCheckboxAndDetails(NSString *title, NSString *msg, NSString *defaultButton, NSString *otherButton, NSString *checkboxString, BOOL *checkboxState, NSString *detailsString, NSString *detailsButtonTitle, BOOL *detailsState) {
	[[FSAlertExtensions sharedRunAlertWindow] setupWindowForTitle:title message:msg defaultButton:defaultButton otherButton:otherButton checkboxString:checkboxString checkboxState:checkboxState detailsString:detailsString detailsButtonTitle:detailsButtonTitle detialsState:detailsState];
	return [[FSAlertExtensions sharedRunAlertWindow] runModal];
}

#pragma mark running different sheets
void BeginAlertSheet(NSString *title, NSString *defaultButton, NSString *otherButton, NSWindow *docWindow, id modalDelegate, SEL didEndSelector, SEL didDismissSelector, void *contextInfo, NSString *msg) {
	BeginAlertSheetWithCheckboxAndDetails(title, defaultButton, otherButton, docWindow, modalDelegate, didEndSelector, didDismissSelector, contextInfo, msg, nil, -1, nil, nil, -1);
}
void BeginAlertSheetWithCheckbox(NSString *title, NSString *defaultButton, NSString *otherButton, NSWindow *docWindow, id modalDelegate, SEL didEndSelector, SEL didDismissSelector, void *contextInfo, NSString *msg, NSString *checkboxString, BOOL checkboxState) {
	BeginAlertSheetWithCheckboxAndDetails(title, defaultButton, otherButton, docWindow, modalDelegate, didEndSelector, didDismissSelector, contextInfo, msg, checkboxString, checkboxState, nil, nil, -1);
}
void BeginAlertSheetWithDetails(NSString *title, NSString *defaultButton, NSString *otherButton, NSWindow *docWindow, id modalDelegate, SEL didEndSelector, SEL didDismissSelector, void *contextInfo, NSString *msg, NSString *detailsString, NSString *detailsButtonTitle, BOOL detailsState) {
	BeginAlertSheetWithCheckboxAndDetails(title, defaultButton, otherButton, docWindow, modalDelegate, didEndSelector, didDismissSelector, contextInfo, msg, nil, -1, detailsString, detailsButtonTitle, detailsState);
}
void BeginAlertSheetWithCheckboxAndDetails(NSString *title, NSString *defaultButton, NSString *otherButton, NSWindow *docWindow, id modalDelegate, SEL didEndSelector, SEL didDismissSelector, void *contextInfo, NSString *msg, NSString *checkboxString, BOOL checkboxState, NSString *detailsString, NSString *detailsButtonTitle, BOOL detailsState) {
	id run_object = [[FSAlertExtensions alloc] init];
	[run_object setupWindowForTitle:title message:msg defaultButton:defaultButton otherButton:otherButton checkboxString:checkboxString checkboxState:(checkboxState != -1)?&checkboxState:NULL detailsString:detailsString detailsButtonTitle:detailsButtonTitle detialsState:(detailsState != -1)?&detailsState:NULL];
	[run_object beginSheetForWindow:docWindow modalDelegate:modalDelegate didEndSelector:didEndSelector didDismissSelector:didDismissSelector contextInfo:contextInfo];
}

#pragma mark runs
- (int)runModal {
	return [NSApp runModalForWindow:_window];
}

- (void)beginSheetForWindow:(NSWindow *)docWindow modalDelegate:(id)modalDelegate didEndSelector:(SEL)didEndSelector didDismissSelector:(SEL)didDismissSelector contextInfo:(void *)contextInfo {
	_didEndSelector = didEndSelector;
	_didDismissSelector = didDismissSelector;
	_modalDelegate = modalDelegate;
	_contextInfo = contextInfo;
	// specifying the delegate here to retain if needed how it would be if it wasn't being handled here
	[NSApp beginSheet:_window modalForWindow:docWindow modalDelegate:modalDelegate didEndSelector:NULL contextInfo:nil];
}

#pragma mark interface actions within alert

- (void)details:(id)sender {
	if ([_detailsText isDescendantOf:[_window contentView]])
	{
		[_detailsButton setState:FALSE];
		NSRect frame = [_window frame];
		float move = [[[_detailsText superview] superview] frame].size.height + 20;
		frame.size.height -= move;
		frame.origin.y += move;
		[[[_detailsText superview] superview] retain];
		[[[_detailsText superview] superview] removeFromSuperview];
		[_window setFrame:frame display:(sender != nil) animate:(sender != nil)];
	} else {
		[_detailsButton setState:TRUE];
		NSRect frame = [_window frame];
		float move = [[[_detailsText superview] superview] frame].size.height + 20;
		frame.size.height += move;
		frame.origin.y -= move;
		[_window setFrame:frame display:(sender != nil) animate:(sender != nil)];
		[[_window contentView] addSubview:[[_detailsText superview] superview]];
		[[[_detailsText superview] superview] release];
	}
}

#pragma mark rearanging the window
		
- (void)setupWindowForTitle:(NSString *)title message:(NSString *)msg defaultButton:(NSString *)defaultButton otherButton:(NSString *)otherButton checkboxString:(NSString *)checkboxString checkboxState:(BOOL *)checkboxState detailsString:(NSString *)detailsString detailsButtonTitle:(NSString *)detailsButtonTitle detialsState:(BOOL *)detailsState {
	if (!defaultButton) { defaultButton = FSLocalizedString(@"OK",nil); }
	if (!detailsButtonTitle) { detailsButtonTitle = @""; }
	if (!title) { title = @""; }
	if (!msg) { msg = @""; }
	
	// a small amount of setup
	if (checkboxState) {
		_checkValue = checkboxState;
		_sendCheckValue = TRUE;
		[_check setObjectValue:[NSNumber numberWithBool:*checkboxState]];
	} else {
		_checkValue = NULL;
		_sendCheckValue = FALSE;
		[_check setObjectValue:[NSNumber numberWithBool:0]];
	}
	if (detailsState) {
		_detailsState = detailsState;
		_sendDetailsState = TRUE;
		[_detailsButton setState:*detailsState];
	} else {
		_detailsState = NULL;
		_sendDetailsState = FALSE;
		[_detailsButton setState:0];
	}
	
	// set the text values and sizes to what they need to be
	float compare;
	
	[_defaultButton setTitle:defaultButton];
	[_defaultButton sizeToFit];
	compare = [_defaultButton frame].size.width;
	[_defaultButton setFrameSize:NSMakeSize(((compare+20) > 90)?compare+20:90,34)];
	
	if (otherButton)
	{
		if (![_otherButton isDescendantOf:[_window contentView]])
		{
			[[_window contentView] addSubview:_otherButton];
			[_otherButton release];
		}
		[_otherButton setTitle:otherButton];
		[_otherButton sizeToFit];
		compare = [_otherButton frame].size.width;
		[_otherButton setFrameSize:NSMakeSize(((compare+20) > 90)?compare+20:90,34)];
	} else {
		if ([_otherButton isDescendantOf:[_window contentView]])
		{
			[_otherButton retain];
			[_otherButton removeFromSuperview];
		}
	}
	
	if (checkboxString)
	{
		if (![_check isDescendantOf:[_window contentView]])
		{
			[[_window contentView] addSubview:_check];
			[_check release];
		}
		[_check setTitle:checkboxString];
		[_check sizeToFit];
		compare = [_check frame].size.width;
		[_check setFrameSize:NSMakeSize((compare > 64)?compare:64,20)];
	} else {
		if ([_check isDescendantOf:[_window contentView]])
		{
			[_check retain];
			[_check removeFromSuperview];
		}
	}
	
	float button_widths = ([_defaultButton frame].size.width-12) + ([_otherButton isDescendantOf:[_window contentView]]?([_otherButton frame].size.width-12)+12:0) - 9; /* the -9 is the 3px offset that the buttons are supposed to go past the text plus the 6px difference of the button in an app and IB */
	float text_width = (button_widths > 284)?button_widths:284;
	text_width = ((button_widths + ([_check frame].size.width-5) + 9 + 9) > 367)?(button_widths + ([_check frame].size.width-5) + 9 + 9 - 83):text_width; /* the first +9 is the spacing, the second +9 is to make up for the -9 offset from above */
	
	[_title setStringValue:title];
	[_title sizeToFit];
	[_title setFrameSize:NSMakeSize(text_width, ceil([_title frame].size.width / text_width)*17)];
	
	[_msg setStringValue:msg];
	[_msg sizeToFit];
	[_msg setFrameSize:NSMakeSize(text_width, ceil([_msg frame].size.width / text_width)*17)];
	
	if (detailsString)
	{
		if (![_detailsText isDescendantOf:[_window contentView]])
		{
			[[_window contentView] addSubview:[[_detailsText superview] superview]];
			[[[_detailsText superview] superview] release];
		}
		[[[_detailsText superview] superview] setFrameSize:NSMakeSize(text_width, [[[_detailsText superview] superview] frame].size.height)];
		[_detailsText setFrameSize:NSMakeSize(text_width - [NSScroller scrollerWidth], [_detailsText frame].size.height)];
		[_detailsText setString:detailsString];
	} else {
		if ([_detailsText isDescendantOf:[_window contentView]])
		{
			[[[_detailsText superview] superview] retain];
			[[[_detailsText superview] superview] removeFromSuperview];
		}
	}
	
	if (detailsString)
	{
		if (![_detailsButtonText isDescendantOf:[_window contentView]])
		{
			[[_window contentView] addSubview:_detailsButtonText];
			[_detailsButtonText release];
		}
		[_detailsButtonText setTitle:detailsButtonTitle];
		[_detailsButtonText sizeToFit];
	} else {
		if ([_detailsButtonText isDescendantOf:[_window contentView]])
		{
			[_detailsButtonText retain];
			[_detailsButtonText removeFromSuperview];
		}
	}

	if (detailsString)
	{
		if (![_detailsButton isDescendantOf:[_window contentView]])
		{
			[[_window contentView] addSubview:_detailsButton];
			[_detailsButton release];
		}
	} else {
		if ([_detailsButton isDescendantOf:[_window contentView]])
		{
			[_detailsButton retain];
			[_detailsButton removeFromSuperview];
		}
	}
	
	compare = 15 + [_title frame].size.height + 9 + [_msg frame].size.height + 21 + ([_defaultButton frame].size.height-14) + (detailsString? 4 + [_detailsButtonText frame].size.height + 8 + [[[_detailsText superview] superview] frame].size.height : 0 ) + 19;
	float window_height = (compare > 131)?compare:131;
	float window_width = text_width + 136;
	
	[_window setContentSize:NSMakeSize(window_width, window_height)];
	
	// align things where they need to be
	
	[_defaultButton setFrameOrigin:NSMakePoint(window_width - [_defaultButton frame].size.width - 14, [_defaultButton frame].origin.y)];
	[_otherButton setFrameOrigin:NSMakePoint([_defaultButton frame].origin.x - [_otherButton frame].size.width - 4, [_otherButton frame].origin.y)];
	
	[_image setFrameOrigin:NSMakePoint([_image frame].origin.x, window_height - [_image frame].size.height - 16)];
	[_title setFrameOrigin:NSMakePoint([_title frame].origin.x, window_height - [_title frame].size.height - 15)];
	[_msg setFrameOrigin:NSMakePoint([_msg frame].origin.x, [_title frame].origin.y - [_msg frame].size.height - 9)];
	
	if (detailsString)
	{
		[_detailsButton setFrameOrigin:NSMakePoint([_detailsButton frame].origin.x, [_msg frame].origin.y - [_detailsButton frame].size.height - 5)];
		[_detailsButtonText setFrameOrigin:NSMakePoint([_detailsButtonText frame].origin.x, [_msg frame].origin.y - [_detailsButtonText frame].size.height - 4)];
		NSView *view = [[_detailsText superview] superview];
		[view setFrameOrigin:NSMakePoint([view frame].origin.x, [_detailsButton frame].origin.y - [view frame].size.height - 8)];
	}
	
	if (detailsString && ([_detailsButton state] == 0)) {
		[self details:nil];
	}

	[_window display];
}

@end