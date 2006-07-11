/*
Copyright (C) 2004-2005  Whitney Young

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

This code is orinally from Adam Iser's Adium.
	Visit http://www.adiumx.com/ for more information.
*/

/* LNAboutBoxController */

#import "LNAboutBoxController.h"

#define ABOUT_BOX_NIB					@"AboutBox"
#define ABOUT_SCROLL_FPS				20.0
#define APP_NAME						@"Senuti"
#define APP_HOMEPAGE					@"http://wbyoung.ambitiouslemon.com/senuti/"
#define APP_DONATE						@"http://wbyoung.ambitiouslemon.com/senuti/donate.php"

@interface LNAboutBoxController (PRIVATE)
- (id)initWithWindowNibName:(NSString *)windowNibName;
- (BOOL)windowShouldClose:(id)sender;
- (NSString *)_applicationVersion;
- (void)_loadBuildInformation;
@end

@implementation LNAboutBoxController

//Returns the shared about box instance
LNAboutBoxController *sharedAboutBoxInstance = nil;
+ (LNAboutBoxController *)aboutBoxController {
if(!sharedAboutBoxInstance){
sharedAboutBoxInstance = [[self alloc] initWithWindowNibName:ABOUT_BOX_NIB];
}
return(sharedAboutBoxInstance);
}

//Init
- (id)initWithWindowNibName:(NSString *)windowNibName {
[super initWithWindowNibName:windowNibName];
	return(self);
}

//Dealloc
- (void)dealloc {
[buildDate release];

[super dealloc];
}

//Prepare the about box window
- (void)windowDidLoad {
NSAttributedString		*creditsString;

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
	[[self window] setTitle:[NSString stringWithFormat:@"About %@", APP_NAME]];
	[button_homepage setTitle:@"Homepage"];
	[button_license setTitle:@"License"];

[[self window] center];
}

//Close the about box
- (IBAction)closeWindow:(id)sender {
if([self windowShouldClose:nil]){
[[self window] close];
}
}

//Cleanup as the window is closing
- (BOOL)windowShouldClose:(id)sender {
[sharedAboutBoxInstance autorelease]; sharedAboutBoxInstance = nil;
[scrollTimer invalidate]; [scrollTimer release]; scrollTimer = nil;
	[eventLoopScrollTimer invalidate]; [eventLoopScrollTimer release]; eventLoopScrollTimer = nil;
	
return(YES);
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
if((++numberOfBuildFieldClicks) % 2 == 0){
[button_version setTitle:[self _applicationVersion]];
}else{
		[button_version setTitle:buildDate];
}
}

//Returns the current version of the Application
- (NSString *)_applicationVersion {
NSString	*version = [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleShortVersionString"];
NSString	*v_version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	
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
	NSString	*licensePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"gpl" ofType:@"txt"];
	[textView_license setString:[NSString stringWithContentsOfFile:licensePath]];
	
	[NSApp beginSheet:panel_licenseSheet
	   modalForWindow:[self window]
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
