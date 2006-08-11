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

#import "FSPreferenceWindow.h"
#import "FSApplicationAdditions.h"
#import "FSArrayExtensions.h"

@interface FSPreferenceToolbarItem : NSToolbarItem {
	NSView <FSPreferenceViewProtocol> *view;
}
- (NSView <FSPreferenceViewProtocol> *)preferenceView;
- (void)setPreferenceView:(NSView <FSPreferenceViewProtocol> *)view;
@end

@implementation FSPreferenceToolbarItem : NSToolbarItem
- (NSView <FSPreferenceViewProtocol> *)preferenceView {
	return view;
}
- (void)setPreferenceView:(NSView <FSPreferenceViewProtocol> *)v {
	if (v != view) {
		[view release];
		view = [v retain];
	}
}
@end

@interface FSPreferenceWindow (PRIVATE)
- (NSString *)selectedIdentifier;
- (void)setSelectedIdentifier:(NSString *)sel;
- (void)changePreferenceView:(id)sender;
@end

@implementation FSPreferenceWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(unsigned int)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
	if (self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag])
	{
		title = nil;
		autosave_name = nil;
		selected = nil;
		views = [[NSMutableArray alloc] init];
		toolbar = [[NSToolbar alloc] initWithIdentifier:@"Preference Toolbar"];
		[toolbar setAutosavesConfiguration:YES];
		[toolbar setDelegate:self];
		[toolbar setAllowsUserCustomization:NO];
		[self setToolbar:toolbar];
		return self;
	} else {
		return nil;
	}
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[toolbar release];
	[views release];
	[title release];
	[selected release];
	[autosave_name release];
	[super dealloc];
}

- (void)close {
	if (autosave_name)
	{
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults setObject:[NSDictionary dictionaryWithObjectsAndKeys:
			[NSNumber numberWithFloat:[self frame].origin.x], @"X Origin",
			[NSNumber numberWithFloat:[self frame].origin.y + [self frame].size.height], @"Y Max Origin",
			([self selectedIdentifier])?[NSString stringWithString:[self selectedIdentifier]]:@"", @"Selected Item Identifier", // make a new selected string so that when reopening view, selected != identifier after retaining that object a few times.... cool!
			nil, nil] forKey:autosave_name];
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
	return autosave_name;
}

- (void)setAutosaveName:(NSString *)name {
	if (autosave_name != name) {
		[autosave_name release];
		autosave_name = [[NSString stringWithFormat:@"PreferenceWindow Configuration %@", name] retain];
	}
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSDictionary *saved;
	if (saved = [defaults objectForKey:autosave_name]) {
		[self setFrame:NSMakeRect([[saved objectForKey:@"X Origin"] floatValue], [[saved objectForKey:@"Y Max Origin"] floatValue] - [self frame].size.height, [self frame].size.width, [self frame].size.height) display:YES];

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
		[super setTitle:[NSString stringWithFormat:@"%@%@", title, [[views objectAtIndex:0] label]]];
	} else {
		[super setTitle:nil];
	}
}

- (NSTimeInterval)animationResizeTime:(NSRect)newFrame { // resize slower than default
	return [[[NSUserDefaults standardUserDefaults] objectForKey:@"NSWindowResizeTime"] doubleValue] * 1.5;
}

- (void)addView:(NSView <FSPreferenceViewProtocol> *)view {
	[views addObject:view];
	if ([self frame].size.width < [view frame].size.width)
	{
		[self setFrame:NSMakeRect([self frame].origin.x, [self frame].origin.y, [view frame].size.width, [self frame].size.height) display:NO];
	}
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
		if (title) { [super setTitle:[NSString stringWithFormat:@"%@%@", title, [sender itemIdentifier]]]; }
		else { [super setTitle:[sender itemIdentifier]]; }
		
		// declare some stuff
		NSView *content = [[NSView alloc] init];
		NSView <FSPreferenceViewProtocol> *new_view = [sender preferenceView];//[views objectAtIndex:[labels indexOfObject:[sender itemIdentifier]]];
		float height_difference = [new_view frame].size.height - [[self contentView] frame].size.height;
		float width_difference = [[self contentView] frame].size.width - [new_view frame].size.width;
		
		if (![new_view loaded]) {
			[new_view load];
		}
		
		// make view blank and resize the window (nicely)
		[self setContentView:[[[NSView alloc] init] autorelease]];
		[self setFrame:NSMakeRect([self frame].origin.x, [self frame].origin.y - height_difference, [self frame].size.width, [self frame].size.height + height_difference) display:YES animate:YES];

		// set up internal view
		[new_view setFrame:NSMakeRect((int)width_difference / 2, 0, [new_view frame].size.width, [new_view frame].size.height)]; // approximate centering by using int so that pixles aren't funky
		[new_view setAutoresizingMask:NSViewMinXMargin | NSViewMaxXMargin];
		
		// show the view we want to be shown
		[self setContentView:content];
		[content addSubview:new_view];
		
		// release things
		[content release];
	}
}

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag; {
	int counter;
	for (counter = 0; counter < [views count]; counter++)
	{
		NSView <FSPreferenceViewProtocol> *view = [views objectAtIndex:counter];
		if ([[view label] isEqualToString:itemIdentifier])
		{
			FSPreferenceToolbarItem *item = [[[FSPreferenceToolbarItem alloc] initWithItemIdentifier:[(NSView <FSPreferenceViewProtocol> *)[views objectAtIndex:counter] label]] autorelease];
			[item setLabel:[(NSView <FSPreferenceViewProtocol> *)[views objectAtIndex:counter] label]];
			[item setImage:[(NSView <FSPreferenceViewProtocol> *)[views objectAtIndex:counter] image]];
			[item setPreferenceView:view];
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
