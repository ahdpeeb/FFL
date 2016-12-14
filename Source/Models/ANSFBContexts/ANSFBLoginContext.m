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
#import "ANSConstants.h"
#import "ANSAppDelegate.h"
#import "ANSFBUser.h"

@interface ANSFBLoginContext ()
@property (nonatomic, strong) ANSFBUser         *user;
@property (nonatomic, weak)   UIViewController  *controller;

@property (nonatomic, strong) SRWebSocket       *webSocket;

- (void)connectSocket;
- (NSData *)JSONLoginData;

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

- (void)setWebSocket:(SRWebSocket *)webSocket {
    if (_webSocket != webSocket) {
        _webSocket = webSocket;
        
        _webSocket.delegate = self;
    }
}

- (void)connectSocket {
    NSURL *url = [NSURL URLWithString:kASNServerAdress];
    self.webSocket = [[SRWebSocket alloc] initWithURL:url];
    [self.webSocket open];
}

- (NSData *)JSONLoginData {
    NSString *userID   = @(self.user.ID).stringValue;
    NSString *devToken = [((ANSAppDelegate *)[UIApplication sharedApplication].delegate) deviceToken];
    NSDictionary *json = @{@"type": @"login",
                           @"fb_id" : userID,
                           @"device_id" : devToken ? devToken : @(0)};
    
    return [NSJSONSerialization dataWithJSONObject:json
                                           options:NSJSONWritingPrettyPrinted
                                             error:nil];
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
                                      [self connectSocket];
                                  } else {
                                      user.state = ANSUserDidFailLoading;
                                  }
                              }];
}

#pragma mark -
#pragma mark SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    [webSocket send:[self JSONLoginData]];
    [webSocket close];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"[INFO]webSocket didReceiveMessage  - %@", message);
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"[ERROR did sent login info] %@", [error localizedDescription]);
}

@end
