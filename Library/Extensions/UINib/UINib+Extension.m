//
//  UINib+Extension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 27.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "UINib+Extension.h"

@implementation UINib (Extension)

+ (UINib *)nibWithClass:(Class)cls {
   return [self nibWithNibName:NSStringFromClass(cls) bundle:nil];
}

- (id)objectWithClass:(Class)cls {
    NSArray *elements = [self instantiateWithOwner:nil options:nil];
    for (id element in elements) {
        if ([element isMemberOfClass:cls]) {
            return element;
        }
    }
    
    return nil;
}

@end
