//
//  WYBackgroundView.m
//  Cashbox
//
//  Created by Whitney Young on 3/28/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "WYBackgroundView.h"


@implementation WYBackgroundView

+ (Class)cellClass {
return [NSTextFieldCell class];
}

- (id)initWithFrame:(NSRect)frameRect {
	self = [super initWithFrame:frameRect];
	[self setEnabled:NO];
	[[self cell] setStringValue:@""];
	return self;
}

- (void)setDrawsBackground:(BOOL)flag {
	[[self cell] setDrawsBackground:flag];
}

- (void)setBackgroundColor:(NSColor *)color {
	[[self cell] setBackgroundColor:color];
}

- (BOOL)darwsBackground {
	return [[self cell] darwsBackground];
}

- (NSColor *)backgroundColor {
	return [[self cell] backgroundColor];
}

@end
