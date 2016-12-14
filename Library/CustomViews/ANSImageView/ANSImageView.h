//
//  ANSImageView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 30.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//  aspectFit aspectfil - contentType

#import <UIKit/UIKit.h>

#import "ANSLoadableModel.h"

@class ANSImageModel;
@class ANSLoadingView;

@interface ANSImageView : UIView <ANSLoadableModelObserver>
@property (nonatomic, strong) IBOutlet  UIImageView     *contentImageView;
@property (nonatomic, strong) IBOutlet  ANSLoadingView  *loadingView;
@property (nonatomic, strong)           ANSImageModel   *imageModel;

@end
