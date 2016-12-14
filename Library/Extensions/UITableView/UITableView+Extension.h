//
//  UITableView+Extension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 27.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ANSUpdatingBlock)(void);

@interface UITableView (Extension)
// cls should be child class of ANSTableViewCell class
- (id)dequeueReusableCellWithClass:(Class)cls;

- (void)updateWithBlock:(ANSUpdatingBlock)block;

@end
