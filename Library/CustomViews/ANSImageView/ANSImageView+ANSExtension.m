//
//  ANSImageView+ANSExtension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSImageView+ANSExtension.h"

@implementation ANSImageView (ANSExtension)

- (void)roundWithBorderColor:(UIColor *)color
                 borderWidth:(CGFloat)width
{
    UIImageView *image = self.contentImageView;
    CGRect frame = self.frame;
    CGFloat dimension = MIN(CGRectGetHeight(frame), CGRectGetHeight(frame));
    frame.origin = CGPointMake((CGRectGetWidth(frame) - dimension) / 2.0,
                               (CGRectGetHeight(frame) - dimension) / 2.0);
    
    frame.size = CGSizeMake(dimension, dimension);
    image.frame = frame;
    
    image.clipsToBounds = YES;
    CALayer *layer = image.layer;
    layer.cornerRadius = dimension / 2;
    layer.borderColor = [UIColor blackColor].CGColor;
    layer.borderWidth = width;
}

@end
