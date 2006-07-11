//
//  WYPreferenceView.h
//  WYAppFramework
//
//  Created by Whitney Young on 7/7/06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol WYPreferenceView

- (NSString *)label;
- (NSImage *)image;

- (BOOL)loaded;
- (void)load;

@end
