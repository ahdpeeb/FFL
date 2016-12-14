//
//  ANSUserLoadContext.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 23.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import "ANSFBUserDetailsContext.h"

#import "ANSFBUser.h"
#import "ANSFBConstatns.h"

@implementation ANSFBUserDetailsContext

#pragma mark -
#pragma mark Private Methods (reloaded);

- (NSString *)graphPath; {
    NSUInteger value = ((ANSFBUser *)self.model).ID;
    return [NSString stringWithFormat:@"%ld", (unsigned long)value];
}

- (NSString *)HTTPMethod {
    return kANSGet;
}

- (NSDictionary *)parametres {
    return @{kANSFields:[NSString stringWithFormat:@"%@, %@, %@",
                         kANSHometown,
                         kANSGender,
                         kANSEmail]};
}

- (BOOL)isModelLoaded {
    return [self isModelLoadedWithState:ANSUserDidLoadDetails];
}

- (void)fillModelFromResult:(NSDictionary *)result {
    ANSFBUser *user = [super userFromResult:result];
    user.gender = result[kANSGender];
    id email = result[kANSEmail];
    user.email = email;
    
    user.state = ANSUserDidLoadDetails;
}

@end
