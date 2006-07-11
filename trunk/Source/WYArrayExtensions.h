//
//  WYArrayExtensions.h
//  WYAppFramework
//
//  Created by Whitney Young on 7/7/06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSArray (WYArrayExtensions)
- (NSArray *)arrayByPerformingSelectorOnObjects:(SEL)selector;
- (NSArray *)arrayByPerformingSelectorWithObjects:(SEL)selector onTarget:(id)target;
@end
