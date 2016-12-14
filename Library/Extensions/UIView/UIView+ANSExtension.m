//
//  UIView+ANSExtension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 11.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "UIView+ANSExtension.h"

@implementation UIView (ANSExtension)

- (void)roundedLayer {
    CALayer *layer = self.layer;
    layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
    
    layer.masksToBounds = YES;
}

@end
