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

/* WYCalendarMatrix */

#import "WYCalendarMatrix.h"
#import "WYCalendarView.h"
#import "WYOvalActionCell.h"

@interface WYCalendarMatrix (PRIVATE)
- (void)numberCellTo:(int)max startingWith:(int)displacement;
- (void)selectDay:(int)day;
@end

@implementation WYCalendarMatrix

- (id)initWithFrame:(NSRect)frame {
	self = [super initWithFrame:frame mode:NSRadioModeMatrix prototype:nil numberOfRows:0 numberOfColumns:7];

	id cell = [[WYOvalActionCell alloc] init];
	[cell setEnabled:YES];
	[cell setStringValue:@""];
	[cell setAlignment:NSCenterTextAlignment];
	[cell setEnabled:NO];
	[cell setFont:[NSFont boldSystemFontOfSize:[NSFont systemFontSizeForControlSize:NSSmallControlSize]]];
	[cell setConstrainText:NO];
	
	id cell1 = [cell copy];
	[cell1 setStringValue:@"S"];
	id cell2 = [cell copy];
	[cell2 setStringValue:@"M"];
	id cell3 = [cell copy];
	[cell3 setStringValue:@"T"];
	id cell4 = [cell copy];
	[cell4 setStringValue:@"W"];
	id cell5 = [cell copy];
	[cell5 setStringValue:@"T"];
	id cell6 = [cell copy];
	[cell6 setStringValue:@"F"];
	id cell7 = [cell copy];
	[cell7 setStringValue:@"S"];
	
	[self addRowWithCells:[NSArray arrayWithObjects:cell1, cell2, cell3, cell4, cell5, cell6, cell7, nil]];	
	
	[cell1 release];
	[cell2 release];
	[cell3 release];
	[cell4 release];
	[cell5 release];
	[cell6 release];
	[cell7 release];

	[cell setFont:[NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:NSSmallControlSize]]];
	[cell setDrawsOval:YES];
	[cell setDrawsLeftOval:NO];
	[cell setDrawsRightOval:NO];
	[cell setOvalColor:[NSColor colorWithCalibratedWhite:0.9 alpha:1]];
	
	cell1 = [cell copy];
	[cell1 setDrawsLeftOval:YES];
	cell2 = [cell copy];
	cell3 = [cell copy];
	[cell3 setDrawsRightOval:YES];
	
	[self addRowWithCells:[NSArray arrayWithObjects:[[cell1 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell3 copy] autorelease], nil]];
	[self addRowWithCells:[NSArray arrayWithObjects:[[cell1 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell3 copy] autorelease], nil]];
	[self addRowWithCells:[NSArray arrayWithObjects:[[cell1 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell3 copy] autorelease], nil]];
	[self addRowWithCells:[NSArray arrayWithObjects:[[cell1 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell3 copy] autorelease], nil]];
	[self addRowWithCells:[NSArray arrayWithObjects:[[cell1 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell3 copy] autorelease], nil]];
	[self addRowWithCells:[NSArray arrayWithObjects:[[cell1 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell2 copy] autorelease], [[cell3 copy] autorelease], nil]];
	
	[cell1 release];
	[cell2 release];
	[cell3 release];
	
	[cell release];

	[self setCellSize:NSMakeSize(22,14)];
	[self setIntercellSpacing:NSMakeSize(0,2)];

	return self;
}

- (void)setTarget:(id)target {
	int i, j;
	for (i = 0; i < [self numberOfRows]; i++)
	{
		for (j = 0; j < [self numberOfColumns]; j++)
		{
			[[self cellAtRow:i column:j] setTarget:target];
		}
	}
}

- (void)setAction:(SEL)action {
	int i, j;
	for (i = 0; i < [self numberOfRows]; i++)
	{
		for (j = 0; j < [self numberOfColumns]; j++)
		{
			[[self cellAtRow:i column:j] setAction:action];
		}
	}
}

- (void)setEnabled:(BOOL)flag {
	if (flag == [self isEnabled]) return;
	if (flag)
	{
		int counter;
		for (counter = 0; counter < 7; counter++)
		{
			int c2;
			for (c2 = 0; c2 < 7; c2++)
			{
				NSTextFieldCell *cell = [self cellAtRow:counter column:c2];
				//[cell setTextColor:[NSColor controlTextColor]];
				[cell setEnabled:flag];
			}
		}
	} else {
		int counter;
		for (counter = 0; counter < 7; counter++)
		{
			int c2;
			for (c2 = 0; c2 < 7; c2++)
			{
				NSTextFieldCell *cell = [self cellAtRow:counter column:c2];
//				[cell setTextColor:[NSColor colorWithCalibratedWhite:0.8 alpha:1]];
				[cell setEnabled:flag];
			}
		}
	}
	[super setEnabled:flag];
	#warning selected cell color doesn't change properly and the below tries to fix it, but doesn't
	[self setNeedsDisplay:YES];
}

- (void)applyDate:(NSCalendarDate *)date {
	[self setObjectValue:date];
	NSCalendarDate *compare = [NSCalendarDate dateWithYear:[date yearOfCommonEra] month:[date monthOfYear] day:1 hour:[date hourOfDay] minute:[date minuteOfHour] second:[date secondOfMinute] timeZone:[date timeZone]];
	int start = [compare dayOfWeek];
	if ((compare = [NSCalendarDate dateWithYear:[date yearOfCommonEra] month:[date monthOfYear] day:31 hour:[date hourOfDay] minute:[date minuteOfHour] second:[date secondOfMinute] timeZone:[date timeZone]])
		&& [compare monthOfYear] == [date monthOfYear])
	{
		[self numberCellTo:31 startingWith:start];
	} else if ((compare = [NSCalendarDate dateWithYear:[date yearOfCommonEra] month:[date monthOfYear] day:30 hour:[date hourOfDay] minute:[date minuteOfHour] second:[date secondOfMinute] timeZone:[date timeZone]])
		&& [compare monthOfYear] == [date monthOfYear])
	{
		[self numberCellTo:30 startingWith:start];
	} else if ((compare = [NSCalendarDate dateWithYear:[date yearOfCommonEra] month:[date monthOfYear] day:29 hour:[date hourOfDay] minute:[date minuteOfHour] second:[date secondOfMinute] timeZone:[date timeZone]])
		&& [compare monthOfYear] == [date monthOfYear])
	{
		[self numberCellTo:29 startingWith:start];
	} else if ((compare = [NSCalendarDate dateWithYear:[date yearOfCommonEra] month:[date monthOfYear] day:28 hour:[date hourOfDay] minute:[date minuteOfHour] second:[date secondOfMinute] timeZone:[date timeZone]])
		&& [compare monthOfYear] == [date monthOfYear])
	{
		[self numberCellTo:28 startingWith:start];
	}
	[self selectDay:[date dayOfMonth]];
}

- (void)numberCellTo:(int)max startingWith:(int)displacement {
	displacement = displacement % 7; // make sure displacement is between 0 and 6
	int counter;
	for (counter = 0; counter < displacement; counter++)
	{
		NSCell *cell = [self cellAtRow:1 column:counter];
		
		[cell setTitle:@""];
		[cell setTag:-1];
		[cell setEnabled:NO];
		//[cell setBackgroundColor:[NSColor blackColor]];
	}
	for (counter = 0; counter < max; counter++)
	{
		NSCell *cell = [self cellAtRow:1 + (counter+displacement)/[self numberOfColumns] column:(counter+displacement)%[self numberOfColumns]];
		[cell setTitle:[NSString stringWithFormat:@"%i", counter+1]];
		[cell setTag:counter+1];
		[cell setEnabled:YES];
		//[cell setBackgroundColor:[NSColor whiteColor]];
	}
	for (; counter < [self numberOfColumns] * [self numberOfRows] + displacement; counter++)
	{
		NSCell *cell = [self cellAtRow:1 + (counter+displacement)/[self numberOfColumns] column:(counter+displacement)%[self numberOfColumns]];
		[cell setTitle:@""];
		[cell setTag:-1];
		[cell setEnabled:NO];
		//[cell setBackgroundColor:[NSColor blackColor]];
	}
	
}

- (void)mouseDown:(NSEvent *)theEvent {
	if ([self isEnabled])
	{
		[[self selectedCell] setOvalColor:[NSColor colorWithCalibratedWhite:0.9 alpha:1]];
		[super mouseDown:theEvent];
//  	[(WYCalendarView *)[self superview] setDay:[[self selectedCell] tag]];
		[[self selectedCell] setOvalColor:[NSColor colorWithCalibratedRed:.5781 green:.6367 blue:9257 alpha:1]];
//		[[self superview] setNeedsDisplay:YES];
		
//		id date = [self objectValue];
//		NSLog(@"mouse down %@", [date description]);
//		[self setObjectValue:[NSCalendarDate dateWithYear:[date yearOfCommonEra] month:[date monthOfYear] day:[[self selectedCell] tag] hour:[date hourOfDay] minute:[date minuteOfHour] second:[date secondOfMinute] timeZone:[date timeZone]]];
	}
}

- (void)selectDay:(int)day {
	if ([self selectedCell])
	{
		[[self selectedCell] setOvalColor:[NSColor colorWithCalibratedWhite:0.9 alpha:1]];
	}
	[self selectCellWithTag:day];
	if ([self isEnabled])
	{
		[[self cellWithTag:day] setOvalColor:[NSColor colorWithCalibratedRed:.5781 green:.6367 blue:9257 alpha:1]];
	} else {
		[[self cellWithTag:day] setOvalColor:[NSColor colorWithCalibratedRed:.7281 green:.7967 blue:9757 alpha:1]];
	}
}

@end
