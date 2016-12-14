//
//  NSMutableArray+ANSExtension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 16.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "NSMutableArray+ANSExtension.h"

@implementation NSMutableArray (ANSExtension) 

- (void)moveObjectFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex != toIndex) {
        id object = [self objectAtIndex:fromIndex];
        [self removeObject:object];
        [self insertObject:object atIndex:toIndex];
    }
}

@end
