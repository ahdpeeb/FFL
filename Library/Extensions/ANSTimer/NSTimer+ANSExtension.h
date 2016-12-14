//
//  NSTimer+ANSExtension.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 15.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ANSTimerBlock)(void);

@interface NSTimer (ANSExtension)

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval
                             block:(ANSTimerBlock)block
                           repeats:(BOOL)repeats;

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(ANSTimerBlock)block
                                    repeats:(BOOL)repeats; 

@end
