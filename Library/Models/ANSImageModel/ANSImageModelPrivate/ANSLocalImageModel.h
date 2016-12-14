//
//  ANSLocalImageModel.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 14.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSImageModel.h"

@interface ANSLocalImageModel : ANSImageModel
// Method intended for subclasses
- (void)finishLoadingWithImage:(UIImage *)image;

@end
