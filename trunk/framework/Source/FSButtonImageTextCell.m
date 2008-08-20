/* 
 * The FadingRed Shared Framework (FSFramework) is the legal property of its developers, whose names
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

#import "FSButtonImageTextCell.h"

#define MAX_IMAGE_WIDTH			24.0f
#define IMAGE_TEXT_PADDING		6.0f

typedef enum _FSButtonImageTextCellState {
	FSButtonImageTextCellInactiveState,
	FSButtonImageTextCellHoverState,
	FSButtonImageTextCellPressedState
} FSButtonImageTextCellState;

@interface FSButtonImageTextCell (PRIVATE)
- (NSRect)buttonRectForFrame:(NSRect)cellFrame;
@end

@implementation FSButtonImageTextCell

- (id)copyWithZone:(NSZone *)zone
{
	FSButtonImageTextCell *newCell = [super copyWithZone:zone];
	
	newCell->buttonImage = nil;
	[newCell setButtonImage:buttonImage];
	
	newCell->target = nil;
	[newCell setTarget:target];
	
	newCell->action = action;
	newCell->mouseLocation = mouseLocation;
	newCell->state = state;
	
	return newCell;
}

- (void)dealloc {
	[buttonImage release];
	[target release];
	[super dealloc];
}


#pragma mark responding to update messages from the table view
// ----------------------------------------------------------------------------------------------------
// responding to update messages from the table view
// ----------------------------------------------------------------------------------------------------

- (BOOL)mouseExitedInvalidatesForFrame:(NSRect)cellFrame {
	if (buttonImage && state != FSButtonImageTextCellInactiveState) {
		state = FSButtonImageTextCellInactiveState;
		return TRUE;
	}
	return FALSE;
}

- (BOOL)mouseMoveToPoint:(NSPoint)point invalidatesForFrame:(NSRect)cellFrame {
	if (buttonImage) {
		FSButtonImageTextCellState origState = state;
		if (NSPointInRect(point, [self buttonRectForFrame:cellFrame])) { state = FSButtonImageTextCellHoverState; }
		else { state = FSButtonImageTextCellInactiveState; }
		mouseLocation = point;
		return state != origState;
	}
	return FALSE;
}

- (BOOL)mouseUpAtPoint:(NSPoint)point invalidatesForFrame:(NSRect)cellFrame {
	if (NSPointInRect(point, [self buttonRectForFrame:cellFrame])) {
		state = FSButtonImageTextCellHoverState;
		// if point inside, call the action
		[target performSelector:action withObject:self];
	} else {
		state = FSButtonImageTextCellInactiveState;
	}
	mouseLocation = point;
	return TRUE;
}

- (BOOL)trackMouseAtPoint:(NSPoint)point invalidatesForFrame:(NSRect)cellFrame redraw:(BOOL*)redraw {
	// if point inside, track
	if (buttonImage && NSPointInRect(point, [self buttonRectForFrame:cellFrame])) {
		state = FSButtonImageTextCellPressedState;
		mouseLocation = point;
		*redraw = TRUE;
		return TRUE;
	}
	return FALSE;
}

- (BOOL)continueTrackingMouseAtPoint:(NSPoint)point invalidatesForFrame:(NSRect)cellFrame redraw:(BOOL*)redraw {
	FSButtonImageTextCellState origState = state;
	if (NSPointInRect(point, [self buttonRectForFrame:cellFrame])) { state = FSButtonImageTextCellPressedState; }
	else { state = FSButtonImageTextCellHoverState; }
	mouseLocation = point;
	*redraw = state != origState;
	return TRUE;
}


#pragma mark properties
// ----------------------------------------------------------------------------------------------------
// properties
// ----------------------------------------------------------------------------------------------------

- (NSImage *)buttonImage {
	return buttonImage;
}

- (void)setButtonImage:(NSImage *)image {
	if (image != buttonImage) {
		[buttonImage release];
		buttonImage = [image retain];
	}
}

- (id)target {
	return target;
}

- (void)setTarget:(id)tar {
	if (tar != target) {
		[target release];
		target = [tar retain];
	}
}

- (SEL)action {
	return action;
}

- (void)setAction:(SEL)act {
	action = act;
}


#pragma mark drawing
// ----------------------------------------------------------------------------------------------------
// drawing
// ----------------------------------------------------------------------------------------------------

- (NSRect)buttonRectForFrame:(NSRect)cellFrame {
	NSRect dest;
	dest.size = [buttonImage size];
	dest.origin = cellFrame.origin;
		
	// Center image vertically, or scale as needed
	if (dest.size.height > cellFrame.size.height) {
		float proportionChange = cellFrame.size.height / [buttonImage size].height;
		dest.size.height = cellFrame.size.height;
		dest.size.width = [buttonImage size].width * proportionChange;
	}
	
	if (dest.size.width > MAX_IMAGE_WIDTH) {
		float proportionChange = MAX_IMAGE_WIDTH / dest.size.width;
		dest.size.width = MAX_IMAGE_WIDTH;
		dest.size.height = dest.size.height * proportionChange;
	}
	
	if (dest.size.height < cellFrame.size.height) {
		dest.origin.y += (cellFrame.size.height - dest.size.height) / 2.0;
	} 
	
	// Adjust the rects
	dest.origin.y += 1;
	dest.origin.x += cellFrame.size.width;
	dest.origin.x -= [buttonImage size].width;
	dest.origin.x -= IMAGE_TEXT_PADDING;
	return dest;
}


- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
	
	// Draw the cell's button image
	if (buttonImage != nil) {
		
		NSRect dest = [self buttonRectForFrame:cellFrame];
		
		// Decrease the cell width by the width of the image we drew and its left padding
		cellFrame.size.width -= IMAGE_TEXT_PADDING + dest.size.width;
				
		BOOL flippedIt = NO;
		if (![buttonImage isFlipped]) {
			[buttonImage setFlipped:YES];
			flippedIt = YES;
		}
		
		// update just in case some change was made in the view
		// that wasn't reflected via events
		if (!NSPointInRect(mouseLocation, dest)) { state = FSButtonImageTextCellInactiveState; }
		
		float fraction = 1.0;
		switch(state) {
			case FSButtonImageTextCellInactiveState: fraction = 0.5; break;
			case FSButtonImageTextCellHoverState: fraction = 0.75; break;
			case FSButtonImageTextCellPressedState: fraction = 1.0; break;
			default: break;
		}
		
		[NSGraphicsContext saveGraphicsState];
		[[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
		[buttonImage drawInRect:NSMakeRect(dest.origin.x,dest.origin.y,dest.size.width,dest.size.height)
				 fromRect:NSMakeRect(0,0,[buttonImage size].width,[buttonImage size].height)
				operation:NSCompositeSourceOver
				 fraction:fraction];
		[NSGraphicsContext restoreGraphicsState];
		
		if (flippedIt) {
			[buttonImage setFlipped:NO];
		}
	}
	
	// Draw the rest of the cell
	[super drawInteriorWithFrame:cellFrame inView:controlView];
}

@end
