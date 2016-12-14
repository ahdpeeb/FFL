//
//  ANSLoadingView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 18.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSLoadingView.h"

#import "NSBundle+ANSExtenison.h"

#import "ANSMacros.h"

static const NSTimeInterval kANSInterval = 1.0f;
static const NSTimeInterval kANSDelay = 0;
static const CGFloat        kANSMinAlpha = 0;
static const CGFloat        kANSMaxAlpha = 1;

@implementation ANSLoadingView

#pragma mark -
#pragma mark Class methods

+ (instancetype)viewOnSuperView:(UIView *)view {
    ANSLoadingView *loadingView = [NSBundle objectWithClass:[self class] owner:nil];
    loadingView.frame = view.bounds;
    loadingView.autoresizingMask =    UIViewAutoresizingFlexibleLeftMargin
                                    | UIViewAutoresizingFlexibleWidth
                                    | UIViewAutoresizingFlexibleRightMargin
                                    | UIViewAutoresizingFlexibleTopMargin
                                    | UIViewAutoresizingFlexibleHeight
                                    | UIViewAutoresizingFlexibleBottomMargin;
    [view addSubview:loadingView];
    
    return loadingView;
}

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    self.alpha = 0;
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.alpha = 0;

    return self;
}

#pragma mark -
#pragma mark Accsessors

- (void)setVisible:(BOOL)visible {
    [self setVisible:visible animated:YES];
}

- (void)setVisible:(BOOL)visible animated:(BOOL)animated {
    [self setVisible:visible animated:animated complititionBlock:nil];
}

- (void)setVisible:(BOOL)visible
          animated:(BOOL)animated
 complititionBlock:(ANSCompletionBlock)block {
    @synchronized(self) {
        [UIView animateWithDuration:animated ? kANSInterval : 0
                              delay:kANSDelay
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             if (visible) {
                                 [[self superview] bringSubviewToFront:self];
                                 [self.indicator startAnimating];
                             }
                             
                             self.alpha = visible ? kANSMaxAlpha : kANSMinAlpha;
                             
                         } completion:^(BOOL finished) {
                             self.hidden = !visible;
                             ANSPerformBlockWithoutArguments(block);
                             _visible = visible;
                         }];
        }
   }

@end
