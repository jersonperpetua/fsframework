//
//  WYSimpleActionCell.m
//  Temp
//
//  Created by Whitney Young on 8/20/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "WYNeverEnabledActionCell.h"


@implementation WYNeverEnabledActionCell
//
//- (id)target {
//	return target;
//}
//- (void)setTarget:(id)anObject {
//	if (target != anObject) {
//		[target release];
//		target = [anObject retain];
//	}
//}
//- (SEL)action {
//	return action;
//}
//- (void)setAction:(SEL)aSelector {
//	action = aSelector;
//}
//
//- (id)objectValue {
//	return val;
//}
//- (void)setObjectValue:(id)obj {
//	if (obj != val) {
//		[val release];
//		val = [obj retain];
//	}
//}

- (BOOL)isEnabled {
	return NO;
}


@end
