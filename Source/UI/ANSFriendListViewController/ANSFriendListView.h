//
//  ANSTablesView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSRootView.h"

@interface ANSFriendListView : ANSRootView
@property (nonatomic, strong) IBOutlet UITableView      *tableView;
@property (nonatomic, strong) IBOutlet UISearchBar      *searchBar;

@end
