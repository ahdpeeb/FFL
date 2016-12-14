//
//  ANSRandom.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 02.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSRandom.h"

NSInteger ANSRandomIntegerWithValues(NSInteger min, NSInteger max) {
    ANSIntegerRange range = ANSIntegerRangeCreate(min, max);
    
    return range.min + (arc4random_uniform((u_int32_t)(range.max - range.min))) ;
}

NSUInteger ANSRandomUnsignedInteget(NSUInteger value) {
    return ANSRandomIntegerWithValues(0, value);
}

BOOL ANSRandomBool(void) {
    return arc4random_uniform(2);
}

