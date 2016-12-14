//
//  NSTimer+ANSExtension.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 15.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "NSTimer+ANSExtension.h"

#import "ANSTimerPrivate.h"

@implementation NSTimer (ANSExtension)

#pragma mark -
#pragma mark Public methods

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval
                             block:(ANSTimerBlock)block
                           repeats:(BOOL)repeats
{
    if (!block) {
        return 0;
    }
    
    ANSTimerBlock copy = [block copy];
    ANSTimerPrivate *object = [ANSTimerPrivate new];
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval
                                             target:object
                                           selector:@selector(executeBlock:)
                                           userInfo:copy
                                            repeats:repeats];
    
    
    return timer;
};

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                    block:(ANSTimerBlock)block
                                    repeats:(BOOL)repeats

{
    NSTimer *timer = [self timerWithTimeInterval:interval block:block repeats:repeats];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    return timer;
}

@end
