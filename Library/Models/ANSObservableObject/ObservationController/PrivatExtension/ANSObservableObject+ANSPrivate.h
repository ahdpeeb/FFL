//
//  ANSObservableObject_ANSPrivate.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 02.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSObservableObject.h"

@class ANSObservationController;

@interface ANSObservableObject ()

- (void)invalidateController:(ANSObservationController *)controller;

@end
