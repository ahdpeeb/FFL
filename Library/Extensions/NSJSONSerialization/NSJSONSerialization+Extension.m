//
//  NSJSONSerialization+Extension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 26.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "NSJSONSerialization+Extension.h"

static const NSUInteger kANSNilValue = 0;

@implementation NSJSONSerialization (Extension)

+ (id)JSONFromData:(NSData *)data {
    NSError *error = nil;
    id jsonObject = [self JSONObjectWithData:data options:kANSNilValue error:&error];
    NSLog(@"[ERROR data parsing] - %@", error);
    return !error ? jsonObject : error;
}

@end
