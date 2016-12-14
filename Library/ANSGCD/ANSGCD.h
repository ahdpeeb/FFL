//
//  ANSGCD.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 14.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Accessories

//new type for dispatch_queue_t.
typedef dispatch_queue_t ANSQSGCQueue;

//block signature for execution
typedef void(^ANSGCDBlock)(void);

//Identifier of queue prioryty
typedef enum {
    ANSPriorityHigh         = DISPATCH_QUEUE_PRIORITY_HIGH,
    ANSPriorityDefault      = DISPATCH_QUEUE_PRIORITY_DEFAULT,
    ANSPriorityLow          = DISPATCH_QUEUE_PRIORITY_LOW,
    ANSPriorityBackground   = DISPATCH_QUEUE_PRIORITY_BACKGROUND
} ANSPriorityType;

typedef enum {
    ANSPerformanceTypeSync,
    ANSPerformanceTypeAsync
} ANSPerformanceType;

#pragma mark -
#pragma mark Public functions

/*Funcrions take ANSPrioriryType - "identifier of queue prioryty"
 and block of code, which will be performed. Default type - ANSPriorityDefault*/

// Block asynchronously executу in backgrounds thread.
void ANSPerformInAsyncQueue(ANSPriorityType type, ANSGCDBlock block);

// Block synchronously executу in backgrounds thread.
void ANSPerformInSyncQueue(ANSPriorityType type, ANSGCDBlock block);

//  Perform block in main thread.
void ANSPerformAsyncOnMainQueue(ANSGCDBlock block);
void ANSPerformSyncOnMainQueue(ANSGCDBlock block);

//  Perform block after deley in main thread. 
//  if flag repeat = YES, this block will be perform
void ANSDispatchTimer(uint seconds, bool repeat, ANSGCDBlock block);
