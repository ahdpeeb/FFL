//
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSFBUser.h"

#import "NSString+ANSExtension.h"

#import "ANSImageModel.h"

static NSString * const kANSIDKey        = @"kANSIDKey";
static NSString * const kANSFirstNameKey = @"kANSFirstNameKey";
static NSString * const kANSLastNameKey  = @"kANSLastNameKey";
static NSString * const kANSImageUrlKey  = @"kANSImageUrlKey";

@interface ANSFBUser ()

@end

@implementation ANSFBUser

@dynamic fullName;
@dynamic imageModel; 

+ (ANSFBUser *)allocWithID:(NSUInteger)ID {
    ANSFBUser *user = [[ANSFBUser alloc] init];
    user.ID = ID;
    
    return user;
}

#pragma mark -
#pragma mark Accsessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.lastName, self.firstName];
}

- (ANSImageModel *)imageModel {
    return [ANSImageModel imageFromURL:self.imageUrl];
}

#pragma mark -
#pragma mark Private Methods

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case ANSUserDidLoadID:
            return @selector(userDidLoadID:);
            
        case ANSUserDidLoadBasic:
            return @selector(userDidLoadBasic:);
            
        case ANSUserDidLoadDetails:
            return @selector(userDidLoadDetails:);
            
        default:
            return [super selectorForState:state];
    }
}

#pragma mark -
#pragma mark NSCoding protocol

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.ID forKey:kANSIDKey];    
    [aCoder encodeObject:self.firstName forKey:kANSFirstNameKey];
    [aCoder encodeObject:self.lastName forKey:kANSLastNameKey];
    [aCoder encodeObject:self.imageUrl forKey:kANSImageUrlKey];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.ID = [aDecoder decodeIntegerForKey:kANSIDKey];
        self.firstName = [aDecoder decodeObjectForKey:kANSFirstNameKey];
        self.lastName = [aDecoder decodeObjectForKey:kANSLastNameKey];
        self.imageUrl = [aDecoder decodeObjectForKey:kANSImageUrlKey];
    }
    
    return self;
}

#pragma mark -
#pragma mark NSCopying protocol

- (ANSFBUser *)copyWithZone:(NSZone *)zone {
    ANSFBUser* copy = [[self class] new];
    if (copy) {
        copy.ID = self.ID;
        copy.firstName = self.firstName;
        copy.lastName = self.lastName;
        copy.imageUrl = self.imageUrl;
    }
    
    return copy;
}

@end
