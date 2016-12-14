//
//  ANSTwoIndexHepler.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 12.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSTwoIndexModel.h"

@interface ANSTwoIndexModel ()
@property (nonatomic, assign) NSUInteger index2;

@end

@implementation ANSTwoIndexModel

- (instancetype)initWithIndex:(NSUInteger)index
                     index2:(NSUInteger)index2
{
    self = [super initWithIndex:index];
    self.index2 = index2;
    
    return self;
}

@end
