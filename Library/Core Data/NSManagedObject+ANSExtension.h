//
//  NSManagedObject+ANSExtension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 04.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <CoreData/CoreData.h>

// MO  - managedObject
// MOC - managedObjectContext;

@interface NSManagedObject (ANSExtension)

// This method insert new managedObject to sharedManager MOC
// You objective-c class name mast match with entityName
+ (instancetype)object;

//Returns first objects which suitable for predicae conditions
+ (instancetype)objectWithPredicate:(NSPredicate *)predicate;

+ (NSFetchRequest *)fetchRequestWithSortDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors
                                     predicate:(NSPredicate *)predicate
                                    batchCount:(NSUInteger)count;

// returns all objects from dataBase
+ (NSArray *)objects;

+ (NSArray *)objectsWithPredicate:(NSPredicate *)predicate;

+ (NSArray *)objectsWithSortDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors
                              predicate:(NSPredicate *)predicate;

+ (NSArray *)objectsWithSortDescriptors:(NSArray<NSSortDescriptor *> *)sortDescriptors
                              predicate:(NSPredicate *)predicate
                             batchCount:(NSUInteger)count;

//save MO to dataBase
//MO must be inserted to sharedManager MOC and configureted before saving
- (BOOL)save;

//refresh objects and merge changes
- (void)refresh;

//managedObjectContext 
- (void)dontSave;

//remove MO from DB
- (BOOL)remove;

- (void)setCustomValue:(id)value forKey:(NSString *)key;
- (id)customvalueForKey:(NSString *)key;

- (void)addCustomValue:(id)value inMutableSetForKey:(NSString *)key;
- (void)removeCustomValue:(id)value inMutableSetForKey:(NSString *)key;

- (void)addCustomValues:(NSSet *)values inMutableSetForKey:(NSString *)key;
- (void)removeCustomValues:(NSSet *)values inMutableSetForKey:(NSString *)key;

@end
