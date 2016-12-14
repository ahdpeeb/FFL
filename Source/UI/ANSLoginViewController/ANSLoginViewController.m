//
//  ANSLoginViewController.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 20.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "ANSLoginViewController.h"

#import "ANSLoginView.h"
#import "ANSFBUser.h"
#import "ANSFriendListViewController.h"
#import "ANSLocationManagerContext.h"
#import "ANSFBLoginContext.h"
#import "ANSConstants.h"

#import "UIViewController+ANSExtension.h"
#import "ANSProtocolObservationController.h"

#import "ANSMacros.h"
#import "ANSGCD.h"

ANSViewControllerBaseViewProperty(ANSLoginViewController, ANSLoginView, loginView);

@interface ANSLoginViewController ()
@property (nonatomic, strong) ANSFBUser                             *user;
@property (nonatomic, strong) ANSProtocolObservationController      *contoller;

@property (nonatomic, strong) ANSFBLoginContext                     *loginContext;

- (void)autoLogin;

@end

@implementation ANSLoginViewController

#pragma mark -
#pragma mark View lifecycl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.user = [ANSFBUser new];
    [self autoLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Accsessors

- (void)setUser:(ANSFBUser *)user {
    if (_user != user) {
        _user = user;
        
        self.contoller = [user protocolControllerWithObserver:self];
    }
}

#pragma mark -
#pragma mark Buttons actions

- (IBAction)onLogin:(UIButton *)sender {
    self.loginContext = [[ANSFBLoginContext alloc] initWithUser:self.user
                                                     controller:self];
    [self.loginContext execute];
}

- (IBAction)onFriends:(UIButton *)sender {
    ANSFriendListViewController *controller = [ANSFriendListViewController viewController];
    controller.user = self.user;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark Private methods

- (void)autoLogin {
    FBSDKAccessToken *token = [FBSDKAccessToken currentAccessToken];
    if (token) {
        ANSFBUser *user = self.user;
        self.loginContext = [[ANSFBLoginContext alloc] initWithUser:self.user
                                                         controller:self];
        
        user.ID = (NSUInteger)[token.userID integerValue];
        user.state = ANSUserDidLoadID;
    }
}

#pragma mark -
#pragma mark ANSUserStateObserver ptotocol

- (void)userDidLoadID:(ANSFBUser *)user {
    ANSPerformAsyncOnMainQueue(^{
        [self.loginContext connectSocket];
        self.loginView.loginButton.hidden = YES;
        self.loginView.friendsButton.hidden = NO;
    });
}

@end
