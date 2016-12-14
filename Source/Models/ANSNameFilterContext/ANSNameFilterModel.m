    //
//  ANSNameFilterModel.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 30.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSNameFilterModel.h"

#import "ANSProtocolObservationController.h"
#import "ANSFBUser.h"
#import "ANSFBFriends.h"
#import "ANSGCD.h"
#import "ANSChangeModel.h"
#import "ANSOneIndexModel.h"

#import "ANSMacros.h"

typedef void(^ANSOperationBlock)(void);

@interface ANSNameFilterModel ()
@property (nonatomic, strong)   ANSFBFriends                        *model;
@property (nonatomic, strong)   ANSProtocolObservationController    *controller;
@property (nonatomic, strong)   NSString                            *filterString;

- (void)addUserWithoutNotification:(ANSFBUser *)user;
- (void)filterModelByFilterString:(NSString *)filterString;
- (BOOL)user:(ANSFBUser *)user containsString:(NSString *)string;
- (void)verifyObject:(id)object
          withString:(NSString *)string
         performBlock:(ANSOperationBlock)block;

@end

@implementation ANSNameFilterModel

@dynamic observableObject;

#pragma mark -
#pragma mark Initialization and deadllocation

- (instancetype)initWithObservableModel:(id)model {
    self = [super init];
    if (self) {
        self.model = model;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (void)setModel:(ANSFBFriends *)model {
    if (_model != model) {
        _model = model;
        
        self.controller = [model protocolControllerWithObserver:self];
    }
}

- (id)observableModel {
    return self.controller.observableObject;
}

#pragma mark -
#pragma mark Private methods

- (void)addUserWithoutNotification:(ANSFBUser *)user {
    [self performBlockWithoutNotification:^{
        [self addObject:user];
    }];
}

- (void)filterModelByFilterString:(NSString *)filterString {
    [self performBlockWithoutNotification:^{
        [self removeAllObjects];
    }];
    
    for (ANSFBUser *user in self.model) {
        if (!filterString.length) {
            [self addUserWithoutNotification:user];
        }
        
        if ([self user:user containsString:filterString]) {
                [self addUserWithoutNotification:user];
        }
    }
}

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case ANSNameFilterModelDidFilter:
            return @selector(nameFilterModelDidFilter:);
            
        default:
            return [super selectorForState:state];
    }
}

- (BOOL)user:(ANSFBUser *)user containsString:(NSString *)string {
    if (!string) {
        return YES;
    }
    
    NSRange range = [user.fullName rangeOfString:string
                                  options:NSCaseInsensitiveSearch];
    
    return range.location == NSNotFound;
}

- (void)verifyObject:(id)object
          withString:(NSString *)string
        performBlock:(ANSOperationBlock)block
{
    if ([object isKindOfClass:[ANSFBUser class]]) {
        if ([self user:(ANSFBUser *)object containsString:string]) {
            block();
        }
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)filterByfilterString:(NSString *)filterString {
    @synchronized(self) {
        self.filterString = filterString;
        ANSWeakify(self);
        ANSPerformInAsyncQueue(ANSPriorityHigh, ^{
            ANSStrongify(self);
            [self filterModelByFilterString:filterString];
            [self notifyOfStateChange:ANSNameFilterModelDidFilter];
        });
    }
}

#pragma mark -
#pragma mark ANSUsersModelObserver

- (void)usersModelDidLoad:(ANSFBFriends *)model {
    ANSPerformInAsyncQueue(ANSPriorityLow, ^{
        [self performBlockWithoutNotification:^{
            [self addObjectsInRange:model.objects];
        }];
    });
}

- (void)    arrayModel:(ANSArrayModel *)arrayModel
    didChangeWithModel:(ANSChangeModel *)model
{
    id user = model.userInfo;
    NSString *filterStirng = self.filterString;
    
    [self verifyObject:user withString:filterStirng performBlock:^{
        switch (model.state) {
            case ANSStateAddObject: {
                [self addObject:user];
                break;
            }
            case ANSStateRemoveObject: {
                if ([self containsObject:user]) {
                    [self removeObject:user];
                }
                
                break;
            }
                
            default:
                break;
        }
    }];
}

@end
