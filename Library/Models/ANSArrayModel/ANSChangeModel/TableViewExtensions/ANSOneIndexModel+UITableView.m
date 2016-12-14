//
//  ANSOneIndexModel+UItableView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 16.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSOneIndexModel+UITableView.h"

#import "UITableView+Extension.h"

@implementation ANSOneIndexModel (UTTableView)

- (void)applyToTableView:(UITableView *)tableView {
    [self applyToTableView:tableView rowAnimation:UITableViewRowAnimationFade]; 
}

- (void)applyToTableView:(UITableView *)tableView
            rowAnimation:(UITableViewRowAnimation)animation
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.index inSection:0];
    
    [tableView updateWithBlock:^{
        switch (self.state) {
            case ANSStateAddObject:
                [tableView insertRowsAtIndexPaths:@[path] withRowAnimation:animation];
                break;
                
            case ANSStateRemoveObject:
                [tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:animation];
                break;
            
            case ANSStateUpdateObject:
                [tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:animation];
                break;
                
            default:
                [tableView reloadData];
                break;
        }
    }];
}

@end
