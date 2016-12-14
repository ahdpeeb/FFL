//
//  ANSTargetViewController.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 05.11.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSTargetView.h"
#import "ANSFBUser.h"

@interface ANSTargetViewController : UIViewController <ANSUserStateObserver>
@property (nonatomic, readonly) ANSTargetView *targetView;
@property (nonatomic, strong)   ANSFBUser     *targetUser;

- (IBAction)onAllowRequest:(UIButton *)sender;
- (IBAction)onForbitReques:(UIButton *)sender;

//private methods - intended for context
- (void)presentAllertController:(UIAlertController *)controller;

@end
