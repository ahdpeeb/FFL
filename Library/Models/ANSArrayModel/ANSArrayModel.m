//
//  ANSCollectionModel
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.

#import "ANSArrayModel.h"

#import "ANSChangeModel.h"
#import "NSMutableArray+ANSExtension.h"

static NSString * const kANSArchiveKey              = @"kANSArchiveKey";
static NSString * const kANSCollectionKey           = @"kANSCollectionKey";

@interface ANSArrayModel ()
@property (nonatomic, retain) NSMutableArray *mutableObjects;

@end

@implementation ANSArrayModel

@dynamic count;
@dynamic objects;

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)init {
    self = [super init];
    self.mutableObjects = [NSMutableArray new];
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (NSUInteger)count {
    @synchronized(self) {
        return self.mutableObjects.count;
    }
}

- (NSArray *)objects {
    @synchronized(self) {
        return [self.mutableObjects copy];
    }
}

#pragma mark -
#pragma mark Private methods;

- (void)notifyOfChangeWithIndex:(NSUInteger)index
                       userInfo:(id)userInfo
                          state:(ANSChangeState)state
{
    ANSChangeModel *model = [ANSChangeModel oneIndexModel:index];
    model.userInfo = userInfo;
    model.state = state;
    [self notifyOfStateChange:ANSArrayModelDidChange withUserInfo:model];
}

- (void)notifyOfChangeWithIndex:(NSUInteger)index1
                         index2:(NSUInteger)index2
                       userInfo:(id)userInfo
                          state:(ANSChangeState)state;
{
    ANSChangeModel *model = nil;
    switch (state) {
        case ANSStateAddObjectsInRange:
            model = [ANSChangeModel rangeModelFromIndex:index1 toIndex:index2];
            model.userInfo = userInfo;
            break;
        
        case ANSStateMoveObject:
        case ANSStateExchangeObject:
            model = [ANSChangeModel rangeModelFromIndex:index1 toIndex:index2];
            model.userInfo = userInfo;
            break;
            
        default:
            break;
    }
    
    model.state = state;
    [self notifyOfStateChange:ANSArrayModelDidChange withUserInfo:model];
}

#pragma mark -
#pragma mark Public methods; 

- (BOOL)containsObject:(id)object {
    @synchronized(self) {
        return [self.mutableObjects containsObject:object];
    }
}

- (id)objectAtIndex:(NSUInteger)index {
    @synchronized(self) {
        return [self.mutableObjects objectAtIndex:index];
    }
}

- (NSUInteger)indexOfObject:(id)object {
    @synchronized(self) {
        return [self.mutableObjects indexOfObject:object];
    }
}

- (void)addObject:(id)object {
    @synchronized(self) {
        [self insertObject:object atIndex:self.count];
    }
}

- (void)removeObject:(id)object {
    @synchronized(self) {
        NSUInteger index = [self indexOfObject:object];
        [self removeObjectAtIndex:index];
    }
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    @synchronized(self) {
        NSMutableArray *collection = self.mutableObjects;
        NSUInteger count = collection.count;
        
        if (!object || (index > count)) {
            return;
        }
        
        if (![collection containsObject:object]) {
            [collection insertObject:object atIndex:index];
            [self notifyOfChangeWithIndex:index userInfo:object state:ANSStateAddObject];
        }
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    @synchronized(self) {
        id object = [self objectAtIndex:index];
        if (object) {
            [self.mutableObjects removeObjectAtIndex:index];
            [self notifyOfChangeWithIndex:index userInfo:object state:ANSStateRemoveObject];
        }
    }
}

- (void)addObjectsInRange:(NSArray *)objects {
    @synchronized(self) {
       __block NSUInteger count = 0;
        [self performBlockWithoutNotification:^{
            for (id object in objects) {
                count ++;
                [self addObject:object];
            }
        }];
        
        NSInteger fromIndex = self.count - count - 1;
        [self notifyOfChangeWithIndex:fromIndex index2:fromIndex + count userInfo:objects state:ANSStateAddObjectsInRange];
    }
}

- (void)removeAllObjects {
    @synchronized(self) {
        NSUInteger count = self.count;
        [self.mutableObjects removeAllObjects];
        
        [self notifyOfChangeWithIndex:ANSArrayModelDidChange index2:count userInfo:nil state:ASNStateRemoveAllObjects];
    }
}

- (void)moveObjectFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    @synchronized(self) {
        NSUInteger count = self.count;
        
        if ((fromIndex >= count) || (toIndex >= count)) {
            return;
        }
        
        [self.mutableObjects moveObjectFromIndex:fromIndex toIndex:toIndex]; 
        [self notifyOfChangeWithIndex:fromIndex index2:toIndex userInfo:nil state:ANSStateMoveObject];
    }
}

- (void)exchangeObjectAtIndex:(NSUInteger)index withObjectAtIndex:(NSUInteger)index2 {
    @synchronized(self) {
        [self.mutableObjects exchangeObjectAtIndex:index withObjectAtIndex:index2];
        [self notifyOfChangeWithIndex:index index2:index2 userInfo:nil state:ANSStateExchangeObject];
    }
}

#pragma mark -
#pragma mark Reloaded methods

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    @synchronized(self) {
        return [self.mutableObjects objectAtIndex:idx];
    }
}

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case ANSArrayModelDidChange:
            return @selector(arrayModel:didChangeWithModel:);
            
        default:
            return [super selectorForState:state];
    }
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained [])buffer
                                    count:(NSUInteger)len {
    
   return [self.mutableObjects countByEnumeratingWithState:state objects:buffer count:len];
}

#pragma mark -
#pragma mark NSCoding protocol

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.mutableObjects forKey:kANSCollectionKey];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        NSArray *archive = [aDecoder decodeObjectForKey:kANSCollectionKey];
        self.mutableObjects = [[NSMutableArray alloc] initWithArray:archive copyItems:YES];
    }
    
    return self;
}

@end
