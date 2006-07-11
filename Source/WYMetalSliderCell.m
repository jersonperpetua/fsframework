//
//  WYMetalSliderCell.m
//  Senuti
//
//  Created by Whitney Young on 3/17/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "WYMetalSliderCell.h"


@implementation WYMetalSliderCell

- (void)drawKnob:(NSRect)knobRect {
	knobRect.origin.y = 1;
	float percent = ([[(NSSlider *)[self controlView] objectValue] floatValue] / ([(NSSlider *)[self controlView] maxValue] - [(NSSlider *)[self controlView] minValue]));
	knobRect.origin.x += (knobRect.size.width - 12) * percent;
	knobRect.size.width= 12;
	knobRect.size.height= 12;

	NSBezierPath *path;

	// draw top
	[[NSColor colorWithCalibratedWhite:.45 alpha:1] set];
	path = [NSBezierPath bezierPath];
	[path moveToPoint:NSMakePoint(knobRect.origin.x, knobRect.origin.y + knobRect.size.height/2)];
	[path relativeCurveToPoint:NSMakePoint(6, -6)
		controlPoint1:NSMakePoint(0, -6)
		controlPoint2:NSMakePoint(6, -6)];
	[path relativeCurveToPoint:NSMakePoint(6, 6)
		controlPoint1:NSMakePoint(6, 0)
		controlPoint2:NSMakePoint(6, 6)];
	[path closePath];
	[path fill];
	
	// continue drawing top
	[[NSColor colorWithCalibratedWhite:.95 alpha:1] set];
	path = [NSBezierPath bezierPath];
	[path moveToPoint:NSMakePoint(knobRect.origin.x + 1, knobRect.origin.y + knobRect.size.height/2)];
	[path relativeCurveToPoint:NSMakePoint(5, -5)
		controlPoint1:NSMakePoint(0, -5)
		controlPoint2:NSMakePoint(5, -5)];
	[path relativeCurveToPoint:NSMakePoint(5, 5)
		controlPoint1:NSMakePoint(5, 0)
		controlPoint2:NSMakePoint(5, 5)];
	[path closePath];
	[path fill];

	// continue drawing top
	[[NSColor colorWithCalibratedWhite:.4 alpha:1] set];
	path = [NSBezierPath bezierPath];
	[path moveToPoint:NSMakePoint(knobRect.origin.x + 4, knobRect.origin.y + knobRect.size.height/2)];
	[path relativeCurveToPoint:NSMakePoint(2, -2)
		controlPoint1:NSMakePoint(0, -2)
		controlPoint2:NSMakePoint(2, -2)];
	[path relativeCurveToPoint:NSMakePoint(2, 2)
		controlPoint1:NSMakePoint(2, 0)
		controlPoint2:NSMakePoint(2, 2)];
	[path closePath];
	[path fill];

	// draw bottom
	[[NSColor colorWithCalibratedWhite:.45 alpha:1] set];
	path = [NSBezierPath bezierPath];
	[path moveToPoint:NSMakePoint(knobRect.origin.x, knobRect.origin.y + knobRect.size.height/2)];
	[path relativeCurveToPoint:NSMakePoint(6, 6)
		controlPoint1:NSMakePoint(0, 6)
		controlPoint2:NSMakePoint(6, 6)];
	[path relativeCurveToPoint:NSMakePoint(6, -6)
		controlPoint1:NSMakePoint(6, 0)
		controlPoint2:NSMakePoint(6, -6)];
	[path closePath];
	[path fill];
	
	// continue drawing bottom
	[[NSColor colorWithCalibratedWhite:.90 alpha:1] set];
	path = [NSBezierPath bezierPath];
	[path moveToPoint:NSMakePoint(knobRect.origin.x + 1, knobRect.origin.y + knobRect.size.height/2)];
	[path relativeCurveToPoint:NSMakePoint(5, 5)
		controlPoint1:NSMakePoint(0, 5)
		controlPoint2:NSMakePoint(5, 5)];
	[path relativeCurveToPoint:NSMakePoint(5, -5)
		controlPoint1:NSMakePoint(5, 0)
		controlPoint2:NSMakePoint(5, -5)];
	[path closePath];
	[path fill];
	
	// continue drawing bottom
	[[NSColor colorWithCalibratedWhite:.80 alpha:1] set];
	path = [NSBezierPath bezierPath];
	[path moveToPoint:NSMakePoint(knobRect.origin.x + 2, knobRect.origin.y + knobRect.size.height/2)];
	[path relativeCurveToPoint:NSMakePoint(4, 4)
		controlPoint1:NSMakePoint(0, 4)
		controlPoint2:NSMakePoint(4, 4)];
	[path relativeCurveToPoint:NSMakePoint(4, -4)
		controlPoint1:NSMakePoint(4, 0)
		controlPoint2:NSMakePoint(4, -4)];
	[path closePath];
	[path fill];
	
	// continue drawing bottom
	[[NSColor colorWithCalibratedWhite:.75 alpha:1] set];
	path = [NSBezierPath bezierPath];
	[path moveToPoint:NSMakePoint(knobRect.origin.x + 3, knobRect.origin.y + knobRect.size.height/2)];
	[path relativeCurveToPoint:NSMakePoint(3, 3)
		controlPoint1:NSMakePoint(0, 3)
		controlPoint2:NSMakePoint(3, 3)];
	[path relativeCurveToPoint:NSMakePoint(3, -3)
		controlPoint1:NSMakePoint(3, 0)
		controlPoint2:NSMakePoint(3, -3)];
	[path closePath];
	[path fill];

	// continue drawing bottom
	[[NSColor colorWithCalibratedWhite:.3 alpha:1] set];
	path = [NSBezierPath bezierPath];
	[path moveToPoint:NSMakePoint(knobRect.origin.x + 4, knobRect.origin.y + knobRect.size.height/2)];
	[path relativeCurveToPoint:NSMakePoint(2, 2)
		controlPoint1:NSMakePoint(0, 2)
		controlPoint2:NSMakePoint(2, 2)];
	[path relativeCurveToPoint:NSMakePoint(2, -2)
		controlPoint1:NSMakePoint(2, 0)
		controlPoint2:NSMakePoint(2, -2)];
	[path closePath];
	[path fill];
}

@end
