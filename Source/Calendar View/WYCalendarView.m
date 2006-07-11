/*
	Copyright (C) 2004  Whitney Young

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
*/

/* WYCalendarView */

#import "WYCalendarView.h"
#import "WYCalendarMatrix.h"
#import "WYNeverEnabledActionCell.h"

@interface WYCalendarView (PRIVATE)

- (void)updateForNewValue;
- (void)increaseMonth:(id)sender;
- (void)decreaseMonth:(id)sender;
- (void)today:(id)sender;

- (void)setDay:(int)day;

@end

@implementation WYCalendarView

+ (Class)cellClass {
	return [WYNeverEnabledActionCell class];
}

- (id)initWithFrame:(NSRect)frame {
	self = [super initWithFrame:frame];
	
	float left_origin = (frame.size.width - 154) / 2;
	
	cal = [[WYCalendarMatrix alloc] initWithFrame:NSMakeRect(left_origin, frame.size.height-145, 154, 120)];
	[cal setTarget:self];
	[cal setAction:@selector(dayOfMonthClicked:)];
	[cal setAutoresizingMask:NSViewMinXMargin | NSViewMaxXMargin];

	[self addSubview:cal];
	[cal release];
	
	
	month = [[NSTextField alloc] initWithFrame:NSMakeRect(left_origin, frame.size.height-15, 154, 16)];
	[month setAlignment:NSRightTextAlignment];
	[month setAutoresizingMask:NSViewMinXMargin | NSViewMaxXMargin];
	[month setFont:[NSFont boldSystemFontOfSize:[NSFont systemFontSizeForControlSize:NSSmallControlSize]]];
	[month setEditable:NO];
	[month setBezeled:NO];
	[month setBordered:NO];
	[month setDrawsBackground:NO];
	[month setFormatter:[[[NSDateFormatter alloc] initWithDateFormat:@"%B %Y" allowNaturalLanguage:YES] autorelease]];
	
	[self addSubview:month];
	[month release];
	
	
	NSView *container = [[NSView alloc] initWithFrame:NSMakeRect(left_origin, frame.size.height-12, 154, 12)];
	[container setAutoresizingMask:NSViewMinXMargin | NSViewMaxXMargin];
	
	[self addSubview:container];
	[container release];
	
	NSImage *image;
	
	previous_month = [[NSButton alloc] initWithFrame:NSMakeRect(0, 0, 12, 12)];
	[previous_month setAutoresizingMask:NSViewMinXMargin];
	image = [[NSImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Versions/A/Resources/left.png", [[NSBundle bundleForClass:[self class]] bundlePath]]];
	[previous_month setImage:image];
	[image release];
	[[previous_month cell] setBordered:NO];
	[[previous_month cell] setBezeled:NO];
	[previous_month setTarget:self];
	[previous_month setAction:@selector(decreaseMonth:)];
	
	[container addSubview:previous_month];
	[previous_month release];
	
	today  = [[NSButton alloc] initWithFrame:NSMakeRect(15, 0, 12, 12)];
	[today setAutoresizingMask:NSViewMinXMargin];
	image = [[NSImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Versions/A/Resources/current.png", [[NSBundle bundleForClass:[self class]] bundlePath]]];
	[today setImage:image];
	[image release];
	[[today cell] setBordered:NO];
	[[today cell] setBezeled:NO];
	[today setTarget:self];
	[today setAction:@selector(today:)];
	
	[container addSubview:today];
	[today release];
	
	next_month = [[NSButton alloc] initWithFrame:NSMakeRect(30, 0, 12, 12)];
	[next_month setAutoresizingMask:NSViewMinXMargin];
	image = [[NSImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Versions/A/Resources/right.png", [[NSBundle bundleForClass:[self class]] bundlePath]]];
	[next_month setImage:image];
	[image release];
	[[next_month cell] setBordered:NO];
	[[next_month cell] setBezeled:NO];
	[next_month setTarget:self];
	[next_month setAction:@selector(increaseMonth:)];
	
	[container addSubview:next_month];
	[next_month release];
	
	return self;
}

- (void)dealloc {
	[super dealloc];
}

- (void)setEnabled:(BOOL)flag {
	[super setEnabled:flag];
	if (flag)
	{
		[[month cell] setTextColor:[NSColor controlTextColor]];
		[cal setEnabled:YES];
	} else {
		[[month cell] setDrawsBackground:NO];
		[[month cell] setTextColor:[NSColor disabledControlTextColor]];
		[cal setEnabled:NO];
	}
}

- (void)updateForNewValue {
	[cal applyDate:[self objectValue]];
	[month setObjectValue:[self objectValue]];
	[self setNeedsDisplay:YES];
}

- (void)increaseMonth:(id)sender {
	NSCalendarDate *date;
	if ([self objectValue] && [[self objectValue] isKindOfClass:[NSCalendarDate class]]) { date = [self objectValue]; }
	else { date = [NSCalendarDate calendarDate]; }
	
	[self setObjectValue:[date dateByAddingYears:0 months:1 days:0 hours:0 minutes:0 seconds:0]];
	[[self target] performSelector:[self action] withObject:self];
}

- (void)decreaseMonth:(id)sender {
	NSCalendarDate *date;
	if ([self objectValue] && [[self objectValue] isKindOfClass:[NSCalendarDate class]]) { date = [self objectValue]; }
	else { date = [NSCalendarDate calendarDate]; }
	
	[self setObjectValue:[date dateByAddingYears:0 months:-1 days:0 hours:0 minutes:0 seconds:0]];
	[[self target] performSelector:[self action] withObject:self];
}

- (void)today:(id)sender {
	[self setObjectValue:[NSCalendarDate calendarDate]];
	[[self target] performSelector:[self action] withObject:self];
}

- (void)setTarget:(id)target {
	[super setTarget:target];
}

- (void)dayOfMonthClicked:(id)sender {
	[self setDay:[sender intValue]];
	[[self target] performSelector:[self action] withObject:self];
}

- (void)setObjectValue:(id)anObject {
	[[self cell] setObjectValue:anObject];
	[self updateForNewValue];
}

- (id)objectValue {
	return [[self cell] objectValue];
}

- (void)setDay:(int)day {
	NSCalendarDate *date;
	
	if ([self objectValue] && [[self objectValue] isKindOfClass:[NSCalendarDate class]]) { date = [self objectValue]; }
	else { date = [NSCalendarDate calendarDate]; }
	
	[self setObjectValue:[NSCalendarDate dateWithYear:[date yearOfCommonEra] month:[date monthOfYear] day:day hour:[date hourOfDay] minute:[date minuteOfHour] second:[date secondOfMinute] timeZone:[date timeZone]]];
}

@end
