//
//  ANSDataCell.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANSFBUser;
@class ANSImageView;
@class ANSLoadingView;

@interface ANSUserCell : UITableViewCell 
@property (nonatomic, strong) IBOutlet UILabel          *label;
@property (nonatomic, strong) IBOutlet ANSImageView     *userImageView;
@property (nonatomic, strong) IBOutlet ANSLoadingView   *loadingView;
@property (nonatomic, strong) IBOutlet UIButton         *userLocaiton;

- (void)fillWithUser:(ANSFBUser *)user;

@end
