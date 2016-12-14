//
//  ANSObservableObjectTest.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSObservableObject.h"

@class ANSTestObservableObject; 

@protocol ANSNotificationTest <NSObject>

#define ANSNotificationTestSelector(index) \
- (void)didCallSelectorForState##index:(id)observableObject

ANSNotificationTestSelector(0);
ANSNotificationTestSelector(1);
ANSNotificationTestSelector(2);
ANSNotificationTestSelector(3);
ANSNotificationTestSelector(4);

#undef ANSNotificationTestSelector

@end

typedef NS_ENUM(NSUInteger, ANSState) {
    ANSState0,
    ANSState1,
    ANSState2,
    ANSState3,
    ANSState4,
};

@interface ANSTestObservableObject : ANSObservableObject

@end
