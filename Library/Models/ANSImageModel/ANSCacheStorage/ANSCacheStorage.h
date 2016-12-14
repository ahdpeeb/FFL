//
//  ANSCacheStorage.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 18.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANSCacheStorage : NSObject
@property (nonatomic, assign, readonly) NSUInteger count;
@property (nonatomic, copy, readonly)   NSArray    *allKeys;

//Designated initializar, sigleton object;
+ (instancetype)sharedStorage;

- (void)setObject:(id)object forKey:(id)key;
- (void)removeCachedObjectForKey:(id)key;
- (id)objectForKey:(id)key;

- (void)setObject:(id)object forKeyedSubscript:(id)key;
- (id)objectForKeyedSubscript:(id)key;

@end
