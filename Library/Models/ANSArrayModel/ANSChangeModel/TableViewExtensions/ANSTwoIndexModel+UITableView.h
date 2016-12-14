//
//  ANSTwoIndexModel+UITableView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 16.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSTwoIndexModel.h"

#import <UIKit/UIKit.h>

@interface ANSTwoIndexModel (UITableView)

- (void)applyToTableView:(UITableView *)tableView;

- (void)applyToTableView:(UITableView *)tableView
            rowAnimation:(UITableViewRowAnimation)animation;

@end
