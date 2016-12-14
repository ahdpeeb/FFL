//
//  ANSFBLoginContext.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 06.11.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFBUserContext.h"

@interface ANSFBLoginContext : ANSFBUserContext

- (instancetype)initWithUser:(ANSFBUser *)user
                  controller:(UIViewController *)controller;

@end
