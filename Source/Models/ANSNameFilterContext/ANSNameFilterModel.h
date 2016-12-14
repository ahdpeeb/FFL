//
//  ANSNameFilterModel.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 30.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSArrayModel.h"
#import "ANSFBFriends.h"

@class ANSNameFilterModel;

@protocol ANSNameFilterModelProtocol <ANSArrayModelObserver>

- (void)nameFilterModelDidFilter:(ANSNameFilterModel *)model;

@end

typedef NS_ENUM(NSUInteger, ANSNameFilterModelState) {
    ANSNameFilterModelDidFilter = ANSArrayModelStatesCount,
    
    ANSNameFilterModelCount
};

@interface ANSNameFilterModel : ANSArrayModel <ANSArrayModelObserver>
@property (nonatomic, readonly) id observableObject;

- (instancetype)initWithObservableModel:(id)model;

- (void)filterByfilterString:(NSString *)filterString;

@end
