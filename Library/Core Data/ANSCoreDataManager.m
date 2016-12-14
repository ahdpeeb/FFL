//
//  ANSCoreDataManager.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 04.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSCoreDataManager.h"

#import "NSFileManager+ANSExtension.h"

static NSString * const kANSMomExtension =  @"momd";
static NSString * const kANSSqlite       =  @"sqlite";

@interface ANSCoreDataManager ()
@property (nonatomic, strong) NSManagedObjectContext       *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectModel         *managedObjectModel;

@property (nonatomic, copy)     NSString     *momName;
@property (nonatomic, copy)     NSString     *storeName;
@property (nonatomic, assign)   ANSStoreType storeType;

@property (nonatomic, readonly) NSString     *projectName;

- (void)raiseInfrastructure;
- (NSString *)stringFromStoreType:(ANSStoreType)storeType;
- (NSURL *)persistentStoreURL;

@end

@implementation ANSCoreDataManager

@dynamic projectName;

#pragma mark -
#pragma mark Class methods

+ (instancetype)sharedManager {
    return [self sharedManagerWithMomName:nil];
}

+ (instancetype)sharedManagerWithMomName:(NSString *)momName {
    return [self sharedManagerWithMomName:momName storeName:nil storeType:0];
}

+ (instancetype)sharedManagerWithMomName:(NSString *)momName
                               storeName:(NSString *)storeName
                               storeType:(ANSStoreType)storeType;
{
    static ANSCoreDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ANSCoreDataManager alloc] initWithMomName:momName storeName:storeName storeType:storeType];
        [manager raiseInfrastructure];
    });

    return manager;
}

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)initWithMomName:(NSString *)momName {
    return [self initWithMomName:momName storeName:nil storeType:0];
}

- (instancetype)initWithMomName:(NSString *)momName
                      storeName:(NSString *)storeName
                      storeType:(ANSStoreType)storeType
{
    self = [super init];
    self.momName = momName;
    self.storeName = storeName;
    self.storeType = storeType;
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    
    NSString *momName = self.momName;
    if (!momName) {
        [[NSException exceptionWithName:@"unvalid momName"
                                 reason:@"CoreDataManager momName"
                               userInfo:nil] raise];
    }
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:momName withExtension:kANSMomExtension];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator ) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSString *storeType = [self stringFromStoreType:self.storeType];
    
    NSError *error = nil;
    [_persistentStoreCoordinator addPersistentStoreWithType:storeType
                                              configuration:nil
                                                        URL:[self persistentStoreURL]
                                                    options:nil
                                                      error:&error];
    if (error) {
        //correct this logic (is store loading failed - remove store)
        NSLog(@"[ERROR] %@", [error localizedDescription]);
        NSURL *url = [self persistentStoreURL];
        NSError *deleteError = nil;
        [[NSFileManager defaultManager] removeItemAtURL:url error:&deleteError];
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
    if (coordinator) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = coordinator;
    }
    
    return _managedObjectContext;
}

- (NSString *)projectName {
    return  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

#pragma mark -
#pragma mark Private methods

- (void)raiseInfrastructure {
    __unused id result = (self.managedObjectContext);
}

- (NSString *)stringFromStoreType:(ANSStoreType)storeType {
    switch (storeType) {
        case ANSStoreTypeSQLLite:  return NSSQLiteStoreType;
        case ANSStoreTypeBinary:   return NSBinaryStoreType;
        case ANSStoreTypeInMemory: return NSInMemoryStoreType;
    }
}

- (NSURL *)persistentStoreURL {
    NSString *storeName = self.storeName;
    
    NSString *fileName = storeName ? storeName : [self.projectName stringByAppendingPathExtension:kANSSqlite];
    
    NSString *directoryPath = [[NSFileManager defaultManager] pathToDocumentDirectory];
    NSString *pathToStore = [directoryPath stringByAppendingPathComponent:fileName];
    
    return [NSURL fileURLWithPath:pathToStore];
}

@end
