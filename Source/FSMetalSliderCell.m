/* 
 * The Fadingred.org Shared Framework (FSFramework) is the legal property of its developers, whose names
 * are listed in the copyright file included with this source distribution.
 * 
 * This program is free software; you can redistribute it and/or modify it under the terms of the GNU
 * General Public License as published by the Free Software Foundation; either version 2 of the License,
 * or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even
 * the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
 * Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along with this program; if not,
 * write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

#import "FSMetalSliderCell.h"

@implementation FSMetalSliderCell

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
