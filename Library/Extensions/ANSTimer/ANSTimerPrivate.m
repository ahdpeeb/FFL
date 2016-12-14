//
//  ANSTimerPrivate.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 19.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSTimerPrivate.h"

typedef void(^ANSTimerBlock)(void);

@implementation ANSTimerPrivate

#pragma mark -
#pragma mark Private

- (void)executeBlock:(NSTimer *)timer {
    ANSTimerBlock block = timer.userInfo;
    if (block) {
        block();
    }
}

@end
