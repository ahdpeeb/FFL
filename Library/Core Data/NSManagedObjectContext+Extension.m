//
//  NSManagedObjectContext+Extension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 05.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "NSManagedObjectContext+Extension.h"
#import "ANSCoreDataManager.h"
#import "ANSMacros.h"

@interface NSManagedObjectContext (ANSPrivate)
+ (NSManagedObjectContext *)context;
@end

@implementation NSManagedObjectContext (ANSPrivate)

+ (NSManagedObjectContext *)context {    
    return [[ANSCoreDataManager sharedManager] managedObjectContext];
}

@end

@implementation NSManagedObjectContext (ANSExtension)

+ (void)save {
    NSError *saveError = nil;
    if ([[self context] hasChanges]) {
        if ([[self context] save:&saveError]) {
            NSLog(@"[ERROR] save arror - %@", [saveError localizedDescription]);
            abort();
        }
    }
}

@end
