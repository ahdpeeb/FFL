//
//  _ANSObservationController.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 01.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSObservableObject.h"

@interface ANSObservationController : NSObject
@property (nonatomic, weak, readonly) id                           observer;
@property (nonatomic, weak, readonly) id <ANSObservableObject>     observableObject;
@property (nonatomic, readonly, getter=isValid) BOOL    valid;

+ (instancetype)controllerWithObserver:(id)observer
                 observableObject:(id)observableObject;

- (instancetype)initWithObserver:(id)observer
                observableObject:(id)observableObject;

@end
