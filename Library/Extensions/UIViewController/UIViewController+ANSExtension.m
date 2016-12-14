//
//  UIViewController+ANSExtension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 17.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "UIViewController+ANSExtension.h"

@implementation UIViewController (ANSExtension)

+ (id)viewController {
    @synchronized (self) {
        return [[self alloc] initWithNibName:[self nibName] bundle:nil];
    }
}

+ (NSString *)nibName {
    @synchronized (self) {
          return NSStringFromClass([self class]);
    }
}

@end
