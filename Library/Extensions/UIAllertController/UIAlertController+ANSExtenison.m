//
//  UIAlertController+ANSExtenison.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 17.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "UIAlertController+ANSExtenison.h"

@implementation UIAlertController (ANSExtenison)

+ (instancetype)controllerWithTitle:(NSString *)title
                            message:(NSString *)massage
                   rightAcitonTitle:(NSString *)rightTitle
                       rightHandler:(ANSActionHandler)rightHandler
                    leftAcitonTitle:(NSString *)leftTitle
                        leftHandler:(ANSActionHandler)leftHandler
{
    UIAlertController *controller =
    [self controllerWithTitle:title message:massage acitonTitle:rightTitle acitonHandler:rightHandler];
    UIAlertAction* leftAction = [UIAlertAction actionWithTitle:leftTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
                                                             leftHandler(action);
                                                         }];
    
    [controller addAction:leftAction];
    
    return controller;
}

+ (instancetype)controllerWithTitle:(NSString *)title
                            message:(NSString *)massage
                        acitonTitle:(NSString *)acitonTitle
                      acitonHandler:(ANSActionHandler)handler {
    
    UIAlertController *controller =
    [UIAlertController alertControllerWithTitle:title
                                        message:massage
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* action = [UIAlertAction actionWithTitle:acitonTitle
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           handler(action);
                                                       }];
    [controller addAction:action];
    
    return controller;
}

@end
