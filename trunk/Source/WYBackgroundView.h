//
//  WYBackgroundView.h
//  Cashbox
//
//  Created by Whitney Young on 3/28/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface WYBackgroundView : NSControl {

}

- (void)setDrawsBackground:(BOOL)flag;
- (void)setBackgroundColor:(NSColor *)color;
- (BOOL)darwsBackground;
- (NSColor *)backgroundColor;

@end
