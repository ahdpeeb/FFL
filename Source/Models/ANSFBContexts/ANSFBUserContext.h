//
//  ANSContextModel.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 23.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSFBUser.h"

#import "ANSJSONRepresentation.h"

@interface ANSFBUserContext : NSObject
@property (nonatomic, readonly) id model;

- (instancetype)initWithModel:(id)model;

- (void)execute;
- (void)cancel;

//need to be reloaded
- (void)fillModelFromResult:(NSDictionary <ANSJSONRepresentation> *)result;

// need to be reloaded in childs classes
// return's graphPath string
- (NSString *)graphPath;

// need to be reloaded in childs classes
//return value must be: @"GET", @"POST", @"DELETE". default is @"GET"
- (NSString *)HTTPMethod;

// need to be reloaded in childs classes
// return's dictionaty with parametres;
- (NSDictionary *)parametres;

// need to be reloaded in childs classes
- (BOOL)isModelLoaded;

// DONT need to be reloaded
- (BOOL)isModelLoadedWithState:(NSUInteger)state;

@end
