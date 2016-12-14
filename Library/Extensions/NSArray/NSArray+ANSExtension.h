//
//  NSArray+ANSExtension.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 06.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id(^ANSObjectBlock)(void);

@interface NSArray (ANSExtension) 

//returns array of objects taken from block
+ (instancetype)objectsWithCount:(NSUInteger)count block:(ANSObjectBlock)block;

//returns array of filted objects
- (NSArray *)filteredArrayWithBlock:(BOOL(^)(id))block;

@end
