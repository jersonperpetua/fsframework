//
//  WYMetalBorderHeaderView.m
//  WYAppFramework
//
//  Created by Whitney Young on 8/23/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "WYMetalBorderHeaderView.h"
#import "WYMetalBorderHeaderCell.h"

@implementation WYMetalBorderHeaderView

+ (Class)cellClass {
	return [WYMetalBorderHeaderCell class]; 
}

@end
