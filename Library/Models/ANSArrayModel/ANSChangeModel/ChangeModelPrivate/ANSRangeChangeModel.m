//
//  ANSRangeChangeModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 26.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSRangeChangeModel.h"

#import "ANSTwoIndexModel.h"

@implementation ANSRangeChangeModel

- (instancetype)initFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    return [super initWithIndex:fromIndex index2:toIndex];
}

@end
