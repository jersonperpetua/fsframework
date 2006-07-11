//
//  WYOvalActionCell.h
//  Cashbox
//
//  Created by Whitney Young on 3/31/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface WYOvalActionCell : NSActionCell {
BOOL right_oval;
BOOL left_oval;
BOOL draws_oval;
NSColor *oval_color;
NSColor *border_color;
float border_width;
	BOOL constrain_text;
}

- (void)setDrawsOval:(BOOL)flag;
- (void)setDrawsLeftOval:(BOOL)flag;
- (void)setDrawsRightOval:(BOOL)flag;
- (void)setConstrainText:(BOOL)flag;

- (void)setOvalColor:(NSColor *)color;
- (void)setBorderColor:(NSColor *)color;
- (void)setBorderWidth:(float)width;

- (BOOL)drawsOval;
- (BOOL)drawsLeftOval;
- (BOOL)drawsRightOval;
- (BOOL)constrainText;

- (NSColor *)ovalColor;
- (NSColor *)borderColor;
- (float)borderWidth;

@end
