//
//  ANSInternetImageModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 14.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSInternetImageModel.h"

#import "ANSImageModel.h"
#import "ANSImageModel+ANSPrivatExtension.h"

#import "ANSMacros.h"
#import "ANSRandom.h"
#import "NSFileManager+ANSExtension.h"
#import "UIImage+ANSExtension.h"

@interface ANSImageModel ()
@property (nonatomic, strong) NSURLSessionTask *task;
@property (nonatomic, readonly) NSURL *localURL;

- (BOOL)isImageCached;
- (void)removeCorruptedFile;
- (UIImage *)imageFromUrl:(NSURL *)url;
- (void)loadImage;

@end

@implementation ANSInternetImageModel

@dynamic localURL;

@synthesize task = _task;

#pragma mark -
#pragma mark Initialization and deallocation 

- (void)dealloc {
    self.task = nil;
}

#pragma mark -
#pragma mark Accsessors

- (NSURL *)localURL {
    return [NSURL fileURLWithPath:self.imagePath];
}

- (void)setTask:(NSURLSessionTask *)task {
    if (_task != task) {
        
        [_task cancel];
        _task = task;
        [_task resume];
    }
}

#pragma mark -
#pragma mark Privat methods

- (BOOL)isImageCached {
    return [[NSFileManager defaultManager] fileExistsAtPath:self.imagePath];
}

- (void)removeCorruptedFile {
    if ([self isImageCached]) {
        BOOL isRemoved = [[NSFileManager defaultManager] removeItemAtPath:self.imagePath error:nil];
        
        isRemoved ? NSLog(@"Removed [OK]") : NSLog(@"Removed [ERROR]");
    }
}

- (UIImage *)imageFromUrl:(NSURL *)url {
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
}

- (void)performLoading {
    if ([self isImageCached]) {
        UIImage *image = [self imageFromUrl:self.localURL];
        if (image) {
            [super finishLoadingWithImage:image];
            
            return;
        }
        
        [self removeCorruptedFile];
    }

    [self loadImage];
}

- (void)loadImage {
    NSURLSession *session = [NSURLSession sharedSession];
    self.task = [session downloadTaskWithURL:self.url
                           completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                               if (error) {
                                   self.state = ANSLoadableModelDidFailLoading;
                                   return;
                               }
                               
                               NSError *moveError = nil;
                               [[NSFileManager defaultManager] moveItemAtURL:location
                                                                       toURL:self.localURL
                                                                       error:&moveError];
                               
                               NSURL *imageUrl = moveError ? location : self.localURL;
                               self.image = [self imageFromUrl:imageUrl];
                           }];
}

@end
