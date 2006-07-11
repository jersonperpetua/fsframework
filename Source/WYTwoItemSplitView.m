//
//  WYTwoItemSplitView.m
//  Temp
//
//  Created by Whitney Young on 8/18/05.
//  Copysecond 2005 __MyCompanyName__. All seconds reserved.
//

#import "WYTwoItemSplitView.h"

@interface WYTwoItemSplitView (PRIVATE)

- (void)updateToSavedFrameIfNeeded;

- (void)addObservers;
- (void)removeObservers;

- (void)firstFrameChange:(NSNotification *)notification;
- (void)secondFrameChange:(NSNotification *)notification;

@end


@implementation WYTwoItemSplitView

- (id)initWithFrame:(NSRect)rect {
	return [self initWithFrame:rect firstWidth:200];
}

- (id)initWithFrame:(NSRect)rect firstWidth:(float)width {
	if (self = [super initWithFrame:rect]) {
		
		first = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, width, rect.size.height)];
		second = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, rect.size.width - width, rect.size.height)];
		
		[self setVertical:TRUE];
						
		[self addSubview:first];
		[self addSubview:second];
		
		[self setDelegate:self];
		
		[self addObservers];
		
		firstViewMin = -1;
		secondViewMin = -1;
		
		firstViewMax = -1;
		secondViewMax = -1;
				
		return self;
	} else {
		return nil;
	}
}

- (void)dealloc {
	[self removeObservers];
	
	[first release];
	[second release];
	
	[autosaveName release];
	
	[super dealloc];
}

- (void)addObservers {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstFrameChange:) name:NSViewFrameDidChangeNotification object:first];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(secondFrameChange:) name:NSViewFrameDidChangeNotification object:second];
}

- (void)removeObservers {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSViewFrameDidChangeNotification object:first];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSViewFrameDidChangeNotification object:second];
}

- (void)setFrameAutosaveName:(NSString *)name {
	if (autosaveName != name) {
		
		[autosaveName release];
		autosaveName = [name retain];
		
		[self removeObservers];
		[self updateToSavedFrameIfNeeded];
		[self addObservers];
	}
}

- (NSString *)frameAutosaveName {
	return autosaveName;
}

- (void)updateToSavedFrameIfNeeded {
	if ([self frameAutosaveName]) {
		
		NSString *name = [@"WYTwoItemSplitView Frame " stringByAppendingString:[self frameAutosaveName]];
		NSDictionary * saveDict = [[NSUserDefaults standardUserDefaults] objectForKey:name];

		if (saveDict) {
			float num;
			num = [[saveDict objectForKey:@"Size"] floatValue];
			if (num) {
				[second removeFromSuperviewWithoutNeedingDisplay];
				[first removeFromSuperviewWithoutNeedingDisplay];
				if ([self isVertical]) {
					[first setFrameSize:NSMakeSize(num, [first frame].size.height)];
					[second setFrameSize:NSMakeSize([self frame].size.width - [self dividerThickness] - num, [second frame].size.height)];
				} else {
					[first setFrameSize:NSMakeSize([first frame].size.width, num)];
					[second setFrameSize:NSMakeSize([second frame].size.width, [self frame].size.height - [self dividerThickness] - num)];
				}
				[self addSubview:first];
				[self addSubview:second];
			}
			
			[self setFirstViewHidden:[[saveDict objectForKey:@"First Hidden"] boolValue]];
			[self setSecondViewHidden:[[saveDict objectForKey:@"Second Hidden"] boolValue]];
		} else {
			
			float save;
			NSString *name = [@"WYTwoItemSplitView Frame " stringByAppendingString:[self frameAutosaveName]];
			NSMutableDictionary * saveDict = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:name]];
			
			if ([self isVertical]) {
				if ([[self subviews] containsObject:second]) { save = [first frame].size.width; }
				else { save = [self frame].size.width - [self dividerThickness] - [second frame].size.width; }
			} else {
				if ([[self subviews] containsObject:second]) { save = [first frame].size.height; }
				else { save = [self frame].size.height - [self dividerThickness] - [second frame].size.height; }
			}
				
			[saveDict setObject:[NSNumber numberWithFloat:save] forKey:@"Size"];
			
			[saveDict setObject:[NSNumber numberWithBool:[self firstViewHidden]] forKey:@"First Hidden"];
			[saveDict setObject:[NSNumber numberWithBool:[self secondViewHidden]] forKey:@"Second Hidden"];
				
			[[NSUserDefaults standardUserDefaults] setObject:saveDict forKey:name];
			[saveDict release];
		}
	}
}

- (void)firstFrameChange:(NSNotification *)notification {
	if ([self frameAutosaveName] && [[self subviews] containsObject:second]) {
		float save;
		NSString *name = [@"WYTwoItemSplitView Frame " stringByAppendingString:[self frameAutosaveName]];
		NSMutableDictionary * saveDict = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:name]];
		if ([self isVertical]) {			
			if ([[self subviews] containsObject:second]) { save = [first frame].size.width; }
			else { save = [self frame].size.width - [self dividerThickness] - [second frame].size.width; }
		} else {
			if ([[self subviews] containsObject:second]) { save = [first frame].size.height; }
			else { save = [self frame].size.height - [self dividerThickness] - [second frame].size.height; }
		}
		[saveDict setObject:[NSNumber numberWithFloat:save] forKey:@"Size"];
		[[NSUserDefaults standardUserDefaults] setObject:saveDict forKey:name];
		[saveDict release];
	}
}
- (void)secondFrameChange:(NSNotification *)notification {
}

- (void)setFirstView:(NSView *)view {
	if (view != first) {
		
		[[NSNotificationCenter defaultCenter] removeObserver:self name:NSViewFrameDidChangeNotification object:first];
		
		[view setFrame:[first frame]];
		[self replaceSubview:first with:view];
		
		[first release];
		first = [view retain];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstFrameChange:) name:NSViewFrameDidChangeNotification object:first];
	}
}

- (void)setSecondView:(NSView *)view {
	if (view != second) {
		
		[[NSNotificationCenter defaultCenter] removeObserver:self name:NSViewFrameDidChangeNotification object:second];
		
		[view setFrame:[second frame]];
		[self replaceSubview:second with:view];
		
		[second release];
		second = [view retain];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(secondFrameChange:) name:NSViewFrameDidChangeNotification object:second];
	}
}


- (BOOL)firstViewHidden {
	return ![[self subviews] containsObject:first];
}
- (BOOL)secondViewHidden {
	return ![[self subviews] containsObject:second];
}

- (void)setFirstViewHidden:(BOOL)flag; {
	if (flag && ![self firstViewHidden]) {
		[first removeFromSuperview];
		[second setFrameSize:NSMakeSize([self frame].size.width, [second frame].size.height)];
		[self addSubview:second];
	} else if (!flag && [self firstViewHidden]) {
		if ([self isVertical]) {
			[second setFrameSize:NSMakeSize([self frame].size.width - [self dividerThickness] - [first frame].size.width, [self frame].size.height)];
		} else {
			[second setFrameSize:NSMakeSize([self frame].size.width, [self frame].size.height - [self dividerThickness] - [first frame].size.height)];
		}
		[self addSubview:first];
	}
	
	if ([self frameAutosaveName]) {
		NSString *name = [@"WYTwoItemSplitView Frame " stringByAppendingString:[self frameAutosaveName]];
		NSMutableDictionary * saveDict = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:name]];
		[saveDict setObject:[NSNumber numberWithBool:flag] forKey:@"First Hidden"];
		[[NSUserDefaults standardUserDefaults] setObject:saveDict forKey:name];
		[saveDict release];
	}
}

- (void)setSecondViewHidden:(BOOL)flag; {
	if (flag && ![self secondViewHidden]) {
		[second removeFromSuperview];
		[first setFrameSize:NSMakeSize([self frame].size.width, [first frame].size.height)];
		[self addSubview:first];
	} else if (!flag && [self secondViewHidden]) {
		if ([self isVertical]) {
			[first setFrameSize:NSMakeSize([self frame].size.width - [self dividerThickness] - [second frame].size.width, [self frame].size.height)];
		} else {
			[first setFrameSize:NSMakeSize([self frame].size.width, [self frame].size.height - [self dividerThickness] - [second frame].size.height)];
		}
		[self addSubview:second];
	}
	
	if ([self frameAutosaveName]) {
		NSString *name = [@"WYTwoItemSplitView Frame " stringByAppendingString:[self frameAutosaveName]];
		NSMutableDictionary * saveDict = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:name]];
		[saveDict setObject:[NSNumber numberWithBool:flag] forKey:@"Second Hidden"];
		[[NSUserDefaults standardUserDefaults] setObject:saveDict forKey:name];
		[saveDict release];
	}
}

- (void)setFirstViewMin:(int)min max:(int)max {
 	firstViewMin = min;
 	firstViewMax = max;
	
 	secondViewMin = -1;
 	secondViewMax = -1;
}
- (void)setSecondViewMin:(int)min max:(int)max {
 	secondViewMin = min;
 	secondViewMax = max;
	
 	firstViewMin = -1;
 	firstViewMax = -1;
}

- (float)splitView:(NSSplitView *)sender constrainMinCoordinate:(float)proposedCoord ofSubviewAt:(int)offset {
	if (sender == self && offset == 0) {
		if (firstViewMin != -1) { return firstViewMin; }
		else if (secondViewMax != -1 && [self isVertical]) { return [self frame].size.width - [self dividerThickness] - secondViewMax; }
		else if (secondViewMax != -1) { return [self frame].size.height - [self dividerThickness] - secondViewMax; }
		else { return proposedCoord; }
	}
	return proposedCoord;
}

- (float)splitView:(NSSplitView *)sender constrainMaxCoordinate:(float)proposedCoord ofSubviewAt:(int)offset {
	if (sender == self && offset == 0) {
		if (firstViewMax != -1) { return firstViewMax; }
		else if (secondViewMin != -1 && [self isVertical]) { return [self frame].size.width - [self dividerThickness] - secondViewMin; }
		else if (secondViewMin != -1) { return [self frame].size.height - [self dividerThickness] - secondViewMin; }
		else { return proposedCoord; }
	}
	return proposedCoord;
}

- (void)splitView:(NSSplitView *)sender resizeSubviewsWithOldSize:(NSSize)oldSize {
	
	// the coordinate system is (0, 0) in the first corner
	
	if (sender == self) {
		if ((firstViewMax != -1 || firstViewMin != -1) && (![self firstViewHidden] && ![self secondViewHidden])) {
			// the first is constrained with a min/max
			// resize the second view
			
			if ([self isVertical]) {
				
				NSRect rect;
				
				float width = [first frame].size.width;
				if (width > firstViewMax) { width = firstViewMax; }
				else if (width < firstViewMin) { width = firstViewMin; }
				
				rect.origin.x = 0;
				rect.origin.y = 0;
				rect.size = [self frame].size;
				rect.size.width = width;
				[first setFrame:rect];
				
				rect.origin.x = width + [self dividerThickness];
				rect.origin.y = 0;
				rect.size = [self frame].size;
				rect.size.width = rect.size.width - width - [self dividerThickness];
				[second setFrame:rect];

			} else {
				
				NSRect rect;
				
				float height = [first frame].size.height;
				if (height > firstViewMax) { height = firstViewMax; }
				else if (height < firstViewMin) { height = firstViewMin; }
				
				rect.origin.x = 0;
				rect.origin.y = 0;
				rect.size = [self frame].size;
				rect.size.height = height;
				[first setFrame:rect];
				
				rect.origin.x = 0;
				rect.origin.y = height + [self dividerThickness];
				rect.size = [self frame].size;
				rect.size.height = rect.size.height - height - [self dividerThickness];
				[second setFrame:rect];

			}

		} else if ((secondViewMax != -1 || secondViewMin != -1) && (![self firstViewHidden] && ![self secondViewHidden])) {
			// the second is constrained with a min/max
			// resize the first view
			
			if ([self isVertical]) {
			
				NSRect rect;
				
				float width = [second frame].size.width;
				if (width > secondViewMax) { width = secondViewMax; }
				else if (width < secondViewMin) { width = secondViewMin; }
				
				rect.origin.x = [self frame].size.width - width;
				rect.origin.y = 0;
				rect.size = [self frame].size;
				rect.size.width = width;
				[second setFrame:rect];
				
				rect.origin.x = 0;
				rect.origin.y = 0;
				rect.size = [self frame].size;
				rect.size.width = rect.size.width - [self dividerThickness] - width;
				[first setFrame:rect];
				
			} else {
				
				//NSRect rect;
//				
//				float height = [second frame].size.height;
//				if (height > secondViewMax) { height = secondViewMax; }
//				else if (height < secondViewMin) { height = secondViewMin; }
//				
//				rect.origin.x = 0;
//				rect.origin.y = [self frame].size.height - height;
//				rect.size = [self frame].size;
//				rect.size.height = height;
//				[second setFrame:rect];
//				
//				rect.origin.x = 0;
//				rect.origin.y = 0;
//				rect.size = [self frame].size;
//				rect.size.height = rect.size.height - [self dividerThickness] - height;
//				[first setFrame:rect];
				
				
				NSRect rect;
				
				float height = [second frame].size.height;
				if (height > secondViewMax) { height = secondViewMax; }
				else if (height < secondViewMin) { height = secondViewMin; }
				
				rect.origin.x = 0;
				rect.origin.y = [self frame].size.height - height;
				rect.size = [self frame].size;
				rect.size.height = height;
				[second setFrame:rect];
				
				rect.origin.x = 0;
				rect.origin.y = 0;
				rect.size = [self frame].size;
				rect.size.height = rect.size.height - [self dividerThickness] - height;
				[first setFrame:rect];
				
			}

		} else {
			[sender adjustSubviews];
		}
	} else {
		[sender adjustSubviews];
	}
}

@end