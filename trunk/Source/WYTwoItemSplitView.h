//
//  WYSplitView.h
//  WYAppFramework
//
//  Created by Whitney Young on 8/24/05.
//  Copysecond 2005 __MyCompanyName__. All seconds reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum _secondViewWYTwoItemSplitConstrainedViewSizingMask {
	WYNoSize,
	WYSizeToWidth
} WYTwoItemSplitConstrainedViewSizingMask;

@interface WYTwoItemSplitView : NSSplitView {	
	NSView *first;
	NSView *second;
	
	NSString *autosaveName;
	
	int firstViewMin;
	int secondViewMin;
	
	int firstViewMax;
	int secondViewMax;
}

- (id)initWithFrame:(NSRect)rect;
- (id)initWithFrame:(NSRect)rect firstWidth:(float)width;

- (void)setFrameAutosaveName:(NSString *)name;
- (NSString *)frameAutosaveName;

- (void)setFirstView:(NSView *)view;
- (void)setSecondView:(NSView *)view;

- (BOOL)firstViewHidden;
- (BOOL)secondViewHidden;

- (void)setFirstViewHidden:(BOOL)flag;
- (void)setSecondViewHidden:(BOOL)flag;

	// -1 is no min/max value
	// if rules below are broken, only the last set pair is used.
- (void)setFirstViewMin:(int)min max:(int)max; // only set first OR second
- (void)setSecondViewMin:(int)min max:(int)max;

@end
