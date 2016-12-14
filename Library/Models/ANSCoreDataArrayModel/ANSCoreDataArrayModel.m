//
//  ANSWrapedFetchedController.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 11.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UITableView.h>

#import "ANSCoreDataArrayModel.h"

#import "ANSCoreDataManager.h"
#import "NSManagedObject+ANSExtension.h"
#import "NSManagedObjectContext+Extension.h"
#import "NSIndexPath+ANSExtension.h"

@interface ANSCoreDataArrayModel ()
@property (nonatomic, strong)   id <ANSObservableObject>   model;
@property (nonatomic, strong)   NSFetchedResultsController *resultsController;
@property (nonatomic, strong)   NSString                   *keyPath;
@property (nonatomic, readonly) NSManagedObjectContext     *context;


- (void)initResultsController;

@end

@implementation ANSCoreDataArrayModel

@dynamic context;
@dynamic count;
@dynamic objects;

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)initWithModel:(id <ANSObservableObject>)model
                      keyPath:(NSString *)keyPath
{
    self = [super init];
    self.model = model;
    self.keyPath = keyPath;
    [self initResultsController];
    
    return self;
}
// objects, count, conteinsObject, objectAt index, insert, remove; - перегрузить 
#pragma mark -
#pragma mark Accsessors 

- (NSUInteger)count {
    @synchronized (self) {
        return self.objects.count;
    }
}

- (NSArray *)objects {
    @synchronized (self) {
        return [self.resultsController.fetchedObjects copy];
    }
}

- (NSManagedObjectContext *)context {
    @synchronized (self) {
        return [[ANSCoreDataManager sharedManager] managedObjectContext];
    }
}

- (void)setResultsController:(NSFetchedResultsController *)resultsController {
    if (_resultsController != resultsController) {
        _resultsController = resultsController;
    
        _resultsController.delegate = self;
    }
}

#pragma mark -
#pragma mark Private methods

- (void)initResultsController {
    NSFetchRequest *reques = [[self.model class] fetchRequestWithSortDescriptors:[self sortDescriptors]
                                                                        predicate:[self fetchedPredicate]
                                                                       batchCount:[self batchCount]];
    
    self.resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:reques
                                                                 managedObjectContext:self.context
                                                                   sectionNameKeyPath:nil
                                                                            cacheName:@"Master"];
}

#pragma mark -
#pragma mark For subclass reloading

- (NSArray<NSSortDescriptor *> *)sortDescriptors {
    return nil;
}

- (NSPredicate *)fetchedPredicate {
    return [NSPredicate predicateWithFormat:@"%K CONTAINS %@", self.keyPath, self.model];
}

- (NSPredicate *)filterPredicate {
    return nil;
}

- (NSUInteger)batchCount {
    return 0;
}

#pragma mark -
#pragma mark Public reloaded methods

- (void)performLoading {
    NSError *error = nil;
    if (![self.resultsController performFetch:&error]) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    self.state = !error ? ANSLoadableModelDidLoad : ANSLoadableModelDidFailLoading;
}

- (BOOL)containsObject:(NSManagedObject *)object {
    @synchronized (self) {
        return [self.fetchedPredicate evaluateWithObject:object];
    }
}
    // if invalid index exception rice
- (id)objectAtIndex:(NSUInteger)index {
    @synchronized (self) {
        if (index < self.count) {
            return self.objects[index];
        }
        
        return nil;
    }
}

- (NSUInteger)indexOfObject:(id)object {
    @synchronized (self) {
        return  [[self.resultsController indexPathForObject:object] row];
    }
}

- (void)addObject:(NSManagedObject *)object {
    @synchronized (self) {
        NSPredicate *filterPredicate = [self filterPredicate];
        if (!filterPredicate || [filterPredicate evaluateWithObject:object]) {
            [(NSManagedObject *)self.model addCustomValue:object inMutableSetForKey:self.keyPath];
        }
    }
}

- (void)removeObject:(NSManagedObject *)object {
    @synchronized (self) {
        if ([self containsObject:object]) {
            [(NSManagedObject *)self.model removeCustomValue:object inMutableSetForKey:self.keyPath];
        }
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    @synchronized (self) {
        @synchronized (self) {
            NSManagedObject *object = [self objectAtIndex:index];
            if (object) {
                [object remove];
            }
        }
    }
}

- (void)addObjectsInRange:(NSArray *)objects {
    @synchronized (self) {
        for (id object in objects) {
            [self addObject:object];
        }
    }
}

- (void)removeAllObjects {
    @synchronized (self) {
        NSArray *objects = self.resultsController.fetchedObjects;
        for (id object in objects) {
            [self removeObject:object];
        }
    }
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained [])buffer
                                    count:(NSUInteger)len {
    
    return [self.objects countByEnumeratingWithState:state objects:buffer count:len];
}

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate delegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    @synchronized (self) {
        switch (type) {
            case NSFetchedResultsChangeInsert: {
                [self notifyOfChangeWithIndex:indexPath.row userInfo:nil state:ANSStateAddObject];
            }
                
            case NSFetchedResultsChangeDelete: {
                [self notifyOfChangeWithIndex:indexPath.row userInfo:nil state:ANSStateRemoveObject];
            }
                
            case NSFetchedResultsChangeMove: {
                [self notifyOfChangeWithIndex:indexPath.row
                                       index2:newIndexPath.row
                                     userInfo:nil
                                        state:ANSStateMoveObject];
            }
                
            case NSFetchedResultsChangeUpdate: {
                [self notifyOfChangeWithIndex:indexPath.row userInfo:nil state:ANSStateUpdateObject];
            }
                
            default:
                break;
        }
    }
}

@end
