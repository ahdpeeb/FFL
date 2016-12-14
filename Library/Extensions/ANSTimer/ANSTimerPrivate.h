//
//  ANSTimerPrivate.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 19.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANSTimerPrivate : NSObject

// this is private method, never call it directly. 
- (void)executeBlock:(NSTimer *)timer; 

@end
