//
//  NSArray+ANSExtension.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 06.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "NSArray+ANSExtension.h"

@implementation NSArray (ANSExtension)

+ (instancetype)objectsWithCount:(NSUInteger)count block:(ANSObjectBlock)block {
    if (!block) {
        return nil;
    }
    
    NSMutableArray *objects = [NSMutableArray new];
    for (NSUInteger value = 0; value < count; value ++) {
        [objects addObject:block()]; //block() => result of block implementation;
    }
    
    return [self arrayWithArray:objects];
}

- (NSArray *)filteredArrayWithBlock:(BOOL(^)(id object))block {
    if (!block) {
        return Nil;
    }
    
    NSPredicate *filter = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return block(evaluatedObject);
    }];
    
    return [self filteredArrayUsingPredicate:filter];
}

@end
