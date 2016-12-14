//
//  NSFileManager+ANSExtension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import <Foundation/NSPathUtilities.h>

#import "NSFileManager+ANSExtension.h"

static NSString * const kANSPlist = @".plist";

@implementation NSFileManager (ANSExtension)

+ (NSString *)documentDirectoryPath {
    static NSString *path = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        path = [[NSFileManager defaultManager] pathToDocumentDirectory];
    });
    
    return path;
}

- (NSString *)pathToSearchPathDirectory:(NSSearchPathDirectory)directory; {
    return [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) firstObject];
}

- (NSString *)pathToDocumentDirectory {
   return [self pathToSearchPathDirectory:NSDocumentDirectory];
}

- (NSString *)pathToApplicationDirectory {
    return [self pathToSearchPathDirectory:NSApplicationDirectory];
}

- (NSString *)pathToFile:(NSString *)file inSearchPathDirectory:(NSSearchPathDirectory)directory  {
    NSString *directoryPath = [self pathToSearchPathDirectory:directory];
    
    return [directoryPath stringByAppendingPathComponent:file];
}

- (BOOL)fileExists:(NSString *)file inSearchPathDirectory:(NSSearchPathDirectory)directory {
    NSString *filePath = [self pathToFile:file inSearchPathDirectory:directory];
    
    return [self fileExistsAtPath:filePath];
}

- (NSString *)directoryWithName:(NSString *)name inSearchPathDirectory:(NSSearchPathDirectory)directory {
    NSString *directoryPath = [self pathToFile:name inSearchPathDirectory:directory];
    if (![self fileExistsAtPath:directoryPath]) {
        NSError *error = nil;
        BOOL success = [self createDirectoryAtPath:directoryPath
                       withIntermediateDirectories:YES
                                        attributes:nil
                                             error:&error];
        
        if(!success) {
            NSLog(@"[ERROR] %@ (%@)",error, directoryPath);
        }
    }
    
    return directoryPath;
}

- (BOOL)removeFile:(NSString *)file fromSearchPathDirectory:(NSSearchPathDirectory)directory {
    NSString *directoryPath = [self pathToSearchPathDirectory:directory];
    NSString *filePath = [directoryPath stringByAppendingPathComponent:file];
    NSError *error = nil;
        if (![self removeItemAtPath:filePath error:&error]) {
        NSLog(@"[Error] %@ (%@)", error, filePath);
            
        return NO;
    }
    
    return YES;
}

- (BOOL)copyFileAtPath:(NSString *)filePath toSearchPathDirectory:(NSSearchPathDirectory)directory {
    BOOL success = NO;
    if ([self fileExistsAtPath:filePath]) {
        NSString *directoryPath = [self pathToSearchPathDirectory:directory];
        NSString *newPath = [directoryPath stringByAppendingPathComponent:filePath.lastPathComponent];
        NSError *error = nil;
        success = [self copyItemAtPath:filePath toPath:newPath error:&error];
        if (!success) {
            NSLog(@"[ERROR] %@ (%@) (%@)", error, filePath, newPath);
        }
    }
    
    return success;
}

- (NSString *)pathToPlistFile:(NSString *)file
        inSearchPathDirectory:(NSSearchPathDirectory)directory {
    NSString *plistFileName = [file stringByAppendingString:kANSPlist];
    NSString *plistfilePath = [self pathToFile:plistFileName inSearchPathDirectory:directory];
    if (![self fileExistsAtPath:plistfilePath]) {
         NSString *resourcePath = [[[NSBundle mainBundle] resourcePath]
                                   stringByAppendingPathComponent:plistFileName];
        
        BOOL success = [self copyFileAtPath:resourcePath toSearchPathDirectory:directory];
        if (!success) {
            return nil;
        }
    }
    
    return plistfilePath;
}

- (NSArray <NSString *> *)filesNamesAtPath:(NSString *)path {
    NSMutableArray *fileNames = nil;
    NSArray *filePaths = [self contentsOfDirectoryAtPath:path error:nil];
    for (NSString *filePath in filePaths) {
        [fileNames addObject:filePath.lastPathComponent];
    }
    
    return [fileNames copy];
}

- (NSString *)pathToPlistWithName:(NSString *)name inSearchPathDirectory:(NSSearchPathDirectory)directory {
    NSString *plistName = [name stringByAppendingString:kANSPlist];
    NSString *directoryPath = [self pathToSearchPathDirectory:directory];
    
    return [directoryPath stringByAppendingPathComponent: plistName];
}

@end
