//
//  ANSObservableObjectTest.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 22.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSObservableObjectPtotocol.h"

@class ANSObservationController;
@class ANSProtocolObservationController;
@class ANSBlockObservationController;

@interface ANSObservableObject : NSObject <NSCopying, ANSObservableObject>

- (instancetype)initWithTarget:(id <ANSObservableObject>)target NS_DESIGNATED_INITIALIZER;

@end
