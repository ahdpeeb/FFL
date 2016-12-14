//
//  ANSTargetView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 05.11.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSRootView.h"

@class ANSFBUser;
@class ANSImageView;

@interface ANSTargetView : ANSRootView
@property (nonatomic, strong) IBOutlet  ANSImageView *imageView;
@property (nonatomic, strong) IBOutlet  UIButton     *yesButton;
@property (nonatomic, strong) IBOutlet  UIButton     *noButton;

- (void)fillViewFromUser:(ANSFBUser *)user;

@end
