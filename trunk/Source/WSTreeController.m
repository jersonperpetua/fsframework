//
//  WSTreeController.m
//  WYAppFramework
//
//  Created by Whitney Young on 6/28/06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import "WSTreeController.h"


@implementation WSTreeController

- (BOOL)isEqual:(id)object {
    NSLog(@"calling isEqual:");
    BOOL ret = [super isEqual:object];
    NSLog(@"finished calling isEqual:");
    return ret;
}
- (unsigned)hash {
    NSLog(@"calling hash");
    unsigned ret = [super hash];
    NSLog(@"finished calling hash");
    return ret;    
}

- (Class)superclass {
    NSLog(@"calling superclass");
    Class ret = [super superclass];
    NSLog(@"finished calling superclass");
    return ret;    
}

- (Class)class {
    NSLog(@"calling class");
    Class ret = [super class];
    NSLog(@"finished calling class");
    return ret;        
}

- (id)self {
    NSLog(@"calling self");
    id ret = [super self];
    NSLog(@"finished calling self");
    return ret;    
}
- (NSZone *)zone {
    NSLog(@"calling zone");
    id ret = [super zome];
    NSLog(@"finished calling zone");
    return ret;    
}

- (id)performSelector:(SEL)aSelector {
    NSLog(@"calling performSelector:(SEL)aSelector");
    id ret = [super performSelector:(SEL)aSelector];
    NSLog(@"finished performSelector:(SEL)aSelector");
    return ret;    
}
- (id)performSelector:(SEL)aSelector withObject:(id)object {
    NSLog(@"calling performSelector:(SEL)aSelector withObject:(id)object");
    id ret = [super performSelector:(SEL)aSelector withObject:(id)object];
    NSLog(@"finished performSelector:(SEL)aSelector withObject:(id)object");
    return ret;    
}
- (id)performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2 {
    
    NSLog(@"calling performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2");
    id ret = [super performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2];
    NSLog(@"finished calling performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2");
    return ret;   
}

- (BOOL)isProxy {
    
    NSLog(@"calling isProxy");
    BOOL ret = [super isProxy];
    NSLog(@"finished calling isProxy");
    return ret; 
}

- (BOOL)isKindOfClass:(Class)aClass {
    NSLog(@"calling isKindOfClass:(Class)aClass with class type: %@", [aClass description]);
    BOOL ret = [super isKindOfClass:(Class)aClass];
    NSLog(@"finished calling isKindOfClass:(Class)aClass");
    return ret; 
}
- (BOOL)isMemberOfClass:(Class)aClass {
    NSLog(@"calling isMemberOfClass:(Class)aClass");
    BOOL ret = [super isMemberOfClass:(Class)aClass];
    NSLog(@"finished calling isMemberOfClass:(Class)aClass");
    return ret; 
}
- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    NSLog(@"calling conformsToProtocol:(Protocol *)aProtocol");
    BOOL ret = [super conformsToProtocol:(Protocol *)aProtocol];
    NSLog(@"finished calling conformsToProtocol:(Protocol *)aProtocol");
    return ret; 
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    NSLog(@"calling respondsToSelector: with argument %@", NSStringFromSelector(aSelector));
    BOOL ret = [super respondsToSelector:aSelector];
    NSLog(@"finished calling respondsToSelector: with value: %@", (ret ? @"TRUE" : @"FALSE" ));
    return ret;
}

- (id)retain {
    NSLog(@"calling retain");
    id ret = [super retain];
    NSLog(@"finished calling retain");
    return ret; 
}
- (oneway void)release {
    NSLog(@"calling release");
    [super release];
    NSLog(@"finished calling releaes");
}
- (id)autorelease {
    NSLog(@"calling autorelease");
    id ret = [super autorelease];
    NSLog(@"finished calling autorelease");
    return ret;
}
- (unsigned)retainCount {
    NSLog(@"calling retainCount");
    unsigned ret = [super retainCount];
    NSLog(@"finished calling retainCount");
    return ret;    
}

- (NSString *)description {
    NSLog(@"calling description");
    id ret = [super description];
    NSLog(@"finished calling description");
    return ret;  
}

- (id)copyWithZone:(NSZone *)zone {
    NSLog(@"calling copyWithZone:(NSZone *)zone:(NSZone *)zone");
    id ret = [super copyWithZone:(NSZone *)zone];
    NSLog(@"finished calling copyWithZone:(NSZone *)zone");
    return ret;  
    
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    NSLog(@"calling mutableCopyWithZone:(NSZone *)zone");
    id ret = [super mutableCopyWithZone:(NSZone *)zone];
    NSLog(@"finished calling mutableCopyWithZone:(NSZone *)zone");
    return ret;  
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSLog(@"calling encodeWithCoder:(NSCoder *)aCoder");
    [super encodeWithCoder:(NSCoder *)aCoder];
    NSLog(@"finished calling encodeWithCoder:(NSCoder *)aCoder");
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"calling initWithCoder:(NSCoder *)aDecoder");
    id ret = [super initWithCoder:(NSCoder *)aDecoder];
    NSLog(@"finished calling initWithCoder:(NSCoder *)aDecoder");
    return ret;  
}

+ (void)load {
    NSLog(@"calling load");
    [super load];
    NSLog(@"finished calling load");
}

+ (void)initialize {
    NSLog(@"calling initialize");
    [super initialize];
    NSLog(@"finished calling initialize");
}
- (id)init {

    NSLog(@"calling init");
    id ret = [super init];
    NSLog(@"finished calling init");
    return ret;
}

+ (id)new {
    NSLog(@"calling new");
    id ret = [super new];
    NSLog(@"finished calling new");
    return ret;    
}
+ (id)allocWithZone:(NSZone *)zone {
    NSLog(@"calling allocWithZone:(NSZone *)zone");
    id ret = [super allocWithZone:(NSZone *)zone];
    NSLog(@"finished calling allocWithZone:(NSZone *)zone");
    return ret;    
    
}
+ (id)alloc {
    NSLog(@"calling alloc");
    id ret = [super alloc];
    NSLog(@"finished calling alloc");
    return ret;    
    
}
- (void)dealloc {
    
    NSLog(@"calling dealloc");
    [super dealloc];
    NSLog(@"finished calling dealloc");
}

- (void)finalize {
    
    NSLog(@"calling finalize");
    [super finalize];
    NSLog(@"finished calling finalize");
}

- (id)copy {
    NSLog(@"calling copy");
    id ret = [super copy];
    NSLog(@"finished calling copy");
    return ret;    
    
}
- (id)mutableCopy {
    NSLog(@"calling mutableCopy");
    id ret = [super mutableCopy];
    NSLog(@"finished calling mutableCopy");
    return ret;    
    
}

+ (id)copyWithZone:(NSZone *)zone {
    NSLog(@"calling copyWithZone:(NSZone *)zone");
    id ret = [super copyWithZone:(NSZone *)zone];
    NSLog(@"finished calling copyWithZone:(NSZone *)zone");
    return ret;    
    
}
+ (id)mutableCopyWithZone:(NSZone *)zone {
    NSLog(@"calling mutableCopyWithZone:(NSZone *)zone");
    id ret = [super mutableCopyWithZone:(NSZone *)zone];
    NSLog(@"finished calling mutableCopyWithZone:(NSZone *)zone");
    return ret;    
    
}

+ (Class)superclass {
    
    NSLog(@"calling superclass");
    Class ret = [super superclass];
    NSLog(@"finished calling superclass");
    return ret;    
}
+ (Class)class {
    
    NSLog(@"calling class");
    Class ret = [super class];
    NSLog(@"finished calling class");
    return ret;  
}
+ (void)poseAsClass:(Class)aClass {
    
    NSLog(@"calling poseAsClass:(Class)aClass ");
    [super class];
    NSLog(@"finished calling poseAsClass:(Class)aClass ");
}
+ (BOOL)instancesRespondToSelector:(SEL)aSelector {
    
    NSLog(@"calling instancesRespondToSelector:(SEL)aSelector");
    BOOL ret = [super instancesRespondToSelector:(SEL)aSelector];
    NSLog(@"finished calling instancesRespondToSelector:(SEL)aSelector");
    return ret;  
}
+ (BOOL)conformsToProtocol:(Protocol *)protocol {
    
    NSLog(@"calling conformsToProtocol:(Protocol *)protocol");
    BOOL ret = [super conformsToProtocol:(Protocol *)protocol];
    NSLog(@"finished calling conformsToProtocol:(Protocol *)protocol");
    return ret;  
}
- (IMP)methodForSelector:(SEL)aSelector {
    
    NSLog(@"calling methodForSelector:(SEL)aSelector");
    IMP ret = [super methodForSelector:(SEL)aSelector];
    NSLog(@"finished calling methodForSelector:(SEL)aSelector");
    return ret;  
}
+ (IMP)instanceMethodForSelector:(SEL)aSelector {
    NSLog(@"calling instanceMethodForSelector:(SEL)aSelector");
    IMP ret = [super instanceMethodForSelector:(SEL)aSelector];
    NSLog(@"finished calling instanceMethodForSelector:(SEL)aSelector");
    return ret;  
    
}
+ (int)version {
    NSLog(@"calling version");
    int ret = [super version];
    NSLog(@"finished calling version");
    return ret;  
}
+ (void)setVersion:(int)aVersion {
    NSLog(@"calling setVersion:(int)aVersion");
    [super setVersion:(int)aVersion];
    NSLog(@"finished calling setVersion:(int)aVersion");
}
- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"calling doesNotRecognizeSelector:(SEL)aSelector");
    [super doesNotRecognizeSelector:(SEL)aSelector];
    NSLog(@"finished calling doesNotRecognizeSelector:(SEL)aSelector");
    
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"calling forwardInvocation:(NSInvocation *)anInvocation");
    [super forwardInvocation:(NSInvocation *)anInvocation];
    NSLog(@"finished calling forwardInvocation:(NSInvocation *)anInvocation");
    
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"calling methodSignatureForSelector:(SEL)aSelector");
    id ret = [super methodSignatureForSelector:(SEL)aSelector];
    NSLog(@"finished calling methodSignatureForSelector:(SEL)aSelector");
    return ret;
    
}

+ (NSMethodSignature *)instanceMethodSignatureForSelector:(SEL)aSelector {
    
    NSLog(@"calling instanceMethodSignatureForSelector:(SEL)aSelector");
    id ret = [super instanceMethodSignatureForSelector:(SEL)aSelector];
    NSLog(@"finished calling instanceMethodSignatureForSelector:(SEL)aSelector");
    return ret;
}

+ (BOOL)isSubclassOfClass:(Class)aClass {
    
    NSLog(@"calling isSubclassOfClass:(Class)aClass");
    BOOL ret = [super isSubclassOfClass:(Class)aClass];
    NSLog(@"finished calling isSubclassOfClass:(Class)aClass");
    return ret;
}

+ (NSString *)description {
    
    NSLog(@"calling description");
    id ret = [super description];
    NSLog(@"finished calling description");
    return ret;
}

- (Class)classForCoder {
    NSLog(@"calling classForCoder");
    Class ret = [super classForCoder];
    NSLog(@"finished calling classForCoder");
    return ret;
}
- (id)replacementObjectForCoder:(NSCoder *)aCoder {
    
    NSLog(@"calling replacementObjectForCoder:(NSCoder *)aCoder");
    id ret = [super replacementObjectForCoder:(NSCoder *)aCoder];
    NSLog(@"finished calling replacementObjectForCoder:(NSCoder *)aCoder");
    return ret;
}
- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder {
    
    NSLog(@"calling awakeAfterUsingCoder:(NSCoder *)aDecoder");
    id ret = [super awakeAfterUsingCoder:(NSCoder *)aDecoder];
    NSLog(@"finished calling awakeAfterUsingCoder:(NSCoder *)aDecoder");
    return ret;
}

- (id)valueForKey:(NSString *)aKey {
    NSLog(@"calling valueForKey: with argument %@", aKey);
    id ret = [super valueForKey:aKey];
    NSLog(@"finished calling valueForKey: with return value %@", ret);
    return ret;        
}

- (id)valueForKeyPath:(NSString *)keyPath {
    NSLog(@"calling valueForKeyPath:(NSString *)keyPath");
    id ret = [super valueForKeyPath:(NSString *)keyPath];
    NSLog(@"finished calling valueForKeyPath:(NSString *)keyPath");
    return ret;        
}

-(NSDictionary *)dictionaryWithValuesForKeys:(NSArray *)keys {
    NSLog(@"calling dictionaryWithValuesForKeys:(NSArray *)keys");
    id ret = [super dictionaryWithValuesForKeys:(NSArray *)keys];
    NSLog(@"finished calling dictionaryWithValuesForKeys:(NSArray *)keys");
    return ret;        
}

- (id)valueForUndefinedKey:(NSString *)key {
    NSLog(@"calling valueForUndefinedKey:(NSString *)key");
    id ret = [super valueForUndefinedKey:(NSString *)key];
    NSLog(@"finished calling valueForUndefinedKey:(NSString *)key");
    return ret;        
}

- (NSMutableArray *)mutableArrayValueForKey:(NSString *)key {
    NSLog(@"calling mutableArrayValueForKey:(NSString *)key");
    id ret = [super mutableArrayValueForKey:(NSString *)key];
    NSLog(@"finished calling mutableArrayValueForKey:(NSString *)key");
    return ret;        
}

- (NSMutableArray *)mutableArrayValueForKeyPath:(NSString *)keyPath {
    NSLog(@"calling mutableArrayValueForKeyPath:(NSString *)keyPath");
    id ret = [super mutableArrayValueForKeyPath:(NSString *)keyPath];
    NSLog(@"finished calling mutableArrayValueForKeyPath:(NSString *)keyPath");
    return ret;        
}

- (NSMutableSet *)mutableSetValueForKeyPath:(NSString *)keyPath {
    NSLog(@"calling mutableSetValueForKeyPath:(NSString *)keyPath");
    id ret = [super mutableSetValueForKeyPath:(NSString *)keyPath];
    NSLog(@"finished calling mutableSetValueForKeyPath:(NSString *)keyPath");
    return ret;        
}

- (NSArray *)exposedBindings {
    NSLog(@"calling exposedBindings");
    id ret = [super exposedBindings];
    NSLog(@"finished calling exposedBindings");
    return ret;    
}

- (void)addObserver:(NSObject *)anObserver forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    NSLog(@"calling addObserver of %@ with options: %i and %@ observing", keyPath, options, [anObserver description]);
    [super addObserver:anObserver forKeyPath:keyPath options:options context:context];
    NSLog(@"finished calling addObserver");
}

// triggers rearranging the content objects for the user interface, including sorting (and filtering if provided by subclasses); subclasses can invoke this method if any parameter that affects the arranged objects changes
- (void)rearrangeObjects {
    NSLog(@"rearranging objects");
    [super rearrangeObjects];
    NSLog(@"finished rearranging objects");
}

// opaque root node representation of all displayed objects. This is just for binding to or passing around. At this time, developers should not make any assumption about what methods this object responds to.
- (id)arrangedObjects {
    NSLog(@"calling arrangedObjects");
    return [super arrangedObjects];
    NSLog(@"finished calling arrangedObjects");
}

// key used to find the children of a model object.
- (void)setChildrenKeyPath:(NSString *)keyPath {
    NSLog(@"calling setChildrenKeyPath:");
    [super setChildrenKeyPath:keyPath];
    NSLog(@"finished calling setChildrenKeyPath:");
}
- (NSString *)childrenKeyPath {
    NSLog(@"calling childrenKeyPath");
    id ret = [super childrenKeyPath];
    NSLog(@"finished calling childrenKeyPath");
    return ret;
}
//
// optional for performance
- (void)setCountKeyPath:(NSString *)keyPath {
    NSLog(@"calling setCountKeyPath:(NSString *)keyPath");
    [super setCountKeyPath:(NSString *)keyPath];
    NSLog(@"finished calling setCountKeyPath:(NSString *)keyPath");
}
- (NSString *)countKeyPath {
    NSLog(@"calling countKeyPath");
    id ret = [super countKeyPath];
    NSLog(@"finished calling countKeyPath");
    return ret;
}

// optional. inserting/adding children disabled for leaf nodes
- (void)setLeafKeyPath:(NSString *)keyPath {
    NSLog(@"calling setLeafKeyPath:(NSString *)keyPath");
    [super setLeafKeyPath:(NSString *)keyPath];
    NSLog(@"finished calling setLeafKeyPath:(NSString *)keyPath");
}

- (NSString *)leafKeyPath {
    NSLog(@"calling leafKeyPath");
    id ret = [super leafKeyPath];
    NSLog(@"finished calling leafKeyPath");
    return ret;
}

- (void)setSortDescriptors:(NSArray *)sortDescriptors {
    NSLog(@"calling setSortDescriptors:(NSArray *)sortDescriptors");
    [super setSortDescriptors:(NSArray *)sortDescriptors];
    NSLog(@"finished calling setSortDescriptors:(NSArray *)sortDescriptors");
}

- (NSArray *)sortDescriptors {    
    NSLog(@"calling sortDescriptors");
    id ret = [super sortDescriptors];
    NSLog(@"finished calling sortDescriptors");
    return ret;
}

- (id)content {
    NSLog(@"calling content");
    id ret = [super content];
    NSLog(@"finished calling content");
    return ret;
}

- (void)setContent:(id)content {
    NSLog(@"calling set content");
    [super setContent:content];
    NSLog(@"finished calling set content");
}

// adds a new sibling node to the end of the selected objects
- (void)add:(id)sender {
    NSLog(@"calling add:");
    [super add:(id)sender];
    NSLog(@"finished calling add:");
}
//removes the currently selected objects from the tree
- (void)remove:(id)sender {
    NSLog(@"calling remove:");
    [super remove:(id)sender];
    NSLog(@"finished calling remove:");
}
// adds a new child node to the end of the selected objects
- (void)addChild:(id)sender {
    NSLog(@"calling addChild:");
    [super addChild:(id)sender];
    NSLog(@"finished calling addChild:");
}

// inserts a peer in front of first selected node
- (void)insert:(id)sender {
    NSLog(@"calling insert:");
    [super insert:(id)sender];
    NSLog(@"finished calling insert:");
}

// inserts a new first child into the children array of the first selected node
- (void)insertChild:(id)sender {
    NSLog(@"calling insertChild:");
    [super insertChild:(id)sender];
    NSLog(@"finished calling insertChild:");
}

- (BOOL)canInsert {
    NSLog(@"calling canInsert");
    BOOL ret = [super canInsert];
    NSLog(@"finished calling canInsert");
    return ret;
}
- (BOOL)canInsertChild {
    NSLog(@"calling canInsertChild");
    BOOL ret = [super canInsert];
    NSLog(@"finished calling canInsertChild");
    return ret;
}
- (BOOL)canAddChild {
    NSLog(@"calling canAddChild");
    BOOL ret = [super canAddChild];
    NSLog(@"finished calling canAddChild");
    return ret;
}

- (void)insertObject:(id)object atArrangedObjectIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"calling insertObject:(id)object atArrangedObjectIndexPath:(NSIndexPath *)indexPath");
    [super insertObject:(id)object atArrangedObjectIndexPath:(NSIndexPath *)indexPath];
    NSLog(@"finished calling insertObject:(id)object atArrangedObjectIndexPath:(NSIndexPath *)indexPath");
}
- (void)insertObjects:(NSArray *)objects atArrangedObjectIndexPaths:(NSArray *)indexPaths {
    NSLog(@"calling insertObjects:(NSArray *)objects atArrangedObjectIndexPaths:(NSArray *)indexPaths");
    [super insertObjects:(NSArray *)objects atArrangedObjectIndexPaths:(NSArray *)indexPaths];
    NSLog(@"finished calling insertObjects:(NSArray *)objects atArrangedObjectIndexPaths:(NSArray *)indexPaths");
    
}
- (void)removeObjectAtArrangedObjectIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"calling removeObjectAtArrangedObjectIndexPath:(NSIndexPath *)indexPath");
    [super removeObjectAtArrangedObjectIndexPath:(NSIndexPath *)indexPath];
    NSLog(@"finished calling removeObjectAtArrangedObjectIndexPath:(NSIndexPath *)indexPath");
    
}
- (void)removeObjectsAtArrangedObjectIndexPaths:(NSArray *)indexPaths {
    NSLog(@"calling removeObjectsAtArrangedObjectIndexPaths:(NSArray *)indexPaths");
    [super removeObjectsAtArrangedObjectIndexPaths:(NSArray *)indexPaths];
    NSLog(@"finished calling removeObjectsAtArrangedObjectIndexPaths:(NSArray *)indexPaths");
    
}

// functionality here is parallel to what is in array controller

// default: YES
- (void)setAvoidsEmptySelection:(BOOL)flags {
    NSLog(@"calling setAvoidsEmptySelection:(BOOL)flags");
    [super setAvoidsEmptySelection:(BOOL)flags];
    NSLog(@"finished calling setAvoidsEmptySelection:(BOOL)flags");
}    
- (BOOL)avoidsEmptySelection {
    NSLog(@"calling avoidsEmptySelection");
    BOOL ret = [super avoidsEmptySelection];
    NSLog(@"finished calling avoidsEmptySelection");
    return ret;
}

// default: YES
- (void)setPreservesSelection:(BOOL)flag {
    NSLog(@"calling setPreservesSelection:(BOOL)flag");
    [super setPreservesSelection:(BOOL)flag];
    NSLog(@"finished calling setPreservesSelection:(BOOL)flag");
}

// default: YES
- (BOOL)preservesSelection {
    NSLog(@"calling preservesSelection");
    BOOL ret = [super preservesSelection];
    NSLog(@"finished calling preservesSelection");
    return ret;
}

// default: YES
- (void)setSelectsInsertedObjects:(BOOL)flag {
    NSLog(@"calling setSelectsInsertedObjects:(BOOL)flag");
    [super setSelectsInsertedObjects:(BOOL)flag];
    NSLog(@"finished calling setSelectsInsertedObjects:(BOOL)flag");
}
- (BOOL)selectsInsertedObjects {
    NSLog(@"calling selectsInsertedObjects");
    BOOL ret = [super selectsInsertedObjects];
    NSLog(@"finished calling selectsInsertedObjects");
    return ret;
}

- (void)setAlwaysUsesMultipleValuesMarker:(BOOL)flag {
    NSLog(@"calling setAlwaysUsesMultipleValuesMarker:(BOOL)flag");
    [super setAlwaysUsesMultipleValuesMarker:(BOOL)flag];
    NSLog(@"finished calling setAlwaysUsesMultipleValuesMarker:(BOOL)flag");
}

- (BOOL)alwaysUsesMultipleValuesMarker {    
    NSLog(@"calling alwaysUsesMultipleValuesMarker");
    BOOL ret = [super alwaysUsesMultipleValuesMarker];
    NSLog(@"finished calling alwaysUsesMultipleValuesMarker");
    return ret;
}

///* All selection modification methods returning a BOOL indicate through that flag whether changing the selection was successful (changing the selection might trigger a commitEditing call which fails and thus deny's the selection change).
//*/
//- (NSArray *)selectedObjects {
//    return _selectedObjects;
//}
//
//- (BOOL)setSelectionIndexPaths:(NSArray *)indexPaths {
//    return NO;
//}
//- (NSArray *)selectionIndexPaths {
//    return NO;
//}
//- (BOOL)setSelectionIndexPath:(NSIndexPath *)indexPath {
//    return NO;
//}
//- (NSIndexPath *)selectionIndexPath {
//    return NO;
//}
//- (BOOL)addSelectionIndexPaths:(NSArray *)indexPaths {
//    return NO;
//}
//- (BOOL)removeSelectionIndexPaths:(NSArray *)indexPaths {
//    return NO;
//}

@end
