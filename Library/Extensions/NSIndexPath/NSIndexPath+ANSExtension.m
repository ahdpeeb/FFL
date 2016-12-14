//
//  NSIndexPath+ANSExtension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 13.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UITableView.h>

#import "NSIndexPath+ANSExtension.h"

@implementation NSIndexPath (ANSExtension)

+ (NSIndexPath *)indexPathFromIndex:(NSUInteger)index {
    return [self indexPathForRow:index inSection:0];
}

- (NSUInteger)indexFromIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row;
}

@end
