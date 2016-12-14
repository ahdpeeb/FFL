//
//  ANSTwoIndexModel+UITableView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 16.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSTwoIndexModel+UITableView.h"

#import "UITableView+Extension.h"

@implementation ANSTwoIndexModel (UITableView)

- (void)applyToTableView:(UITableView *)tableView {
    [self applyToTableView:tableView rowAnimation:UITableViewRowAnimationFade]; 
}

- (void)applyToTableView:(UITableView *)tableView
            rowAnimation:(UITableViewRowAnimation)animation
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.index inSection:0];
    NSIndexPath *pathTwo = [NSIndexPath indexPathForRow:self.index2 inSection:0];
    [tableView updateWithBlock:^{
        switch (self.state) {
            case ANSStateMoveObject:
                [tableView reloadRowsAtIndexPaths:@[path, pathTwo] withRowAnimation:animation];
                break;
                
            case ANSStateExchangeObject:
                [tableView reloadRowsAtIndexPaths:@[path, pathTwo] withRowAnimation:animation];
                break;
                
            default:
                [tableView reloadData];
                break;
        }
    }];
}

@end
