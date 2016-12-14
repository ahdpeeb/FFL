//
//  UIScreen+ANSExtension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 18.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "UIScreen+ANSExtension.h"

@implementation UIScreen (ANSExtension)

+ (CGRect)screenBounds {
    return [UIScreen mainScreen].bounds;
}

@end
