
//
//  ANSProtocolObservationController.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 01.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSProtocolObservationController.h"

#import "ANSObservationController+ANSPrivate.h"

@interface ANSProtocolObservationController ()

- (void)notifyObserversWithSelector:(SEL)selector;
- (void)notifyObserversWithSelector:(SEL)selector object:(id)object;

@end

@implementation ANSProtocolObservationController

#pragma mark -
#pragma mark Private Methods

- (void)notifyOfStateChange:(NSUInteger)state withUserInfo:(id)userInfo {
    [self notifyObserversWithSelector:[self.observableObject.target selectorForState:state]
                               object:userInfo];
}

- (void)notifyOfStateChange:(NSUInteger)state {
    [self notifyOfStateChange:state withUserInfo:nil];
}

- (void)notifyObserversWithSelector:(SEL)selector object:(id)object {
    id observer = self.observer;
    if ([observer respondsToSelector:selector]) {
        [observer performSelector:selector withObject:self.observableObject.target withObject:object];
    }
}

- (void)notifyObserversWithSelector:(SEL)selector {
    [self notifyObserversWithSelector:selector object:nil];
}

@end
