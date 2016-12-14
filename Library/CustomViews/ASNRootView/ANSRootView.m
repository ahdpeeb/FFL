//
//  ANSRootView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 30.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSRootView.h"

#import "ANSLoadingView.h"

@implementation ANSRootView

@dynamic loadingViewVisible;

#pragma mark -
#pragma mark Initialization and deallocation 

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self attachLodingView];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    if (!self.loadingView) {
        [self attachLodingView];
    }
}

#pragma mark -
#pragma mark Accsessors

- (void)setLoadingView:(ANSLoadingView *)loadingView {
    if (_loadingView != loadingView) {
        [_loadingView removeFromSuperview];
        _loadingView = loadingView;
        
        if (loadingView) {
            [self addSubview:loadingView];
        }
    }
}

- (void)setLoadingViewVisible:(BOOL)loadingViewVisible {
    self.loadingView.visible = loadingViewVisible;
}

- (BOOL)isLoadingViewVisible {
   return self.loadingView.visible;
}

#pragma mark -
#pragma mark Private Methods

- (void)attachLodingView {
    self.loadingView  = [ANSLoadingView viewOnSuperView:self];
}

@end
