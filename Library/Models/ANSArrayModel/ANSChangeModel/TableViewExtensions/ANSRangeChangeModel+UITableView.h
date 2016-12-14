//
//  ANSRangeChangeModel+UITableView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 26.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSRangeChangeModel.h"

@interface ANSRangeChangeModel (UITableView)

- (void)applyToTableView:(UITableView *)tableView;

- (void)applyToTableView:(UITableView *)tableView
            rowAnimation:(UITableViewRowAnimation)animation;

@end
