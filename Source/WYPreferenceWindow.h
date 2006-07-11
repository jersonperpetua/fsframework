/*
Copyright (C) 2004-2005  Whitney Young

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

/* WYPreferenceWindow */

#import <Cocoa/Cocoa.h>
#import "WYPreferenceView.h"

@interface WYPreferenceWindow : NSWindow {
	NSToolbar *toolbar;
//	NSMutableArray *labels;
//	NSMutableArray *images;
	NSMutableArray *views;
//	NSMutableArray *loaded_views;
	NSString *title;
	NSString *autosave_name;
	NSString *selected;
}

- (id)initWithContentRect:(NSRect)contentRect styleMask:(unsigned int)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag;

- (void)addView:(NSView <WYPreferenceView> *)view;// label:(NSString *)label image:(NSImage *)image;

- (void)setTitle:(NSString *)new_title;
- (NSTimeInterval)animationResizeTime:(NSRect)newFrame;
- (void)setAutosaveName:(NSString *)name; // saves window frame and selected toolbar item identifier, but not labels, views and images.
                                          // those must be reinstalled (and the same way so that saved item can be reselected).
                                          // call after installing all views in order for saved view to be selected properly.

@end
