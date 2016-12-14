//
//  UIViewController+ANSExtension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 17.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ANSExtension)

//Your viewControler class name must match with nib name(module)
+ (id)viewController; 

//method for reloading in child classes (if class name doesnt match with nib name)
+ (NSString *)nibName;

@end
