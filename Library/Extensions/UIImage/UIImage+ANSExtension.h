//
//  UIImage+ANSExtension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 11.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ANSImageFormat) {
    ANSImageFormatPNG,
    ANSImageFormatJPEG,
};

@interface UIImage (ANSExtension)

- (NSData *)imageDataWithFormat:(ANSImageFormat)format
                        quality:(CGFloat)quality; 

//save UIIimage object with PNG Representation to Document directory
- (NSString *)pathToSavedPNGWithName:(NSString *)name;

//save UIIimage object with JPEG Representation to Document directory
- (NSString *)pathToSavedJPEGWithName:(NSString *)name quality:(CGFloat)quality;

@end
