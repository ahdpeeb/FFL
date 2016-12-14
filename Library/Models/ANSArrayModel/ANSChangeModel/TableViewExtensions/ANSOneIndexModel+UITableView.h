//
//  ANSOneIndexModel+UItableView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 16.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSOneIndexModel.h"

@interface ANSOneIndexModel (UITableView)

- (void)applyToTableView:(UITableView *)tableView;

- (void)applyToTableView:(UITableView *)tableView
            rowAnimation:(UITableViewRowAnimation)animation;

@end
