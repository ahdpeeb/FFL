//
//  ANSOneIndexHelper.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 12.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSOneIndexModel.h"

@interface ANSOneIndexModel ()
@property (nonatomic, assign) NSUInteger index;

@end

@implementation ANSOneIndexModel

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)initWithIndex:(NSUInteger)index {
    self = [super init];
    if (self) {
        self.index = index;
    }
    
    return self;
}


@end
