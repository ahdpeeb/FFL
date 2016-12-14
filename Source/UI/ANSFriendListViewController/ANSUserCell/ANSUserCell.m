//
//  ANSDataCell.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 22.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
// UILabel      *label;
// UIImageView  *imageView;

#import "ANSUserCell.h"

#import "ANSImageView.h"
#import "ANSFBUser.h"
#import "ANSLoadingView.h"
#import "ANSImageView+ANSExtension.h"

#import "ANSMacros.h"

@interface ANSUserCell ()
@property (nonatomic, weak) ANSFBUser *user;

@end

@implementation ANSUserCell

#pragma mark -
#pragma mark Acsessors

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark -
#pragma mark Private methods

- (void)layoutSubviews {
    [self.userImageView roundWithBorderColor:[UIColor blackColor]
                                 borderWidth:1.0];
}

- (void)customizeUserPicture {
    ANSImageView *image = self.userImageView;
    UIImageView *picture = image.contentImageView;
    
    image.userInteractionEnabled = NO;
    picture.userInteractionEnabled = NO;
}

#pragma mark -
#pragma mark Public methods

- (void)fillWithUser:(ANSFBUser *)user {
    self.user = user;
    self.label.text = user.fullName;
    self.userImageView.imageModel = user.imageModel;
    
    [self customizeUserPicture];
}

@end
