//
//  NSIndexPath+ANSExtension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 13.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSIndexPath (ANSExtension)

+ (NSIndexPath *)indexPathFromIndex:(NSUInteger)index;

- (NSUInteger)indexFromIndexPath:(NSIndexPath *)indexPath;

@end
