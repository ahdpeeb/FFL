//
//  ANSLoadingView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 18.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ANSCompletionBlock)(void);

@interface ANSLoadingView : UIView
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *indicator;

@property (nonatomic, assign, getter=isVisible) BOOL visible;

//argument view must be subclass of UIView 
+ (instancetype)viewOnSuperView:(UIView *)view;

// defauld setVisible (animated = YES)
- (void)setVisible:(BOOL)visible animated:(BOOL)animated;

- (void)setVisible:(BOOL)visible
          animated:(BOOL)animated
 complititionBlock:(ANSCompletionBlock)block;

@end
