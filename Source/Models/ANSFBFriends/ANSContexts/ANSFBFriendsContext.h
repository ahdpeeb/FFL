//
//  ANSFBFriendsContext.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 25.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFBUserContext.h"

@class ANSFBUser;

@interface ANSFBFriendsContext : ANSFBUserContext
@property (nonatomic, strong) ANSFBUser *user;

//this method intended for subclass
- (ANSFBUser *)userFromResult:(NSDictionary *)result;

@end
