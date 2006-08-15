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

#import "FSPreferenceWindowController.h"
#import "FSViewController.h"
#import "FSControlledView.h"
#import "FSArrayExtensions.h"

@interface FSPreferenceToolbarItem : NSToolbarItem {
	FSViewController <FSPreferenceViewControllerProtocol> *viewController;
}
- (FSViewController <FSPreferenceViewControllerProtocol> *)preferenceViewController;
- (void)setPreferenceViewController:(FSViewController <FSPreferenceViewControllerProtocol> *)viewController;
@end

@implementation FSPreferenceToolbarItem : NSToolbarItem
- (FSViewController <FSPreferenceViewControllerProtocol> *)preferenceViewController {
	return viewController;
}
- (void)setPreferenceViewController:(FSViewController <FSPreferenceViewControllerProtocol> *)aController {
	if (aController != viewController) {
		[viewController release];
		viewController = [aController retain];
	}
}
@end

@interface FSPreferenceWindowController (PRIVATE)
- (NSString *)selectedIdentifier;
- (void)setSelectedIdentifier:(NSString *)sel;
- (void)changePreferenceView:(id)sender;
@end

@implementation FSPreferenceWindowController

- (id)init {
	if (self = [super init]) {
		views = [[NSMutableArray alloc] init];
		toolbar = [[NSToolbar alloc] initWithIdentifier:@"Preference Toolbar"];
		[toolbar setAutosavesConfiguration:YES];
		[toolbar setDelegate:self];
		[toolbar setAllowsUserCustomization:NO];
		[[self window] setToolbar:toolbar];
	}
	return self;
}

//- (id)initWithContentRect:(NSRect)contentRect styleMask:(unsigned int)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
//	if (self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag])
//	{
//		title = nil;
//		autosaveName = nil;
//		selected = nil;
//		views = [[NSMutableArray alloc] init];
//		toolbar = [[NSToolbar alloc] initWithIdentifier:@"Preference Toolbar"];
//		[toolbar setAutosavesConfiguration:YES];
//		[toolbar setDelegate:self];
//		[toolbar setAllowsUserCustomization:NO];
//		[[self window] setToolbar:toolbar];
//		return self;
//	} else {
//		return nil;
//	}
//}

- (void)dealloc {
	[toolbar release];
	[views release];
	[title release];
	[selected release];
	[autosaveName release];
	[super dealloc];
}

- (void)close {
	if (autosaveName)
	{
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults setObject:[NSDictionary dictionaryWithObjectsAndKeys:
			[NSNumber numberWithFloat:[[self window] frame].origin.x], @"X Origin",
			[NSNumber numberWithFloat:[[self window] frame].origin.y + [[self window] frame].size.height], @"Y Max Origin",
			[self selectedIdentifier] ? [NSString stringWithString:[self selectedIdentifier]] : @"", @"Selected Item Identifier", // make a new selected string so that when reopening view, selected != identifier after retaining that object a few times.... cool!
			nil, nil] forKey:autosaveName];
	}
	[super close];
}

- (NSString *)selectedIdentifier {
	return selected;
}

- (void)setSelectedIdentifier:(NSString *)sel {
	if (sel != selected) {
		[selected release];
		selected = [sel retain];
	}
}

- (NSString *)autosaveName {
	return autosaveName;
}

- (void)setAutosaveName:(NSString *)name {
	if (autosaveName != name) {
		[autosaveName release];
		autosaveName = [[NSString stringWithFormat:@"PreferenceWindow Configuration %@", name] retain];
	}
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSDictionary *saved;
	if (saved = [defaults objectForKey:autosaveName]) {
		[[self window] setFrame:NSMakeRect([[saved objectForKey:@"X Origin"] floatValue], [[saved objectForKey:@"Y Max Origin"] floatValue] - [[self window] frame].size.height, [[self window] frame].size.width, [[self window] frame].size.height) display:YES];

		NSString *sel = [saved objectForKey:@"Selected Item Identifier"];
		int counter;
		for (counter = 0; counter < [[toolbar items] count]; counter++) {
			if ([[[[toolbar items] objectAtIndex:counter] itemIdentifier] isEqualToString:sel]) {
				[self changePreferenceView:[[toolbar items] objectAtIndex:counter]];
				[toolbar setSelectedItemIdentifier:[[[toolbar items] objectAtIndex:counter] itemIdentifier]];
			}
		}
	}
}

- (void)setTitle:(NSString *)new_title {
	if (title != new_title) {
		[title release];
		title = [new_title retain];
	}

	if (title && [views count]) {
		[[self window] setTitle:[NSString stringWithFormat:@"%@%@", title, [[views objectAtIndex:0] label]]];
	} else {
		[[self window] setTitle:@""];
	}
}

- (void)addView:(FSViewController <FSPreferenceViewControllerProtocol> *)view {
	[views addObject:view];
	[toolbar insertItemWithItemIdentifier:[view label] atIndex:[[toolbar items] count]];
	if ([views count] == 1 && [[toolbar items] count] == 1) // if first added item select it
	{
		[self changePreferenceView:[[toolbar items] objectAtIndex:0]];
		[toolbar setSelectedItemIdentifier:[[[toolbar items] objectAtIndex:0] itemIdentifier]];
	}
}

- (void)changePreferenceView:(id)sender {
	if ([sender itemIdentifier] != [self selectedIdentifier])
	{
		[self setSelectedIdentifier:[sender itemIdentifier]];
		
		// set title stuff
		if (title) { [[self window] setTitle:[NSString stringWithFormat:@"%@%@", title, [sender itemIdentifier]]]; }
		else { [[self window] setTitle:[sender itemIdentifier]]; }
		
		// declare some stuff
		NSView *content = [[NSView alloc] init];
		FSViewController <FSPreferenceViewControllerProtocol> *newViewController = [sender preferenceViewController];
		NSView *newView = [newViewController view];
		
		float height_difference = [newView frame].size.height - [[[self window] contentView] frame].size.height;
		float width_difference = [[[self window] contentView] frame].size.width - [newView frame].size.width;
				
		// make view blank and resize the window (nicely)
		[[self window] setContentView:[[[NSView alloc] init] autorelease]];
		[[self window] setFrame:NSMakeRect([[self window] frame].origin.x, [[self window] frame].origin.y - height_difference, [[self window] frame].size.width, [[self window] frame].size.height + height_difference) display:YES animate:YES];

		// set up internal view
		[newView setFrame:NSMakeRect((int)width_difference / 2, 0, [newView frame].size.width, [newView frame].size.height)]; // approximate centering by using int so that pixles aren't funky
		[newView setAutoresizingMask:NSViewMinXMargin | NSViewMaxXMargin];
		
		// show the view we want to be shown
		[[self window] setContentView:content];
		[content addSubview:newView];
		
		// release things
		[content release];
	}
}

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag; {
	int counter;
	for (counter = 0; counter < [views count]; counter++)
	{
		FSViewController <FSPreferenceViewControllerProtocol> *viewController = [views objectAtIndex:counter];
		if ([[viewController label] isEqualToString:itemIdentifier])
		{
			FSPreferenceToolbarItem *item = [[[FSPreferenceToolbarItem alloc] initWithItemIdentifier:[viewController label]] autorelease];
			[item setLabel:[viewController label]];
			[item setImage:[viewController image]];
			[item setPreferenceViewController:viewController];
			[item setTarget:self];
			[item setAction:@selector(changePreferenceView:)];
			return item;
		}
	}
	// all other cases
	return nil;
}

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar*)toolbar {
	return [views arrayByPerformingSelectorOnObjects:@selector(label)];
}

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar*)toolbar {
	return [views arrayByPerformingSelectorOnObjects:@selector(label)];
}

- (NSArray *)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar {
	return [views arrayByPerformingSelectorOnObjects:@selector(label)];
}

@end
