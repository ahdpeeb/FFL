//
//  ANSGCD.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 14.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSGCD.h"

#import "ANSMacros.h"

#pragma mark -
#pragma mark Private declaration

dispatch_queue_t ANSQueueWithPriotity(ANSPriorityType priotity);
void ANSPerformInMainQueueWithType(ANSPerformanceType type, ANSGCDBlock block);
void ANSPerformBlockOnMainQueueWithType(ANSGCDBlock block, ANSPerformanceType type);

#pragma mark -
#pragma mark Public methods

void ANSPerformInAsyncQueue(ANSPriorityType type, ANSGCDBlock block) {
    if (!block) {
        return;
    }
    
    dispatch_async(ANSQueueWithPriotity(type), block);
}

void ANSPerformInSyncQueue(ANSPriorityType type, ANSGCDBlock block) {
    if (!block) {
        return;
    }
    
    dispatch_sync(ANSQueueWithPriotity(type), block);
}

void ANSPerformAsyncOnMainQueue(ANSGCDBlock block) {
    ANSPerformBlockOnMainQueueWithType(block, ANSPerformanceTypeAsync);
}

void ANSPerformSyncOnMainQueue(ANSGCDBlock block) {
    ANSPerformBlockOnMainQueueWithType(block, ANSPerformanceTypeSync);
}

void ANSDispatchTimer(uint seconds, bool repeat, ANSGCDBlock block) {
    if (!block) {
        return;
    }
    
    __block bool value = repeat;
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        block();
        if(value) {
            ANSDispatchTimer(seconds, value, block);
        }
    });
}

#pragma mark -
#pragma mark Private

dispatch_queue_t ANSQueueWithPriotity(ANSPriorityType priotity) {
    return dispatch_get_global_queue(priotity, 0);
}

void ANSPerformBlockOnMainQueueWithType(ANSGCDBlock block, ANSPerformanceType type) {
    if ([NSThread isMainThread] && type == ANSPerformanceTypeSync) {
        ANSPerformBlock(block);
    } else {
        ANSPerformInMainQueueWithType(type, block);
    }
}

void ANSPerformInMainQueueWithType(ANSPerformanceType type, ANSGCDBlock block) {
    if (!block) {
        return;
    }
    
    switch (type) {
        case ANSPerformanceTypeSync:
            dispatch_sync(dispatch_get_main_queue(), block);
            break;
        
        case ANSPerformanceTypeAsync:
            dispatch_async(dispatch_get_main_queue(), block);
            break;
            
        default:
            break;
    }
}
