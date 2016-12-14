//
//  ANSCacheStorage.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 18.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSCacheStorage.h"

@interface ANSCacheStorage ()
@property (nonatomic, strong) NSMapTable  *storage;

@end

@implementation ANSCacheStorage

@dynamic count;
@dynamic allKeys;

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)init {
    self = [super init];
    if (self) {
        self.storage = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory
                                             valueOptions:NSPointerFunctionsWeakMemory];
    }
    
    return self;
}

+ (instancetype)sharedStorage {
    @synchronized(self) {
        static id cacheStorage = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            cacheStorage = [self new];
        });
        
        return cacheStorage;
    }
}

#pragma mark -
#pragma mark Acsessors 

- (NSUInteger)count {
    @synchronized(self) {
        return self.storage.count;
    }
}

- (NSArray *)allKeys {
    @synchronized(self) {
       return self.storage.keyEnumerator.allObjects;
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)setObject:(id)object forKey:(id)key {
    @synchronized(self) {
        if (![self objectForKey:key]) {
            [self.storage setObject:object forKey:key];
        }
    }
}

- (id)objectForKey:(id)key {
    @synchronized(self) {
        return [self.storage objectForKey:key];
    }
}

- (void)removeCachedObjectForKey:(id)key {
    @synchronized(self) {
        [self.storage removeObjectForKey:key];
    }
}

- (void)setObject:(id)object forKeyedSubscript:(id)key {
    [self setObject:object forKey:key];
}

- (id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}


@end
