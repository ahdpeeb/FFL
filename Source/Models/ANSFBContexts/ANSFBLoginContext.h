//
//  ANSFBLoginContext.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 06.11.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFBUserContext.h"

#import "SRWebSocket.h"

@interface ANSFBLoginContext : ANSFBUserContext <SRWebSocketDelegate>

- (instancetype)initWithUser:(ANSFBUser *)user
                  controller:(UIViewController *)controller;

//send login info to server;
- (void)connectSocket;

@end
