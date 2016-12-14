//
//  ANSBlockObservationController.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 01.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSObservationController.h"

typedef void(^ANSStateChangeBlock)(ANSBlockObservationController *controller, id userInfo);

@interface ANSBlockObservationController : ANSObservationController

- (void)setBlock:(ANSStateChangeBlock)block forState:(NSUInteger)state;

//state requie termination with -1 to NSUIntegerMax
- (void)setBlock:(ANSStateChangeBlock)block forStates:(NSUInteger)state, ...; 
- (void)removeBlock:(ANSStateChangeBlock)block forState:(NSUInteger)state;

- (BOOL)containsBlockForState:(NSUInteger)state;
- (ANSStateChangeBlock)blockForState:(NSUInteger)state;

#pragma mark -
#pragma mark Addtional

- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;

@end
