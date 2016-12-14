//
//  ANSCollectionHelper.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 12.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSChangeModel.h"

#import "ANSOneIndexModel.h"
#import "ANSTwoIndexModel.h"
#import "ANSRangeChangeModel.h"

@implementation ANSChangeModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)oneIndexModel:(NSUInteger)index {
    return [[ANSOneIndexModel alloc] initWithIndex:index];
}

+ (instancetype)twoIndexModel:(NSUInteger)index index2:(NSUInteger)index2 {
    return [[ANSTwoIndexModel alloc] initWithIndex:index index2:index2];
}

+ (instancetype)rangeModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    return [[ANSRangeChangeModel alloc] initFromIndex:fromIndex toIndex:toIndex];
}

#pragma mark -
#pragma mark initialization and deallocation

- (instancetype)init {
    if ([self class] == [ANSChangeModel class]) {
        [NSException raise:@"Invalid identifier" format:@"You should never call init method for ANSCollectionHelper"];
    }
    
    self = [super init];
    return self;
}

#pragma mark -
#pragma mark Acsessors

- (NSUInteger)index {
    [self doesNotRecognizeSelector:_cmd];
    
    return 0;
}

- (NSUInteger)index2 {
    [self doesNotRecognizeSelector:_cmd];
    
    return 0;
}

@end
