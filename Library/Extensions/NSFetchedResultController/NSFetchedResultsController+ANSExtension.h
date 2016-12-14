//
//  NSFetchedResultsController+ANSExtension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 16.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSFetchedResultsController (ANSExtension)

+ (instancetype)cotrollerWithFetchRequest:(NSFetchRequest *)fetchRequest
                     managedObjectContext: (NSManagedObjectContext *)contex;

@end
