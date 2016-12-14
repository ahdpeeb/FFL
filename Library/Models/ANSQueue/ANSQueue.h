//
//  ANSQueue.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 17.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANSQueue : NSObject
@property (nonatomic, readonly)   NSUInteger     count;

/*If you want use KVO for observation for "ANSQueue" object
you have to use @"subjects" for forKeyPath.
sample => forKeyPath:@"subjects"
 */
@property (nonatomic, readonly)   NSArray        *objects;

- (void)enqueue:(id)object;
- (id)dequeue;

@end
