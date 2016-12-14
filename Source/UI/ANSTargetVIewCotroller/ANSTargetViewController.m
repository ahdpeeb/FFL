//
//  ANSTargetViewController.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 05.11.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "ANSTargetViewController.h"
#import "ANSTargetView.h"

#import "ANSFBUserDetailsContext.h"
#import "ANSLocationManagerContext.h"
#import "ANSFBLoginContext.h"
#import "ANSProtocolObservationController.h"

#import "ANSMacros.h"
#import "ANSGCD.h"

ANSViewControllerBaseViewProperty(ANSTargetViewController, ANSTargetView, targetView);

@interface ANSTargetViewController ()
@property (nonatomic, strong) ANSFBUser                         *user;
@property (nonatomic, strong) ANSProtocolObservationController  *userController;

@property (nonatomic, strong) ANSProtocolObservationController  *targetUserContoller;

@property (nonatomic, strong) ANSFBUserDetailsContext           *detailsContext;
@property (nonatomic, strong) ANSLocationManagerContext         *locationManagerContext;
@property (nonatomic, strong) ANSFBLoginContext                 *loginContext;

@end

@implementation ANSTargetViewController

#pragma mark -
#pragma mark View lifeсycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self checkIfLoginned];
}

#pragma mark -
#pragma mark Accsessors

- (void)setUser:(ANSFBUser *)user {
    if (_user != user) {
        _user = user;
        
        self.userController = [user protocolControllerWithObserver:self];
    }
}

- (void)setTargetUser:(ANSFBUser *)targetUser {
    if (_targetUser != targetUser) {
        _targetUser = targetUser;
        
        self.targetUserContoller = [targetUser protocolControllerWithObserver:self];
        self.detailsContext = [[ANSFBUserDetailsContext alloc] initWithModel:targetUser];
    }
}

- (IBAction)onAllowRequest:(UIButton *)sender {
    [self.locationManagerContext execute];
}

- (IBAction)onForbitReques:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Private methods

- (void)presentAllertController:(UIAlertController *)controller {
    ANSPerformSyncOnMainQueue(^{
        if (!self.presentedViewController) {
            [self presentViewController:controller animated:YES completion:nil];
        }
    });
}

- (void)checkIfLoginned {
    FBSDKAccessToken *token = [FBSDKAccessToken currentAccessToken];
    if (token) {
        [self.detailsContext execute];
        self.locationManagerContext = [[ANSLocationManagerContext alloc]
                                       initWithViewController:self
                                       targetUserID:@(self.targetUser.ID).stringValue
                                       userID:token.userID];
    } else {
        self.user = [ANSFBUser new];
        self.loginContext = [[ANSFBLoginContext alloc] initWithUser:self.user
                                                         controller:self];
        [self.loginContext execute];
    }
}

#pragma mark -
#pragma mark ANSUserStateObserver protocol

- (void)userDidLoadID:(ANSFBUser *)user {
    [self.detailsContext execute];
    
    self.locationManagerContext = [[ANSLocationManagerContext alloc]
                                   initWithViewController:self
                                   targetUserID:@(self.targetUser.ID).stringValue
                                   userID:@(user.ID).stringValue];
}

- (void)userDidLoadDetails:(ANSFBUser *)user {
    ANSPerformAsyncOnMainQueue(^{
        [self.targetView fillViewFromUser:user];
    });
}

@end
