//
//  NSBundle+ANSExtenison.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 18.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKitDefines.h>
#import <UIKit/UIKit.h>
#import <UIKit/UINibLoading.h>
#import "NSBundle+ANSExtenison.h"

@implementation NSBundle (ANSExtenison)

+ (id)objectWithClass:(Class)cls owner:(id)owner {
    NSString *string = NSStringFromClass(cls);
    NSArray *elements = [[NSBundle mainBundle] loadNibNamed:string owner:owner options:nil];
    for (id element in elements) {
        if ([element isMemberOfClass:cls]) {
            return element;
        }
    }
    
    return nil;
}

@end
