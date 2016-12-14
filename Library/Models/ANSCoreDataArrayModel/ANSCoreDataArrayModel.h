//
//  ANSWrapedFetchedController.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 11.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "ANSArrayModel.h"
#import "ANSObservableObjectPtotocol.h"

@interface ANSCoreDataArrayModel : ANSArrayModel <NSFetchedResultsControllerDelegate>
@property (nonatomic, readonly)   id <ANSObservableObject>   model;
@property (nonatomic, readonly)   NSUInteger                 count;
@property (nonatomic, readonly)   NSArray                    *objects;

- (instancetype)initWithModel:(id <ANSObservableObject>)model
                      keyPath:(NSString *)keyPath;

//You have to call "load" method, after your model will filled.

#pragma mark - For child class reloading
//You have to reload next methods in child classes

//default value - nil;
- (NSArray<NSSortDescriptor *> *)sortDescriptors;

//default value - nil;
- (NSPredicate *)filterPredicate;

//default value - nil;
- (NSPredicate *)fetchedPredicate;

//default value - 0;
- (NSUInteger)batchCount;

#pragma mark - next methods doesn't work here;
- (void)insertObject:(id)object atIndex:(NSUInteger)index   NS_UNAVAILABLE;

- (void)moveObjectFromIndex:(NSUInteger)index
                    toIndex:(NSUInteger)toIndex             NS_UNAVAILABLE;

- (void)exchangeObjectAtIndex:(NSUInteger)index
            withObjectAtIndex:(NSUInteger)index2            NS_UNAVAILABLE;

@end
