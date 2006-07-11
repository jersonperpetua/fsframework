//
//  WYScrollView.m
//  WYAppFramework
//
//  Created by Whitney Young on 8/23/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "WYScrollView.h"

@interface WYScrollView (PRIVATE)

- (void)frameChange:(NSNotification *)notification;

@end

@implementation WYScrollView



- (void)setAutoHidesVerticalScroller:(BOOL)flag {
	vert = flag;
}

- (void)setAutoHidesHorizontalScroller:(BOOL)flag {
	horiz = flag;
}

- (void)setDocumentView:(NSView *)view {
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSViewFrameDidChangeNotification object:[super documentView]];
	[super setDocumentView:view];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(frameChange:) name:NSViewFrameDidChangeNotification object:view];
	
}

- (void)frameChange:(NSNotification *)notification {
	if (horiz) {
		if ([[self documentView] frame].size.width > [self frame].size.width) {
			[self setHasHorizontalScroller:TRUE];
		} else {
			[self setHasHorizontalScroller:FALSE];
		}
	}
	if (vert) {
		if ([[self documentView] frame].size.height > [self frame].size.height) {
			[self setHasVerticalScroller:TRUE];
		} else {
			[self setHasVerticalScroller:FALSE];
		}
	}
}

@end
