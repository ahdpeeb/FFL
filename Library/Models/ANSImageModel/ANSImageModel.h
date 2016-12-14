//
//  ANSImageModel.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 29.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSLoadableModel.h"

@interface ANSImageModel : ANSLoadableModel
@property (nonatomic, readonly)    NSURL        *url;
@property (nonatomic, readonly)    UIImage      *image;

+ (instancetype)imageFromURL:(NSURL *)url;

@end
