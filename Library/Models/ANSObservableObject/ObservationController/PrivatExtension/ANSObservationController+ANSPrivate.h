//
//  ANSObservationController_ANSPrivateExtension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 02.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSObservationController.h"

@interface ANSObservationController ()

- (void)notifyOfStateChange:(NSUInteger)state;
- (void)notifyOfStateChange:(NSUInteger)state withUserInfo:(id)userInfo;

@end
