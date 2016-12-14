//
//  NSArray+JSONRepresentation.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 30.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "NSArray+JSONRepresentation.h"

@implementation NSArray (ANSJSONRepresentation) 

#pragma mark -
#pragma mark ANSJSONRepresentation protocol

- (instancetype)JSONRepresentation {
    NSMutableArray *objects = [NSMutableArray new];
    for (id <ANSJSONRepresentation> object in self) {
        id value = [object JSONRepresentation];
        if (value) {
            [objects addObject:value];
        }
    }
    
    return [self isKindOfClass:[NSArray class]] ? [objects copy] : objects;
};

@end
