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

// IMPORTANT: FSViewController does not handle releasing all top level objects
// like NSWindowController does.  It does handle releasing the view for you, but
// if your nib file contains any more top level objects, you must release them
// youself

@class FSControlledView;
@interface FSViewController : NSObject {
	IBOutlet FSControlledView *view;
}

- (id)init;
- (FSControlledView *)view; // load the nib (if not loaded) and show the view


// the following methods are for subclassers
// none of them should be called directly

- (void)viewWillLoad; // called before the view is loaded from the nib
- (void)viewDidLoad; // called after the view is loaded from the nib

// just before the view is released
- (void)viewWillClose;

// the following methods are not invoked when
// a view changes from one window to another
- (void)viewWillActivate; // called before a view is added to a window
- (void)viewDidActivate; // called after a view is added to a window

- (void)viewWillInactivate; // called before a view is removed from a window
- (void)viewDidInactivate; // called after a view is removed from a window

@end

@protocol FSViewControllerProtocol
+ (NSString *)nibName;
@end
