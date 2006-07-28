//
//  WYAboutWindow.h
//  WYAppFramework
//
//  Created by Whitney Young on 7/12/06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface WYAboutWindow : NSWindow {
	
	IBOutlet	NSPanel		*panel_licenseSheet;
	IBOutlet	NSTextView	*textView_license;
	
	IBOutlet	NSButton	*button_version;
	IBOutlet	NSButton	*button_homepage;
	IBOutlet	NSButton	*button_donate;
	IBOutlet	NSButton	*button_license;
	IBOutlet	NSTextField	*textField_name;
	IBOutlet	NSTextView	*textView_credits;
	
	//Version and duck clicking
	NSString 				*buildDate;
	int						numberOfBuildFieldClicks, numberOfSpaceKeyDowns;
	
	//Scrolling
	NSTimer					*scrollTimer;
	NSTimer					*eventLoopScrollTimer;
	float					scrollLocation;
	int						maxScroll;
	float				   scrollRate;
}

//- (IBAction)closeWindow:(id)sender;
- (IBAction)buildFieldClicked:(id)sender;
- (IBAction)visitHomepage:(id)sender;
- (IBAction)visitDonate:(id)sender;
- (IBAction)showLicense:(id)sender;
- (IBAction)hideLicense:(id)sender;

@end
