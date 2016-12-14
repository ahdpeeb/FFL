//
//  NSBundle+ANSExtenison.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 18.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (ANSExtenison)

//returns main view from nib. nibName and ViewName must match. 
+ (id)objectWithClass:(Class)cls owner:(id)owner; 

@end
