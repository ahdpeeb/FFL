//
//  ANSImageView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 30.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSImageView.h"

#import "ANSImageModel.h"
#import "ANSProtocolObservationController.h"
#import "ANSGCD.h"
#import "ANSMacros.h"
#import "ANSLoadableModel.h"
#import "ANSLoadingView.h"

@interface ANSImageView ()
@property (nonatomic, strong) ANSProtocolObservationController *observationController;

@end

@implementation ANSImageView

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (!self.contentImageView) {
        [self initSubviews];
    }
}

- (void)initSubviews {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask =  UIViewAutoresizingFlexibleWidth
                                | UIViewAutoresizingFlexibleHeight
                                | UIViewAutoresizingFlexibleLeftMargin
                                | UIViewAutoresizingFlexibleRightMargin
                                | UIViewAutoresizingFlexibleTopMargin
                                | UIViewAutoresizingFlexibleBottomMargin;
    
    self.contentImageView = imageView;
    self.loadingView = [ANSLoadingView viewOnSuperView:self.contentImageView];
}

#pragma mark -
#pragma mark Accsessors

- (void)setContentImageView:(UIImageView *)contentImageView {
    if (_contentImageView != contentImageView) {
        [_contentImageView removeFromSuperview];
        
        _contentImageView = contentImageView;
        [self addSubview:contentImageView];
    }
}

- (void)setImageModel:(ANSImageModel *)imageModel {
    if(_imageModel != imageModel) {
        _imageModel = imageModel;
        
        self.observationController = [_imageModel protocolControllerWithObserver:self];
        [imageModel load];
    }
}

#pragma mark -
#pragma mark Private

- (void)loadableModelLoading:(ANSLoadableModel *)model {
    ANSPerformAsyncOnMainQueue(^{
        self.loadingView.visible = YES;
    });
}

- (void)loadableModelDidLoad:(ANSLoadableModel *)model {
    ANSPerformAsyncOnMainQueue(^{
        self.contentImageView.image = self.imageModel.image;
        self.loadingView.visible = NO;
    });
}

- (void)loadableModelDidFailLoading:(ANSLoadableModel *)model {
    [self.imageModel load];
}

@end
