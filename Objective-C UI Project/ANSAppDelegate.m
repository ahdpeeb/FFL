//
//  ANSAppDelegate.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 19.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "ANSAppDelegate.h"

#import "ANSLoginViewController.h"
#import "ANSTargetViewController.h"
#import "ANSFBUser.h"

#import "ANSFriendListViewController.h"
#import "ANSFBUser.h"
#import "ANSChangeModel.h"

#import "NSJSONSerialization+Extension.h"
#import "ANSJSONRepresentation.h"

#import "ANSGCD.h"

@interface ANSAppDelegate ()
- (void)hanleNotificationWithUserInfo:(NSDictionary <ANSJSONRepresentation> *)userInfo;

@end

@implementation ANSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        // root controllers
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
   
    ANSLoginViewController *controller  = [ANSLoginViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:controller];;
    window.rootViewController = navigationController;
    [window makeKeyAndVisible];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    [application registerForRemoteNotifications];
    

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
     [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"applicationWillTerminate");
}

#pragma mark -
#pragma mark faceBook

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

#pragma mark -
#pragma mark -- pushNotificationDelegate

- (void)                  application:(UIApplication *)application
  didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

-(void)                                  application:(UIApplication*)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    self.deviceToken = [[[[deviceToken description]
                            stringByReplacingOccurrencesOfString:@"<" withString:@""]
                           stringByReplacingOccurrencesOfString:@">" withString:@""]
                          stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(void)                                  application:(UIApplication*)application
    didFailToRegisterForRemoteNotificationsWithError:(NSError*)error {
    NSLog(@"NSError - %@", [error description]);
}

- (void)                 application:(UIApplication *)application
        didReceiveRemoteNotification:(NSDictionary <ANSJSONRepresentation> *)userInfo
              fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    UIApplicationState state = application.applicationState;
    if (state == UIApplicationStateActive) {
        [self hanleNotificationWithUserInfo:userInfo];
    } else if (state == UIApplicationStateBackground) {
        NSLog(@"UIApplicationStateBackground");
        [self hanleNotificationWithUserInfo:userInfo];
    } else if (state == UIApplicationStateInactive) {
        NSLog(@"UIApplicationStateInactive");
        [self hanleNotificationWithUserInfo:userInfo];
    }
    
    completionHandler(UIBackgroundFetchResultNoData);
}

#pragma mark -
#pragma mark Private methods

- (void)hanleNotificationWithUserInfo:(NSDictionary <ANSJSONRepresentation> *)userInfo {
    UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
    
    if ([navController.topViewController isKindOfClass:[ANSTargetViewController class]]) {
        return;
    }
    
    [navController popToRootViewControllerAnimated:YES];
    NSDictionary *parsedInfo = [userInfo JSONRepresentation];
    NSString *ID = parsedInfo[@"push_data"][@"userInfo"][@"user_id"];
    NSUInteger IDNumber = (NSUInteger)ID.integerValue;
    ANSFBUser *targetUser = [ANSFBUser allocWithID:IDNumber];
    ANSTargetViewController *targetController = [ANSTargetViewController new];
    targetController.targetUser = targetUser;
    [navController pushViewController:targetController animated:YES];
}

@end
