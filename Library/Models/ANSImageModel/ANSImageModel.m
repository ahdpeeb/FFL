//
//  ANSImageModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 29.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSImageModel.h"

#import "ANSLocalImageModel.h"
#import "ANSInternetImageModel.h"
#import "ANSImageModel+ANSPrivatExtension.h"
#import "NSFileManager+ANSExtension.h"

#import "ANSMacros.h"

@implementation ANSImageModel

@dynamic imageName;
@dynamic imagePath;

#pragma mark -
#pragma mark Class methods

+ (instancetype)imageFromURL:(NSURL *)url {
    @synchronized(self) {
        ANSCacheStorage *cache = [ANSCacheStorage sharedStorage];
        
        id model = [cache objectForKey:url];
        if (model) {
            return model;
        }
        
        Class cls = url.fileURL ? [ANSLocalImageModel class] : [ANSInternetImageModel class];
        model = [[cls alloc] initWithURL:url];
        
        [cache setObject:model forKey:url];
        
        return model;
    }
}

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)initWithURL:(NSURL *)url {
    ANSInvalidIdentifierExceprionRaise(ANSImageModel);
    self = [super init];
    self.url = url;
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
        
        self.state = image ? ANSLoadableModelDidLoad : ANSLoadableModelDidFailLoading;
    }
}

- (NSString *)imageName {
    NSCharacterSet *characterSet = [NSCharacterSet URLUserAllowedCharacterSet];
    
    return [self.url.absoluteString stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
}

- (NSString *)imagePath {
    return [[NSFileManager documentDirectoryPath] stringByAppendingPathComponent:self.imageName];
}

@end