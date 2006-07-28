//
//  WYTreeController.m
//  WYAppFramework
//
//  Created by Whitney Young on 6/28/06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import "WYTreeController.h"


@implementation WYTreeController


+ (void)initialize {
	[self exposeBinding:@"selectionIndexPaths"];
	[self exposeBinding:@"contentArrayForMultipleSelection"];
	[self exposeBinding:@"contentSet"];
	[self exposeBinding:@"contentArray"];
	[self exposeBinding:@"sortDescriptors"];
}

//
//- (id)initWithContent:(id)content {
//	NSLog(@"init");
//	return self = [super initWithContent:content];
//}

- (BOOL)isKindOfClass:(Class)aClass {
	NSLog(@"here");
	NSLog(@"is KindOfClass: %@", ((aClass == [NSTreeController class]) || [super isKindOfClass:aClass]) ? @"TRUE" : @"FALSE");
	return (aClass == [NSTreeController class]) || [super isKindOfClass:aClass];
}

- (BOOL)respondsToSelector:(SEL)selector {
	NSLog(@"calling respondsToSelector: with argument %@", NSStringFromSelector(selector));
	BOOL ret = [super respondsToSelector:selector];
	NSLog(@"finished calling respondsToSelector: with value: %@", (ret ? @"TRUE" : @"FALSE" ));
	return ret;
}

- (void)addObserver:(NSObject *)anObserver forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
	
	NSLog(@"calling addObserver");
	[super addObserver:anObserver forKeyPath:keyPath options:options context:context];
}

// triggers rearranging the content objects for the user interface, including sorting (and filtering if provided by subclasses); subclasses can invoke this method if any parameter that affects the arranged objects changes
- (void)rearrangeObjects {
	NSString *key = @"arrangedObjects";
	NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)];
	[self willChange:NSKeyValueChangeSetting valuesAtIndexes:set forKey:key];
//	[self willChangeValueForKey:@"arrangedObjects"];
	// do something
	NSLog(@"rearragne");
//	[self didChangeValueForKey:@"arrangedObjects"];
	[self didChange:NSKeyValueChangeSetting valuesAtIndexes:set forKey:key];
}

// opaque root node representation of all displayed objects. This is just for binding to or passing around. At this time, developers should not make any assumption about what methods this object responds to.
- (id)arrangedObjects {
	NSLog(@"getting objects");
//	return [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"hi", @"name", nil, nil],
//		[NSDictionary dictionaryWithObjectsAndKeys:@"two", @"name", nil, nil],
//		[NSDictionary dictionaryWithObjectsAndKeys:@"three", @"name", nil, nil], nil];
	return _arrangedObjects;
}

// key used to find the children of a model object.
- (void)setChildrenKeyPath:(NSString *)keyPath {
	if (_childrenKeyPath != keyPath) {
		[_childrenKeyPath release];
		_childrenKeyPath = [keyPath retain];
	}
}
- (NSString *)childrenKeyPath {
//	return @"hello there";
	return _childrenKeyPath;
}

// optional for performance
- (void)setCountKeyPath:(NSString *)keyPath {
	if (_countKeyPath != keyPath) {
		[_countKeyPath release];
		_countKeyPath = [keyPath retain];
	}	
}
- (NSString *)countKeyPath {
	return _countKeyPath;
}

// optional. inserting/adding children disabled for leaf nodes
- (void)setLeafKeyPath:(NSString *)keyPath {
	if (_leafKeyPath != keyPath) {
		[_leafKeyPath release];
		_leafKeyPath = [keyPath retain];
	}	
}
- (NSString *)leafKeyPath {
	return _leafKeyPath;
}

- (void)setSortDescriptors:(NSArray *)sortDescriptors {
	if (_sortDescriptors != sortDescriptors) {
		[_sortDescriptors release];
		_sortDescriptors = [sortDescriptors retain];		
	}
}

- (NSArray *)sortDescriptors {
	return _sortDescriptors;
}

- (id)content {
	return [super content];
}

- (void)setContent:(id)content {
	[super setContent:content];
}

// adds a new sibling node to the end of the selected objects
- (void)add:(id)sender {
	
}
//removes the currently selected objects from the tree
- (void)remove:(id)sender {
	
}
// adds a new child node to the end of the selected objects
- (void)addChild:(id)sender {
	
}

// inserts a peer in front of first selected node
- (void)insert:(id)sender {
	
}

// inserts a new first child into the children array of the first selected node
- (void)insertChild:(id)sender {
	
}

- (BOOL)canInsert {
	return NO;
}
- (BOOL)canInsertChild {
	return NO;
}
- (BOOL)canAddChild {
	return NO;
}

- (void)insertObject:(id)object atArrangedObjectIndexPath:(NSIndexPath *)indexPath {
	
}
- (void)insertObjects:(NSArray *)objects atArrangedObjectIndexPaths:(NSArray *)indexPaths {
	
}
- (void)removeObjectAtArrangedObjectIndexPath:(NSIndexPath *)indexPath {
	
}
- (void)removeObjectsAtArrangedObjectIndexPaths:(NSArray *)indexPaths {
	
}

	// functionality here is parallel to what is in array controller

// default: YES
- (void)setAvoidsEmptySelection:(BOOL)flags {
	_treeControllerFlags._avoidsEmptySelection = flags;
}	
- (BOOL)avoidsEmptySelection {
	return _treeControllerFlags._avoidsEmptySelection;
}

// default: YES
- (void)setPreservesSelection:(BOOL)flag {
	_treeControllerFlags._preservesSelection = flag;
}

// default: YES
- (BOOL)preservesSelection {
	return _treeControllerFlags._preservesSelection;
}

// default: YES
- (void)setSelectsInsertedObjects:(BOOL)flag {
	_treeControllerFlags._selectsInsertedObjects = flag;
}
- (BOOL)selectsInsertedObjects {
	return _treeControllerFlags._selectsInsertedObjects;
}

- (void)setAlwaysUsesMultipleValuesMarker:(BOOL)flag {
	_treeControllerFlags._alwaysUsesMultipleValuesMarker = flag;
}

- (BOOL)alwaysUsesMultipleValuesMarker {
	return _treeControllerFlags._alwaysUsesMultipleValuesMarker;

}

	/* All selection modification methods returning a BOOL indicate through that flag whether changing the selection was successful (changing the selection might trigger a commitEditing call which fails and thus deny's the selection change).
	*/
- (NSArray *)selectedObjects {
	return _selectedObjects;
}

- (BOOL)setSelectionIndexPaths:(NSArray *)indexPaths {
	return NO;
}
- (NSArray *)selectionIndexPaths {
	return NO;
}
- (BOOL)setSelectionIndexPath:(NSIndexPath *)indexPath {
	return NO;
}
- (NSIndexPath *)selectionIndexPath {
	return NO;
}
- (BOOL)addSelectionIndexPaths:(NSArray *)indexPaths {
	return NO;
}
- (BOOL)removeSelectionIndexPaths:(NSArray *)indexPaths {
	return NO;
}

/* NSObjectController */

//- (void)rearrangeObjects {
//	
//} // triggers rearranging the content objects for the user interface, including sorting (and filtering if provided by subclasses); subclasses can invoke this method if any parameter that affects the arranged objects changes
//
//- (id)arrangedObjects{
//	
//} // opaque root node representation of all displayed objects. This is just for binding to or passing around. At this time, developers should not make any assumption about what methods this object responds to.
//
//- (void)setChildrenKeyPath:(NSString *)keyPath {
//	
//} // key used to find the children of a model object.
//- (NSString *)childrenKeyPath {
//	
//}
//- (void)setCountKeyPath:(NSString *)keyPath {
//	
//} // optional for performance
//- (NSString *)countKeyPath {
//	
//}
//- (void)setLeafKeyPath:(NSString *)keyPath {
//	
//} // optional. inserting/adding children disabled for leaf nodes
//- (NSString *)leafKeyPath {
//	
//}
//
//- (void)setSortDescriptors:(NSArray *)sortDescriptors {
//	
//}
//- (NSArray *)sortDescriptors {
//	
//}

//- (id)content {
//	
//}
//- (void)setContent:(id)content {
//	
//}
//
//- (void)add:(id)sender {
//	
//}	// adds a new sibling node to the end of the selected objects
//- (void)remove:(id)sender {
//	
//} 	//removes the currently selected objects from the tree
//- (void)addChild:(id)sender {
//	
//}	// adds a new child node to the end of the selected objects
//- (void)insert:(id)sender {
//	
//}	// inserts a peer in front of first selected node
//- (void)insertChild:(id)sender {
//	
//}	// inserts a new first child into the children array of the first selected node
//
//- (BOOL)canInsert {
//	
//}
//- (BOOL)canInsertChild {
//	
//}
//- (BOOL)canAddChild {
//	
//}
//
//- (void)insertObject:(id)object atArrangedObjectIndexPath:(NSIndexPath *)indexPath {
//	
//}
//- (void)insertObjects:(NSArray *)objects atArrangedObjectIndexPaths:(NSArray *)indexPaths {
//	
//}
//- (void)removeObjectAtArrangedObjectIndexPath:(NSIndexPath *)indexPath {
//	
//}
//- (void)removeObjectsAtArrangedObjectIndexPaths:(NSArray *)indexPaths {
//	
//}
//
//	// functionality here is parallel to what is in array controller
//- (void)setAvoidsEmptySelection:(BOOL)flag {
//	
//}	// default: YES
//- (BOOL)avoidsEmptySelection {
//	
//}
//- (void)setPreservesSelection:(BOOL)flag {
//	
//}	// default: YES
//- (BOOL)preservesSelection {
//	
//}
//- (void)setSelectsInsertedObjects:(BOOL)flag {
//	
//}	// default: YES
//- (BOOL)selectsInsertedObjects {
//	
//}
//- (void)setAlwaysUsesMultipleValuesMarker:(BOOL)flag {
//	
//}
//- (BOOL)alwaysUsesMultipleValuesMarker {
//	
//}
//
//	/* All selection modification methods returning a BOOL indicate through that flag whether changing the selection was successful (changing the selection might trigger a commitEditing call which fails and thus deny's the selection change).
//	*/
//- (NSArray *)selectedObjects {
//	
//}
//
//- (BOOL)setSelectionIndexPaths:(NSArray *)indexPaths {
//	
//}
//- (NSArray *)selectionIndexPaths {
//	
//}
//- (BOOL)setSelectionIndexPath:(NSIndexPath *)indexPath {
//	
//}
//- (NSIndexPath *)selectionIndexPath {
//	
//}
//- (BOOL)addSelectionIndexPaths:(NSArray *)indexPaths {
//	
//}
//- (BOOL)removeSelectionIndexPaths:(NSArray *)indexPaths {
//	
//}


- (id)initWithContent:(id)content {
	NSLog(@"calling initWithContent:");
	id ret = [super initWithContent:(id)content];
	NSLog(@"finished calling initWithContent:");
	return ret;
}

//- (void)setContent:(id)content {
//	
//}
//- (id)content {
//	
//}

- (id)selection {
	NSLog(@"calling selection");
	id ret = [super selection];
	NSLog(@"finished calling selection");
	return ret;	
}	// an object representing all objects to be affected by editing as a singleton, returning special marker objects like NSMultipleSelectionMarker if necessary - in the concrete case of NSObjectController, returns an object that is used to access the content object
//- (NSArray *)selectedObjects {
//	
//}	// array of all objects to be affected by editing (if controller supports a selection mechanisms, the selected objects, otherwise all content objects) - in the concrete case of NSObjectController, returns an array with the content object

- (void)setAutomaticallyPreparesContent:(BOOL)flag {
	
	NSLog(@"calling setAutomaticallyPreparesContent:(BOOL)flag");
	[super setAutomaticallyPreparesContent:(BOOL)flag];
	NSLog(@"finished calling setAutomaticallyPreparesContent:(BOOL)flag");
}	// if YES, controllers will automatically invoke prepareContent when loaded from a nib file
- (BOOL)automaticallyPreparesContent {
	NSLog(@"calling automaticallyPreparesContent");
	BOOL ret = [super automaticallyPreparesContent];
	NSLog(@"finished calling automaticallyPreparesContent");
	return ret;	
	
}
- (void)prepareContent {
	
	NSLog(@"calling prepareContent");
	[super prepareContent];
	NSLog(@"finished calling prepareContent");
}	// typically overridden in subclasses which know how to get their content (from the file system or so) - default implementation creates a new object and populates the controller with it

- (void)setObjectClass:(Class)objectClass {
	
	NSLog(@"calling setObjectClass:(Class)objectClass");
	[super setObjectClass:(Class)objectClass];
	NSLog(@"finished calling setObjectClass:(Class)objectClass");
}	// sets the object class used when creating new objects
- (Class)objectClass {
	NSLog(@"calling objectClass");
	Class ret = [super objectClass];
	NSLog(@"finished calling objectClass");
	return ret;	
	
}
- (id)newObject {
	NSLog(@"calling newObject");
	id ret = [super newObject];
	NSLog(@"finished calling newObject");
	return ret;	
	
}	// creates a new object when adding/inserting objects (default implementation assumes the object class has a standard init method without arguments) - the returned object should not be autoreleased
- (void)addObject:(id)object {
	NSLog(@"calling addObject:(id)object");
	[super addObject:(id)object];
	NSLog(@"finished calling addObject:(id)object");	
}	// sets the content object of the controller - if the controller's content is bound to another object or controller through a relationship key, the relationship of the 'master' object will be changed
- (void)removeObject:(id)object {
	NSLog(@"calling removeObject:(id)object");
	[super removeObject:(id)object];
	NSLog(@"finished calling removeObject:(id)object");
}	// if the object is the current content object of the controller, clears the content - if the controller's content is bound to another object or controller through a relationship key, the relationship of the 'master' object will be cleared

- (void)setEditable:(BOOL)flag {
	NSLog(@"calling setEditable:(BOOL)flag");
	[super setEditable:(BOOL)flag];
	NSLog(@"finished calling setEditable:(BOOL)flag");
}	// determines whether controller allows adding and removing objects
- (BOOL)isEditable {
	NSLog(@"calling isEditable");
	BOOL ret = [super isEditable];
	NSLog(@"finished calling isEditable");
	return ret;	
	
}
//- (void)add:(id)sender {
//	
//}	// creates a new object and adds it through addObject:
- (BOOL)canAdd {
	NSLog(@"calling canAdd");
	BOOL ret = [super canAdd];
	NSLog(@"finished calling canAdd");
	return ret;	
	
}	// can be used in bindings controlling the enabling of buttons, for example
//- (void)remove:(id)sender {
//	
//}	// removes content object through removeObject:
- (BOOL)canRemove {
	NSLog(@"calling canRemove");
	BOOL ret = [super canRemove];
	NSLog(@"finished calling canRemove");
	return ret;	
	
}	// can be used in bindings controlling the enabling of buttons, for example
- (BOOL)validateMenuItem:(id <NSMenuItem>)menuItem {
	NSLog(@"calling validateMenuItem:(id <NSMenuItem>)menuItem");
	BOOL ret = [super validateMenuItem:(id <NSMenuItem>)menuItem];
	NSLog(@"finished calling validateMenuItem:(id <NSMenuItem>)menuItem");
	return ret;	
	
}	// used to automatically disable menu items for action methods of the controller (for example if canAdd returns NO, menu items with the add: action are disabled)


- (NSManagedObjectContext *)managedObjectContext {
	NSLog(@"calling managedObjectContext");
	id ret = [super managedObjectContext];
	NSLog(@"finished calling managedObjectContext");
	return ret;	
	
}
- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
	
	NSLog(@"calling setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext");
	[super setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext];
	NSLog(@"finished calling setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext");
}

- (NSString *)entityName {
	NSLog(@"calling entityName");
	id ret = [super entityName];
	NSLog(@"finished calling entityName");
	return ret;	
	
}
- (void)setEntityName:(NSString *)entityName {
	NSLog(@"calling setEntityName:(NSString *)entityName");
	[super setEntityName:(NSString *)entityName];
	NSLog(@"finished calling setEntityName:(NSString *)entityName");
	
}
- (NSPredicate *)fetchPredicate {
	NSLog(@"calling fetchPredicate");
	id ret = [super fetchPredicate];
	NSLog(@"finished calling fetchPredicate");
	return ret;	
	
}
- (void)setFetchPredicate:(NSPredicate *)predicate {
	NSLog(@"calling setFetchPredicate:(NSPredicate *)predicate");
	[super setFetchPredicate:(NSPredicate *)predicate];
	NSLog(@"finished calling setFetchPredicate:(NSPredicate *)predicate");
	
}

- (BOOL)fetchWithRequest:(NSFetchRequest *)fetchRequest merge:(BOOL)merge error:(NSError **)error {
	NSLog(@"calling fetchWithRequest:(NSFetchRequest *)fetchRequest merge:(BOOL)merge error:(NSError **)error");
	BOOL ret = [super fetchWithRequest:(NSFetchRequest *)fetchRequest merge:(BOOL)merge error:(NSError **)error];
	NSLog(@"finished calling fetchWithRequest:(NSFetchRequest *)fetchRequest merge:(BOOL)merge error:(NSError **)error");
	return ret;	
	
}	// subclasses can override this method to customize the fetch request, for example to specify fetch limits (passing nil for the fetch request will result in the default fetch request to be used; this method will never be invoked with a nil fetch request from within the standard Cocoa frameworks) - the merge flag determines whether the controller replaces the entire content with the fetch result or merges the existing content with the fetch result

- (void)fetch:(id)sender {
	
	NSLog(@"calling fetch:(id)sender");
	[super fetch:(id)sender];
	NSLog(@"finished calling fetch:(id)sender");
}

/* NSController */


- (void)objectDidBeginEditing:(id)editor {
	
	NSLog(@"calling objectDidBeginEditing:(id)editor");
	[super objectDidBeginEditing:(id)editor];
	NSLog(@"finished calling objectDidBeginEditing:(id)editor");
}
- (void)objectDidEndEditing:(id)editor {
	
	NSLog(@"calling objectDidEndEditing:(id)editor");
	[super objectDidEndEditing:(id)editor];
	NSLog(@"finished calling objectDidEndEditing:(id)editor");
}
- (void)discardEditing {
	
	NSLog(@"calling discardEditing");
	[super discardEditing];
	NSLog(@"finished calling discardEditing");
}
- (BOOL)commitEditing {
	NSLog(@"calling commitEditing");
	BOOL ret = [super commitEditing];
	NSLog(@"finished calling commitEditing");
	return ret;	
	
}
- (void)commitEditingWithDelegate:(id)delegate didCommitSelector:(SEL)didCommitSelector contextInfo:(void *)contextInfo {
	
	NSLog(@"calling commitEditingWithDelegate:(id)delegate didCommitSelector:(SEL)didCommitSelector contextInfo:(void *)contextInfo");
	[super commitEditingWithDelegate:(id)delegate didCommitSelector:(SEL)didCommitSelector contextInfo:(void *)contextInfo];
	NSLog(@"finished calling commitEditingWithDelegate:(id)delegate didCommitSelector:(SEL)didCommitSelector contextInfo:(void *)contextInfo");
}
- (BOOL)isEditing {
	NSLog(@"calling isEditing");
	BOOL ret = [super isEditing];
	NSLog(@"finished calling isEditing");
	return ret;	
	
}


@end
