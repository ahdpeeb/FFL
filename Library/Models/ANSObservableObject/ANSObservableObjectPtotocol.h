//
//  ANSObservableObjectPtotocol.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 08.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ANSProtocolObservationController;
@class ANSBlockObservationController;
@class ANSObservationController;

typedef void(^ANSExecutableBlock)(void);

@protocol ANSObservableObject <NSObject>

@optional

@property (nonatomic, assign)         NSUInteger state;
@property (nonatomic, weak, readonly) id         target;

- (void)setState:(NSUInteger)state withUserInfo:(id)UserInfo;

//Use this methods for set observation with protocol.
/*Observable object will create ObservationController (for each observer), which will notify
 observer about state changes in observable object*/
//in you subclass you need to define "selectorForState" method
- (ANSProtocolObservationController *)protocolControllerWithObserver:(id)observer;

//Use this methods for set observation with block.
/*Observable object will create ObservationController (for each observer), which will notify
 observer about state changes in observable object*/
- (ANSBlockObservationController *)blockControllerWithObserver:(id)observer;

- (BOOL)isObservedByObject:(id)object;

- (void)performBlockWithNotification:(ANSExecutableBlock)block;
- (void)performBlockWithoutNotification:(ANSExecutableBlock)block;

- (void)invalidateController:(ANSObservationController *)controller;
#pragma mark -
#pragma mark Private declaration

//It must be determined directly in observable object.
//This method is intended for subclasses. Never call it directly.
- (SEL)selectorForState:(NSUInteger)state;

//This method is intended for subclasses. Never call it directly.
- (void)notifyOfStateChange:(NSUInteger)state;
- (void)notifyOfStateChange:(NSUInteger)state withUserInfo:(id)UserInfo;

@end
