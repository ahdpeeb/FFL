//
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "ANSObservableObject.h"

@class ANSFBUser;
@class ANSImageModel;

@protocol ANSUserStateObserver <NSObject>

@optional;
- (void)userDidLoadID:(ANSFBUser *)user;
- (void)userDidLoadBasic:(ANSFBUser *)user;
- (void)userDidLoadDetails:(ANSFBUser *)user;
- (void)userDidFailLoading:(ANSFBUser *)user;

@end

typedef NS_ENUM(NSUInteger, ANSUserState) {
    ANSUserUnloaded,
    ANSUserDidFailLoading,
    ANSUserDidLoadID,
    ANSUserDidLoadBasic,
    ANSUserDidLoadDetails,
    
    ANSUserStateCount,
};

@interface ANSFBUser : ANSObservableObject  <NSCoding, NSCopying>
@property (nonatomic, assign)    NSInteger      ID;
@property (nonatomic, copy)      NSString       *firstName;
@property (nonatomic, copy)      NSString       *lastName;
@property (nonatomic, copy)      NSString       *gender;
@property (nonatomic, strong)    NSURL          *imageUrl;

@property (nonatomic, readonly)  ANSImageModel   *imageModel;
@property (nonatomic, readonly)  NSString        *fullName;

+ (ANSFBUser *)allocWithID:(NSUInteger)ID;

@end
