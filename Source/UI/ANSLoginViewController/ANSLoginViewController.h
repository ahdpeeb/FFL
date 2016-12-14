//
//  ANSLoginViewController1.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 10.11.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ANSFBUser.h"

@class ANSLoginView;

@interface ANSLoginViewController : UIViewController <ANSUserStateObserver>
@property (nonatomic, readonly) ANSLoginView *loginView;

- (IBAction)onLogin:(UIButton *)sender;
- (IBAction)onFriends:(UIButton *)sender;

@end
