//
//  _ANSObservationController.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 01.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSObservationController.h"

#import "ANSObservationController+ANSPrivate.h"
#import "ANSObservableObject+ANSPrivate.h"

static NSString * const kANSAllocationException = @"You never should create observationController object";
  
@implementation ANSObservationController

@dynamic valid;

#pragma mark -
#pragma mark Class methods

+ (instancetype)controllerWithObserver:(id)observer
                 observableObject:(id)observableObject
{
    return [[self alloc] initWithObserver:observer observableObject:observableObject];
}

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    [_observableObject invalidateController:self];
}

- (instancetype)init {
    NSAssert([self class] != [ANSObservationController class], kANSAllocationException);
    
    self = [super init];
    
    return self;
}

- (instancetype)initWithObserver:(id)observer
                observableObject:(id)observableObject
{
    NSAssert(observer, NSInvalidArgumentException);
    NSAssert(observableObject, NSInvalidArgumentException);
    
    self = [self init];
    if (self) {
        _observer = observer;
        _observableObject = observableObject;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (void)setObservableObject:(ANSObservableObject *)observableObject {
    if (!_observableObject) {
        [_observableObject invalidateController:self];
    }
    
    _observableObject = observableObject;
}

- (BOOL)isValid {
    return self.observableObject || self.observer;
}

#pragma mark -
#pragma mark public

- (NSUInteger)hash {
    return [[self class] hash] ^ [self.observer hash] ^ [self.observableObject hash];
}

- (BOOL)isEqual:(ANSObservationController *)controller {
    if (!controller) {
        return NO;
    }
    
    if (controller == self) {
        return YES;
    }
    
    if ([self isMemberOfClass:[controller class]]) {
        return controller.observer == self.observer
            && controller.observer == self.observableObject;
    }
    
    return NO;
}

#pragma mark -
#pragma mark ANSObservationController+ANSPrivateExtension.h

- (void)notifyOfStateChange:(NSUInteger)state {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)notifyOfStateChange:(NSUInteger)state withUserInfo:(id)UserInfo {
    [self doesNotRecognizeSelector:_cmd];
}

@end
