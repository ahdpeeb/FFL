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
    return @{kANSFields:[NSString stringWithFormat:@"%@, %@, %@, %@, %@",
                         kANSGender,
                         kANSID,
                         kANSFirstName,
                         kANSLastName,
                         kANSLargePicture]};
}

- (BOOL)isModelLoaded {
    return [self isModelLoadedWithState:ANSUserDidLoadDetails];
}

- (void)fillModelFromResult:(NSDictionary <ANSJSONRepresentation> *)result {
    NSDictionary *parsedResult = [result JSONRepresentation];
    ANSFBUser *user = (ANSFBUser *)self.model;
    [super fillUser:user fromResult:parsedResult];
    user.gender = parsedResult[kANSGender];
    
    user.state = ANSUserDidLoadDetails;
}

@end
