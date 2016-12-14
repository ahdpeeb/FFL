//
//  ANSImageModel_ANSPrivatExtension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 14.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSImageModel.h"

#import "ANSCacheStorage.h"

@interface ANSImageModel ()
@property (nonatomic, strong)       NSURL           *url;
@property (nonatomic, strong)       UIImage         *image;
@property (nonatomic, strong)       ANSCacheStorage *cache;

@property (nonatomic, readonly)     NSString        *imageName;
@property (nonatomic, readonly)     NSString        *imagePath;

@end
