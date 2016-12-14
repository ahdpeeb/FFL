//
//  ANSTestObserver.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSTestObserver.h"

#import "ANSTestObservableObject.h"

@interface ANSTestObserver () <ANSNotificationTest>

@end

@implementation ANSTestObserver

#define ANSCallBackSelector(index) \
    - (void)didCallSelectorForState##index:(id)observableObject { \
    NSLog(@"didCallForState" "#index"); \
    } \

ANSCallBackSelector(0);
ANSCallBackSelector(1);
ANSCallBackSelector(2);
ANSCallBackSelector(3);
ANSCallBackSelector(4);

#undef ANSCallBackSelector

@end
