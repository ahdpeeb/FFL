//
//  ANSViewControllerTables.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSNameFilterModel.h"
#import "SRWebSocket.h"

@class ANSFBUser;

@interface ANSFriendListViewController : UIViewController <
    UITableViewDataSource,
    UITableViewDelegate,
    UISearchBarDelegate,
    UINavigationControllerDelegate,

    SRWebSocketDelegate,
    ANSArrayModelObserver,
    ANSNameFilterModelProtocol
>

@property (nonatomic, strong) ANSFBUser *user;

@property (nonatomic, strong) IBOutlet UISwipeGestureRecognizer *rightSwipeGesture;
- (IBAction)onRightSwipe:(UISwipeGestureRecognizer *)sender;

@end
