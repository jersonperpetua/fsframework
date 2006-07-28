//
//  WYArrayExtensions.m
//  WYAppFramework
//
//  Created by Whitney Young on 7/7/06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import "WYArrayExtensions.h"


@implementation NSArray (WYArrayExtensions)
- (NSArray *)arrayByPerformingSelectorOnObjects:(SEL)selector {
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
	unsigned int i;
	for (i = 0; i < [self count]; i++) {
		[array addObject:[[self objectAtIndex:i] performSelector:selector]];
	}
	return array;
}

- (NSArray *)arrayByPerformingSelectorWithObjects:(SEL)selector onTarget:(id)target {
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
	unsigned int i;
	for (i = 0; i < [self count]; i++) {
		[array addObject:[target performSelector:selector withObject:[self objectAtIndex:i]]];
	}
	return array;	
}
@end
