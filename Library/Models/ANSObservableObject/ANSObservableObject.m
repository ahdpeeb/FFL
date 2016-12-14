    //
//  ANSObservableObjectTest.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 22.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSObservableObject.h"

#import "ANSObservationController.h"
#import "ANSBlockObservationController.h"
#import "ANSProtocolObservationController.h"
#import "ANSObservationController+ANSPrivate.h"

@interface ANSObservableObject ()
@property (nonatomic, retain) NSHashTable *controllerHashTable;
@property (nonatomic, assign) BOOL        shouldNotify;
@property (nonatomic, weak)   id          target;

- (id)controllerWithClass:(Class)cls observer:(id)observer;
- (void)performBlock:(ANSExecutableBlock)block shouldNotify:(BOOL)shouldNotify;

@end

@implementation ANSObservableObject

@synthesize state = _state;

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)init {
    return [self initWithTarget:nil];
}

- (instancetype)initWithTarget:(id <ANSObservableObject>)target  {
    self = [super init];
    self.controllerHashTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
    self.shouldNotify = YES;
    self.state = NSUIntegerMax;
    self.target = target ? target : self;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setState:(NSUInteger)state withUserInfo:(id)UserInfo {
    @synchronized(self) {
        if (_state != state) {
            _state = state;
            
            [self notifyOfStateChange:state withUserInfo:UserInfo];
        }
    }
}

- (void)setState:(NSUInteger)state {
    @synchronized(self) {
        [self setState:state withUserInfo:nil];
    }
}

- (NSUInteger)state {
    @synchronized(self) {
        return _state;
    }
}

#pragma mark -
#pragma mark Private methods

- (SEL)selectorForState:(NSUInteger)state {
    @synchronized (self) {
        return NULL;
    }
}

- (void)invalidateController:(ANSObservationController *)controller {
    @synchronized(self) {
        [self.controllerHashTable removeObject:controller];
    }
}

- (id)controllerWithClass:(Class)cls observer:(id)observer {
    @synchronized(self) {
        ANSObservationController *controller = [cls controllerWithObserver:observer
                                                          observableObject:self];
        
        [self.controllerHashTable addObject:controller];
        
        return controller;
    }
}

- (void)notifyOfStateChange:(NSUInteger)state withUserInfo:(id)UserInfo {
    @synchronized(self) {
        if (self.shouldNotify) {
            for (ANSObservationController *controller in self.controllerHashTable) {
                [controller notifyOfStateChange:state withUserInfo:UserInfo];
            }
        }
    }
}

- (void)notifyOfStateChange:(NSUInteger)state {
    @synchronized(self) {
        [self notifyOfStateChange:state withUserInfo:nil];
    }
}

- (void)performBlock:(ANSExecutableBlock)block shouldNotify:(BOOL)shouldNotify {
    @synchronized(self) {
        BOOL value = self.shouldNotify;
        self.shouldNotify = shouldNotify;
        
        block();
        
        self.shouldNotify = value;
    }
}

#pragma mark -
#pragma mark Public methods

- (BOOL)isObservedByObject:(id)object {
    @synchronized(self) {
        BOOL value = NO;
        for (ANSObservationController *controler in self.controllerHashTable) {
            value = [object isEqual:controler.observer];
            if (value) {
                break;
            }
        }

        return value;
    }
}

- (ANSProtocolObservationController *)protocolControllerWithObserver:(id)observer {
    Class resultClass = [ANSProtocolObservationController class];
    for (ANSObservationController *controler in self.controllerHashTable) {
        if (controler.observer == observer && [controler isMemberOfClass:resultClass]) {
            return (ANSProtocolObservationController *)controler;
        }
    }
    
    return [self controllerWithClass:[ANSProtocolObservationController class]
                                observer:observer];
}

- (ANSBlockObservationController *)blockControllerWithObserver:(id)observer {

    
    return [self controllerWithClass:[ANSBlockObservationController class]
                                observer:observer];
}

- (void)performBlockWithNotification:(ANSExecutableBlock)block {
    [self performBlock:block shouldNotify:YES];
}

- (void)performBlockWithoutNotification:(ANSExecutableBlock)block {
    [self performBlock:block shouldNotify:NO];
}

#pragma mark -
#pragma mark NSCopying protocol

- (id)copyWithZone:(nullable NSZone *)zone {
    ANSObservableObject *copy = [[self class] new];
    copy.controllerHashTable = [self.controllerHashTable copyWithZone:zone];
    
    return copy;
}

@end
