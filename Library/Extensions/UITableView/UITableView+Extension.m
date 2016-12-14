//
//  UITableView+Extension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 27.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "UITableView+Extension.h"

#import "UINib+Extension.h"
#import "ANSTableViewCell.h"
#import "NSBundle+ANSExtenison.h"

@implementation UITableView (Extension)

- (id)dequeueReusableCellWithClass:(Class)cls {
    id cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(cls)];
    if (!cell) {
        cell = [NSBundle objectWithClass:cls owner:nil];
    }
    
    return cell;
}

- (void)updateWithBlock:(ANSUpdatingBlock)block {
    if (!block) {
        return;
    }
    
    [self beginUpdates];
    block();
    [self endUpdates];
}

@end
