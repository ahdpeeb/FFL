//
//  UIImage+ANSExtension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 11.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/NSPathUtilities.h>
#import <Foundation/NSURL.h>

#import "UIImage+ANSExtension.h"

#import "NSFileManager+ANSExtension.h"

@implementation UIImage (ANSExtension)

#pragma mark -
#pragma mark Private methods

- (NSString *)extensionFromFormat:(ANSImageFormat)format {
    switch (format) {
        case ANSImageFormatPNG: return @"png";
        case ANSImageFormatJPEG: return @"jpeg";
            
        default:
            return nil;
    }
}

- (NSString *)pathOfSavedImageName:(NSString *)name
                           quality:(CGFloat)quality
                            format:(ANSImageFormat)format
{
    NSString *correctName = [[name stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]] lowercaseString];
    NSString *fullName = [correctName stringByAppendingPathExtension:[self extensionFromFormat:format]];
    
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSString *imagePath = [filemanager pathToFile:fullName inSearchPathDirectory:NSDocumentDirectory];
    if ([filemanager fileExistsAtPath:imagePath]) {
        NSLog(@"[ERROR] This file already exist");
        
        return nil;
    }
    
    NSData *imageData = [self imageDataWithFormat:format quality:quality];
    BOOL isSuccsess = [imageData writeToFile:imagePath atomically:YES];
    
    return isSuccsess ? imagePath : nil;
}

#pragma mark -
#pragma mark Public methods

- (NSData *)imageDataWithFormat:(ANSImageFormat)format
                        quality:(CGFloat)quality {
    NSData *imageData = nil;
    if (format == ANSImageFormatJPEG) {
        imageData = UIImageJPEGRepresentation(self, quality);
    } else if (format == ANSImageFormatPNG) {
        imageData = UIImagePNGRepresentation(self);
    }
    
    return imageData;
}

- (NSString *)pathToSavedJPEGWithName:(NSString *)name quality:(CGFloat)quality {
   return [self pathOfSavedImageName:name quality:quality format:ANSImageFormatJPEG];
}

- (NSString *)pathToSavedPNGWithName:(NSString *)name {
   return [self pathOfSavedImageName:name quality:0 format:ANSImageFormatPNG];
}


@end
