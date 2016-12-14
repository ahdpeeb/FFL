//
//  ANSCollectionHelper.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 12.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UITableView;

typedef NS_ENUM(NSUInteger, ANSChangeState) {
    ANSStateAddObject,
    ANSStateRemoveObject,
    ANSStateMoveObject,
    ANSStateExchangeObject,
    ANSStateAddObjectsInRange,
    ASNStateRemoveAllObjects,
    ANSStateUpdateObject
};

@interface ANSChangeModel : NSObject
@property (nonatomic, strong) id             userInfo;
@property (nonatomic, assign) ANSChangeState state;

+ (instancetype)oneIndexModel:(NSUInteger)index; 
+ (instancetype)twoIndexModel:(NSUInteger)index index2:(NSUInteger)index2;
+ (instancetype)rangeModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end
