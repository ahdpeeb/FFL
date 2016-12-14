//
//  ANSLoadimgModel.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 02.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSObservableObject.h"

@class ANSLoadableModel;

@protocol ANSLoadableModelObserver <NSObject>

@optional

- (void)loadableModelLoading:(ANSLoadableModel *)model;
- (void)loadableModelDidLoad:(ANSLoadableModel *)model;
- (void)loadableModelDidFailLoading:(ANSLoadableModel *)model;

@end

typedef NS_ENUM(NSUInteger, ANSLoadingState) {
    ANSLoadableModelUnloaded,
    ANSLoadableModelLoading,
    ANSLoadableModelDidLoad,
    ANSLoadableModelDidFailLoading,
    
    ANSLoadableModelStatesCount
};

@interface ANSLoadableModel : ANSObservableObject
@property (nonatomic, readonly, getter=isLoaded) BOOL loaded;

- (void)load;

// method for reloding in child classes. You need to set up complition state..
// self.state = (if loaded successfully) ? ANSLoadableModelDidLoad : ANSLoadableModelDidFailLoading
- (void)performLoading;

@end
