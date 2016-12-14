//
//  ANSLocalImageModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 14.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSLocalImageModel.h"

#import "ANSImageModel+ANSPrivatExtension.h"

@implementation ANSLocalImageModel

#pragma mark -
#pragma mark Privat methods

- (void)finishLoadingWithImage:(UIImage *)image {
    self.image = image;
}

- (void)performLoading {
    UIImage *image = [UIImage imageWithContentsOfFile:self.imagePath];
    [self finishLoadingWithImage:image];
}
    
@end
