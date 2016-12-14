
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSLoadableModel.h"
#import "NSArray+ANSExtension.h"
#import "ANSChangeModel.h"

@class ANSArrayModel;

@protocol ANSArrayModelObserver <ANSLoadableModelObserver>

@optional

- (void)    arrayModel:(ANSArrayModel *)arrayModel
    didChangeWithModel:(ANSChangeModel *)model;

@end

typedef NS_ENUM(NSUInteger, ANSArrayModelState) {
    ANSArrayModelDidChange = ANSLoadableModelStatesCount,
    
    ANSArrayModelStatesCount
};

@interface ANSArrayModel : ANSLoadableModel <
    NSCoding,
    NSFastEnumeration
>

@property (nonatomic, readonly)                     NSUInteger  count;
@property (nonatomic, readonly)                     NSArray     *objects;

- (BOOL)containsObject:(id)object;

- (id)objectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(id)object;
- (id)objectAtIndexedSubscript:(NSUInteger)idx;

- (void)addObject:(id)object;
- (void)removeObject:(id)object;

- (void)insertObject:(id)object atIndex:(NSUInteger)index;
- (void)removeObjectAtIndex:(NSUInteger)index;

- (void)addObjectsInRange:(NSArray*)objects;
- (void)removeAllObjects;

- (void)moveObjectFromIndex:(NSUInteger)index toIndex:(NSUInteger)index;
- (void)exchangeObjectAtIndex:(NSUInteger)index
            withObjectAtIndex:(NSUInteger)index2;

#pragma mark - methods intended for subclasses

- (void)notifyOfChangeWithIndex:(NSUInteger)index
                       userInfo:(id)userInfo
                          state:(ANSChangeState)state;

- (void)notifyOfChangeWithIndex:(NSUInteger)index1
                         index2:(NSUInteger)index2
                       userInfo:(id)userInfo
                          state:(ANSChangeState)state;

@end
