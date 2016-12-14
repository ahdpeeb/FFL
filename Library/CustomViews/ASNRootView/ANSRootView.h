//
//  ANSRootView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 30.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANSLoadingView;

@interface ANSRootView : UIView

// default standard loadingView, you can set custom LoadingView
@property (nonatomic, strong) IBOutlet                     ANSLoadingView *loadingView;

// default NO 
@property (nonatomic, assign, getter=isLoadingViewVisible) BOOL           loadingViewVisible;

//this method intended for reloading in child classed in you'd like to set custom LoadingView
- (void)attachLodingView;

@end
