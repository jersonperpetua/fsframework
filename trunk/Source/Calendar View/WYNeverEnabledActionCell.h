//
//  WYSimpleActionCell.h
//  Temp
//
//  Created by Whitney Young on 8/20/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface WYNeverEnabledActionCell : NSActionCell {
	id target;
	SEL action;
	id val;
}

@end
