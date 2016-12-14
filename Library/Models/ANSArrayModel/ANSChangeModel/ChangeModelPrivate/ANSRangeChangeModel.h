//
//  ANSRangeChangeModel.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 26.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSTwoIndexModel.h"

@interface ANSRangeChangeModel : ANSTwoIndexModel

- (instancetype)initFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end
