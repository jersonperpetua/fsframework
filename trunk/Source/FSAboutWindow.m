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

#import "FSAboutWindow.h"

#define ABOUT_BOX_NIB					@"AboutBox"
#define ABOUT_SCROLL_FPS				20.0
#define APP_NAME						@"Senuti"
#define APP_HOMEPAGE					@"http://wbyoung.ambitiouslemon.com/senuti/"
#define APP_DONATE						@"http://wbyoung.ambitiouslemon.com/senuti/donate.php"

@interface FSAboutWindow (PRIVATE)
- (NSString *)_applicationVersion;
- (void)_loadBuildInformation;
@end

@implementation FSAboutWindow

#warning not complete

- (id)init {
	[self initWithContentRect:NSMakeRect(0, 0, 577, 205) styleMask:NSClosableWindowMask | NSTitledWindowMask backing:NSBackingStoreBuffered defer:YES];
	return self;
}

//Init
- (id)initWithContentRect:(NSRect)contentRect styleMask:(unsigned int)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
	if (self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag]) {
		
		NSImageView *image_view;
		image_view = [[[NSImageView alloc] initWithFrame:NSMakeRect(15, 62, 128, 128)] autorelease];
		[image_view setImageScaling:NSScaleProportionally];
		[image_view setImage:[NSApp applicationIconImage]];
		[[self contentView] addSubview:image_view];
		
		
		textView_credits = [[[NSTextView alloc] initWithFrame:NSMakeRect(158, 50, 399, 140)] autorelease];
		[textView_credits setEditable:NO];
		[textView_credits setSelectable:NO];
		[textView_credits setRichText:YES];
		[textView_credits setImportsGraphics:NO];
		[textView_credits setAllowsUndo:NO];
		
		NSScrollView *scroll = [[[NSScrollView alloc] initWithFrame:NSMakeRect(158, 50, 399, 140)] autorelease];
		[scroll setBorderType:NSBezelBorder];
		[scroll setDocumentView:textView_credits];
		[[self contentView] addSubview:scroll];
		
		button_license = [[[NSButton alloc] initWithFrame:NSMakeRect(153, 16, 135, 24)] autorelease];
		[button_license setButtonType:NSMomentaryPushInButton];
		[button_license setBezelStyle:NSRoundedBezelStyle];
		[button_license setFont:[NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:NSRegularControlSize]]];
		[button_license setTarget:self];
		[button_license setAction:@selector(showLicense:)];
		[[self contentView] addSubview:button_license];

		button_donate = [[[NSButton alloc] initWithFrame:NSMakeRect(290, 16, 135, 24)] autorelease]; 
		[button_donate setButtonType:NSMomentaryPushInButton];
		[button_donate setBezelStyle:NSRoundedBezelStyle];
		[button_donate setFont:[NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:NSRegularControlSize]]];
		[button_donate setTarget:self];
		[button_donate setAction:@selector(visitDonate:)];
		[[self contentView] addSubview:button_donate];

		button_homepage = [[[NSButton alloc] initWithFrame:NSMakeRect(427, 16, 135, 24)] autorelease];
		[button_homepage setButtonType:NSMomentaryPushInButton];
		[button_homepage setBezelStyle:NSRoundedBezelStyle];
		[button_homepage setFont:[NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:NSRegularControlSize]]];
		[button_homepage setTarget:self];
		[button_homepage setAction:@selector(visitHomepage:)];
		[[self contentView] addSubview:button_homepage];

		button_version = [[[NSButton alloc] initWithFrame:NSMakeRect(15, 20, 128, 17)] autorelease];
		[button_version setButtonType:NSMomentaryChangeButton];
		[button_version setBordered:NO];
		[button_version setFont:[NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:NSSmallControlSize]]];
		[button_version setTarget:self];
		[button_version setAction:@selector(buildFieldClicked:)];
		[[self contentView] addSubview:button_version];
		
		textField_name = [[[NSTextField alloc] initWithFrame:NSMakeRect(12, 37, 134, 22)] autorelease];
		[textField_name setEditable:NO];
		[textField_name setBordered:NO];
		[textField_name setDrawsBackground:NO];
		[textField_name setFont:[NSFont systemFontOfSize:18]];
		[textField_name setAlignment:NSCenterTextAlignment];
		[[self contentView] addSubview:textField_name];
		
		panel_licenseSheet = [[NSPanel alloc] initWithContentRect:NSMakeRect(0, 0, 530, 456) styleMask:NSTitledWindowMask | NSClosableWindowMask backing:NSBackingStoreBuffered defer:YES];
		
		textView_license = [[[NSTextView alloc] initWithFrame:NSMakeRect(20, 60, 490, 376)] autorelease];
		[textView_license setEditable:NO];
		[textView_license setSelectable:NO];
		[textView_license setRichText:YES];
		[textView_license setFont:[NSFont fontWithName:@"Monaco" size:10]];
		[textView_license setImportsGraphics:NO];
		[textView_license setAllowsUndo:NO];
			
		NSButton *close_button = [[[NSButton alloc] initWithFrame:NSMakeRect(423, 16, 92, 24)] autorelease]; 
		[close_button setButtonType:NSMomentaryPushInButton];
		[close_button setBezelStyle:NSRoundedBezelStyle];
		[close_button setFont:[NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:NSRegularControlSize]]];
		[close_button setTarget:self];
		[close_button setAction:@selector(hideLicense:)];
		[close_button setTitle:@"Okay"];
		[close_button setKeyEquivalent:@"\r"];
		[[panel_licenseSheet contentView] addSubview:close_button];
		
		scroll = [[[NSScrollView alloc] initWithFrame:NSMakeRect(20, 60, 490, 376)] autorelease];
		[scroll setBorderType:NSBezelBorder];
		[scroll setDocumentView:textView_license];
		[scroll setHasVerticalScroller:YES];
		[[panel_licenseSheet contentView] addSubview:scroll];
		
		NSAttributedString	*creditsString;
		
		//Load our build information and avatar list
		[self _loadBuildInformation];
		
		//Credits
		creditsString = [[[NSAttributedString alloc] initWithPath:[[NSBundle mainBundle] pathForResource:@"About.rtf" ofType:nil] documentAttributes:nil] autorelease];
		[[textView_credits textStorage] setAttributedString:creditsString];
		[[textView_credits enclosingScrollView] setLineScroll:0.0];
		[[textView_credits enclosingScrollView] setPageScroll:0.0];
		
		//Start scrolling
		scrollLocation = 0; 
		scrollRate = 1.0;
		maxScroll = [[textView_credits textStorage] size].height - [[textView_credits enclosingScrollView] documentVisibleRect].size.height;
		scrollTimer = [[NSTimer scheduledTimerWithTimeInterval:(1.0/ABOUT_SCROLL_FPS)
														target:self
													  selector:@selector(scrollTimer:)
													  userInfo:nil
													   repeats:YES] retain];
		eventLoopScrollTimer = [[NSTimer timerWithTimeInterval:(1.0/ABOUT_SCROLL_FPS)
														target:self
													  selector:@selector(scrollTimer:)
													  userInfo:nil
													   repeats:YES] retain];
		[[NSRunLoop currentRunLoop] addTimer:eventLoopScrollTimer forMode:NSEventTrackingRunLoopMode];
		
		//Setup the build date / version
		[button_version setTitle:[self _applicationVersion]];
		[textField_name setStringValue:APP_NAME];
		
		//Set the localized values
		[self setTitle:[NSString stringWithFormat:@"About %@", APP_NAME]];
		[button_homepage setTitle:@"Homepage"];
		[button_license setTitle:@"License"];
		[button_donate setTitle:@"Donate"];
		
		[self center];		
	}
	return self;
}

//Dealloc
- (void)dealloc {
	[buildDate release];
	[panel_licenseSheet release];

	[super dealloc];
}

//Cleanup as the window is closing
- (void)close {
	[scrollTimer invalidate];
	[scrollTimer release];
	scrollTimer = nil;
	
	[eventLoopScrollTimer invalidate];
	[eventLoopScrollTimer release];
	eventLoopScrollTimer = nil;
	
	[super close];
}

//Visit the homepage
- (IBAction)visitHomepage:(id)sender {
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:APP_HOMEPAGE]];
}

- (IBAction)visitDonate:(id)sender {
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:APP_DONATE]];
}


//Scrolling Credits ----------------------------------------------------------------------------------------------------
#pragma mark Scrolling Credits
//Scroll the credits
- (void)scrollTimer:(NSTimer *)scrollTimer {
	scrollLocation += scrollRate;
	
	if(scrollLocation > maxScroll) scrollLocation = 0;
	if(scrollLocation < 0) scrollLocation = maxScroll;
	
	[textView_credits scrollPoint:NSMakePoint(0, scrollLocation)];
}

//Receive the flags changed event for reversing the scroll direction via option
- (void)flagsChanged:(NSEvent *)theEvent {
	if(([theEvent modifierFlags] & NSAlternateKeyMask) != 0) {
		scrollRate = -1.0;
	}else{
		scrollRate = 1.0;   
	}
}

//Receive the key down event for pausing and starting the scroll
- (void)keyDown:(NSEvent *)theEvent {
	if ([[theEvent characters] characterAtIndex:0] == ' ')
	{
		if((++numberOfSpaceKeyDowns) % 2 == 0){
			scrollTimer = [[NSTimer scheduledTimerWithTimeInterval:(1.0/ABOUT_SCROLL_FPS)
															target:self
														  selector:@selector(scrollTimer:)
														  userInfo:nil
														   repeats:YES] retain];
			eventLoopScrollTimer = [[NSTimer timerWithTimeInterval:(1.0/ABOUT_SCROLL_FPS)
														   target:self
														 selector:@selector(scrollTimer:)
														 userInfo:nil
														  repeats:YES] retain];
			[[NSRunLoop currentRunLoop] addTimer:eventLoopScrollTimer forMode:NSEventTrackingRunLoopMode];
		}else{
			[scrollTimer invalidate]; [scrollTimer release]; scrollTimer = nil;
			[eventLoopScrollTimer invalidate]; [eventLoopScrollTimer release]; eventLoopScrollTimer = nil;
		}
	} else {
		[super keyDown:theEvent];
	}
}


//Build Information ----------------------------------------------------------------------------------------------------
#pragma mark Build Information
//Toggle build date/number display
- (IBAction)buildFieldClicked:(id)sender {
	if((++numberOfBuildFieldClicks) % 2 == 0) {
		[button_version setTitle:[self _applicationVersion]];
	} else {
		[button_version setTitle:buildDate];
	}
}

//Returns the current version of the Application
- (NSString *)_applicationVersion {
	NSString *version = [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleShortVersionString"];
	NSString *v_version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	
	return [NSString stringWithFormat:@"%@ %@", (version ? version : @""), (v_version ? [NSString stringWithFormat:@"(v%@)", v_version] : @"")];
}

//Load the current build date and our cryptic, non-sequential build number ;)
- (void)_loadBuildInformation {
	//Grab the info from our buildnum script
	char *path, unixDate[256], whoami[256];
	if(path = (char *)[[[NSBundle mainBundle] pathForResource:@"build" ofType:nil] fileSystemRepresentation]) {
		FILE *f = fopen(path, "r");
		fscanf(f, "%s | %s", unixDate, whoami);
		fclose(f);
			
		if(*unixDate){
			NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] initWithDateFormat:[[NSUserDefaults standardUserDefaults] stringForKey:NSShortDateFormatString] allowNaturalLanguage:NO] autorelease];

			NSDate	*date;
			
			date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithCString:unixDate] doubleValue]];
			buildDate = [[dateFormatter stringForObjectValue:date] retain];
		}
	}
	
	//Default to empty strings if something goes wrong
	if(!buildDate) buildDate = [@"" retain];
}


//Software License -----------------------------------------------------------------------------------------------------
#pragma mark Software License
//Display the software license sheet
- (IBAction)showLicense:(id)sender {
	NSString	*licensePath = [[NSBundle mainBundle] pathForResource:@"license" ofType:@"txt"];
	[textView_license setString:[NSString stringWithContentsOfFile:licensePath]];
	
	[NSApp beginSheet:panel_licenseSheet
	   modalForWindow:self
		modalDelegate:nil
	   didEndSelector:nil
		  contextInfo:nil];
}

//Close the software license sheet
- (IBAction)hideLicense:(id)sender {
	[panel_licenseSheet orderOut:nil];
	[NSApp endSheet:panel_licenseSheet returnCode:0];
}

@end
