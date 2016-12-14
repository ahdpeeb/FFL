//
//  ANSFBFriendsContext.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 25.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFBFriendsContext.h"

#import "ANSFBUser.h"
#import "ANSFBFriends.h"
#import "ANSFBConstatns.h"

#import "NSFileManager+ANSExtension.h"
#import "ANSObservableObjectPtotocol.h"

@interface ANSFBFriendsContext ()

- (NSArray *)friendsFromResult:(NSDictionary <ANSJSONRepresentation> *)result;

@end

@implementation ANSFBFriendsContext

#pragma mark -
#pragma mark Private Methods (reloaded)

- (NSString *)graphPath {
    ANSFBUser *user = self.user;
    return [NSString stringWithFormat:@"%lu/%@", (long)user.ID, kANSFriends];
}

- (NSString *)HTTPMethod {
    return kANSGet;
}

- (NSDictionary *)parametres {
    return @{kANSFields:[NSString stringWithFormat:@"%@, %@, %@, %@", kANSID,
                                                                      kANSFirstName,
                                                                      kANSLastName,
                                                                      kANSLargePicture]};
}

- (BOOL)isModelLoadedWithState:(NSUInteger)state {
    ANSFBFriends *friends = self.model;
    if (friends.state == state) {
        [friends notifyOfStateChange:state];
        
        return YES;
    }
    
    return NO;
}

- (BOOL)isModelLoaded {
    return [self isModelLoadedWithState:ANSLoadableModelDidLoad];
}

- (void)fillModelFromResult:(NSDictionary <ANSJSONRepresentation> *)result; {
    ANSFBFriends *friends = self.model;
    [friends performBlockWithoutNotification:^{
        NSArray *frinds = [self friendsFromResult:result];
        [friends addObjectsInRange:frinds];
    }];
    
    friends.state = ANSLoadableModelDidLoad;
}

#pragma mark -
#pragma mark Private methods

- (NSArray *)friendsFromResult:(NSDictionary <ANSJSONRepresentation> *)result {
    NSMutableArray *mutableUsers = [NSMutableArray new];
    NSDictionary *parsedResult = [result JSONRepresentation];
    
    NSArray *dataUsers = parsedResult[kANSData];
    for (NSDictionary *dataUser in dataUsers) {
        ANSFBUser *fbUser = [self userFromResult:dataUser];
        [mutableUsers addObject:fbUser];
    }
    
    return [mutableUsers copy];
}

- (ANSFBUser *)userFromResult:(NSDictionary *)result {
    ANSFBUser *fbUser = [ANSFBUser new];
    fbUser.ID = ((NSString *)result[kANSID]).doubleValue;
    fbUser.firstName = result[kANSFirstName];
    fbUser.lastName = result[kANSLastName];
    
    NSDictionary * dataPicture = result[kANSPicture][kANSData] ;
    NSString *URLString = dataPicture[kANSURL];
    fbUser.imageUrl = [NSURL URLWithString:URLString];
    
    return fbUser;
}

@end
