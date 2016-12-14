//
//  ANSLocationManagerContext.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 17.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

#import "SRWebSocket.h"

@class ANSTargetViewController;

@interface ANSLocationManagerContext : NSObject <SRWebSocketDelegate, CLLocationManagerDelegate>

- (instancetype)initWithViewController:(ANSTargetViewController *)controller
                          targetUserID:(NSString *)targetUserID
                                userID:(NSString *)userID;

- (void)askAutorizationStatus;

- (void)execute;
- (void)cancel;

@end
