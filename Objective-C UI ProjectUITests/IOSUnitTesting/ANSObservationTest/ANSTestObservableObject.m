//
//  ANSObservableObjectTest.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSTestObservableObject.h"

@implementation ANSTestObservableObject

#define ASNSelectorForState(index) \
    case ANSState##index: \
        return @selector(didCallSelectorForState##index:)

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
            ASNSelectorForState(0);
            ASNSelectorForState(1);
            ASNSelectorForState(2);
            ASNSelectorForState(3);
            ASNSelectorForState(4);

        default:
            return [super selectorForState:state];
    }
}

#undef ASNSelectorForState

@end
