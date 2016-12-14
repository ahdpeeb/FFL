//
//  ANSObservationTest.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "Kiwi.h"

#import "ANSTestObservableObject.h"
#import "ANSTestObserver.h"
#import "ANSObservationController.h"

SPEC_BEGIN(ANSNotificationTest)

describe(@"ANSObservableObject", ^{
    registerMatchers(@"BG"); // Registers BGTangentMatcher, BGConvexMatcher, etc.
    
    __block ANSTestObservableObject *observableObject = nil;
    __block ANSTestObserver *observer = nil;
    __block id controller = nil;
        
    context(@"a state the component is in", ^{
        beforeAll(^{
            observer = [ANSTestObserver new];
            observableObject = [ANSTestObservableObject new];
            controller = [observableObject protocolControllerWithObserver:observer];
        });
        
        it(@"objects should not be nil", ^{
            [[observer should] beMemberOfClass:[ANSTestObserver class]];
            [[observer shouldNot] beNil];
            [[controller shouldNot] beNil];
            [[observableObject shouldNot] beNil];
        });
        
        it(@"observer should conformsToProtocol ANSObservationTestProtocol", ^{
            [[observer should] conformToProtocol:@protocol(ANSNotificationTest)];
        });
        
        it(@"observer should respond to selectors", ^{
            [[observer should] respondToSelector:@selector(didCallSelectorForState0:)];
            [[observer should] respondToSelector:@selector(didCallSelectorForState1:)];
            [[observer should] respondToSelector:@selector(didCallSelectorForState2:)];
            [[observer should] respondToSelector:@selector(didCallSelectorForState3:)];
            [[observer should] respondToSelector:@selector(didCallSelectorForState4:)];
        });
        
        it(@"should notify only states performed in performBlockWithNotification", ^{
            [observableObject performBlockWithNotification:^{
                [[observer should] receive:@selector(didCallSelectorForState4:)];
                observableObject.state = ANSState4;
    
                [observableObject performBlockWithoutNotification:^{
                    [[observer shouldNot] receive:@selector(didCallSelectorForState3:)];
                    observableObject.state = ANSState3;
                    
                    [observableObject performBlockWithNotification:^{
                        [[observer should] receive:@selector(didCallSelectorForState2:)];
                        observableObject.state = ANSState2;
                     }];
                    
                    [[observer shouldNot] receive:@selector(didCallSelectorForState1:)];
                    observableObject.state = ANSState1;
                }];
                
                [[observer should] receive:@selector(didCallSelectorForState0:)];
                observableObject.state = ANSState0;
            }];
        });

        
        afterAll(^{ // Occurs once
        });
        
        specify(^{
            [[observer shouldNot] beNil];
            [[controller shouldNot] beNil];
            [[observableObject shouldNot] beNil];
        });
        
        context(@"inner context", ^{
            it(@"does another thing", ^{
            });
        });
    });
});

SPEC_END
