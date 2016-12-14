//
//  UIAlertController+ANSExtenison.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 17.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ANSActionHandler)(UIAlertAction *action);

@interface UIAlertController (ANSExtenison)

//Two-buttons controller
+ (instancetype)controllerWithTitle:(NSString *)title
                            message:(NSString *)massage
                   rightAcitonTitle:(NSString *)rightTitle
                       rightHandler:(ANSActionHandler)rightHandler
                    leftAcitonTitle:(NSString *)leftTitle
                        leftHandler:(ANSActionHandler)leftHandler;

//one-button controller
+ (instancetype)controllerWithTitle:(NSString *)title
                            message:(NSString *)massage
                        acitonTitle:(NSString *)acitonTitle
                      acitonHandler:(ANSActionHandler)handler;

@end
