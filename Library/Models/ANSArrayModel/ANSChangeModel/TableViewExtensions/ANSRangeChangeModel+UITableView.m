//
//  ANSRangeChangeModel+UITableView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 26.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSRangeChangeModel+UITableView.h"

#import "UITableView+Extension.h"

@implementation ANSRangeChangeModel (UITableView)

- (void)applyToTableView:(UITableView *)tableView {
    [self applyToTableView:tableView rowAnimation:UITableViewRowAnimationFade];
}

- (void)applyToTableView:(UITableView *)tableView
            rowAnimation:(UITableViewRowAnimation)animation
{
    NSUInteger inx1 = self.index;
    NSUInteger inx2 = self.index2;
    NSMutableArray *paths = [NSMutableArray arrayWithCapacity:inx2 - inx1];
    for (NSUInteger index = inx1; index <= inx2; index ++ ) {
        [paths addObject: [NSIndexPath indexPathForRow:index inSection:0]];
    }
    
    [tableView updateWithBlock:^{
        switch (self.state) {
            case ANSStateAddObjectsInRange:
                [tableView reloadRowsAtIndexPaths:paths withRowAnimation:animation];
                break;
                
            default:
                [tableView reloadData];
                break;
        }
    }];
}


@end
