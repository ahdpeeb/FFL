//
//  ANSCoreDataManager.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 04.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ANSStoreType) {
    ANSStoreTypeSQLLite,
    ANSStoreTypeBinary,
    ANSStoreTypeInMemory
};

@interface ANSCoreDataManager : NSObject
@property (nonatomic, readonly) NSManagedObjectContext       *managedObjectContext;
@property (nonatomic, readonly) NSManagedObjectModel         *managedObjectModel;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// SharedManager for main thread
// MOM name in main bunble. default store type ANSStoreTypeSQLLite;
+ (instancetype)sharedManager;

+ (instancetype)sharedManagerWithMomName:(NSString *)momName;

// custom store name must contains file extension
+ (instancetype)sharedManagerWithMomName:(NSString *)momName
                               storeName:(NSString *)storeName
                               storeType:(ANSStoreType)storeType;

// this method intedded for creatind additional data managers
- (instancetype)initWithMomName:(NSString *)momName;

- (instancetype)initWithMomName:(NSString *)momName
                      storeName:(NSString *)storeName
                      storeType:(ANSStoreType)storeType;

@end
