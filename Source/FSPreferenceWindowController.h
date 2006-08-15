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

#import "FSWindowController.h"

@class FSViewController;
@protocol FSPreferenceViewControllerProtocol
- (NSString *)label;
- (NSImage *)image;
@end

@interface FSPreferenceWindowController : FSWindowController {
	NSToolbar *toolbar;
	NSMutableArray *views;
	NSString *title;
	NSString *autosaveName;
	NSString *selected;
}

// when creating your preferce window, you must be sure that it's large enough to fit the width of any of your views
// the height is not important as it will change, but the width must fit
- (void)addView:(FSViewController <FSPreferenceViewControllerProtocol> *)view;

- (void)setTitle:(NSString *)new_title; // set the title after adding the first view so that it displays right when the window is opened
- (void)setAutosaveName:(NSString *)name; // saves window frame and selected toolbar item identifier, but not labels, views and images.
										  // those must be reinstalled (and the same way so that saved item can be reselected).
										  // call after installing all views in order for saved view to be selected properly.

@end
