//
//  ANSFBLoginContext.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 06.11.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "ANSFBLoginContext.h"
#import "ANSFBConstatns.h"

#import "ANSFBUser.h"

@interface ANSFBLoginContext ()
@property (nonatomic, strong) ANSFBUser         *user;
@property (nonatomic, weak)   UIViewController  *controller;

@end

@implementation ANSFBLoginContext

- (instancetype)initWithUser:(ANSFBUser *)user
                  controller:(UIViewController *)controller
{
    self = [super init];
    self.user = user;
    self.controller = controller;
    
    return self;
}

- (void)execute {
    FBSDKLoginManager *manager = [FBSDKLoginManager new];
    ANSFBUser *user = self.user;
    [manager logInWithReadPermissions:@[kANSPublicProfile, kANSUserFriends]
                   fromViewController:self.controller
                              handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                  if (!error && !result.isCancelled) {
                                      user.ID = (NSUInteger)result.token.userID.integerValue;
                                      user.state = ANSUserDidLoadID;
                                  } else {
                                      user.state = ANSUserDidFailLoading;
                                  }
                              }];
}

@end
