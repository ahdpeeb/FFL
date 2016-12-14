//
//  NSFetchedResultsController+ANSExtension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 16.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "NSFetchedResultsController+ANSExtension.h"

@implementation NSFetchedResultsController (ANSExtension)

+ (instancetype)cotrollerWithFetchRequest:(NSFetchRequest *)fetchRequest
                     managedObjectContext: (NSManagedObjectContext *)contex
{
    return [[self alloc] initWithFetchRequest:fetchRequest managedObjectContext:contex sectionNameKeyPath:nil cacheName:nil];
}

@end
