//
//  ANSTargetView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 05.11.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSTargetView.h"

#import "ANSImageView.h"
#import "ANSFBUser.h"

#import "ANSLoadingView.h"
#import "ANSImageView+ANSExtension.h"
#import "ANSProtocolObservationController.h"

#import "ANSGCD.h"

@implementation ANSTargetView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.imageView roundWithBorderColor:[UIColor blackColor]
                             borderWidth:2.0];
}

- (void)fillViewFromUser:(ANSFBUser *)user {
    self.imageView.imageModel = user.imageModel;
}

- (void)layoutSubviews {
    
}

@end
