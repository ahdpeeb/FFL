//
//  Header.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.

//#empty result
#define ANSEmptyResult

//# Macros generate readonly property for UIView class
#define ANSViewPropertySynthesize(viewClass, propertyName) \
    @property (nonatomic, readonly) viewClass * propertyName;

//# Macros generate getter for UIView property
#define ANSViewGetterSynthesize(viewClass, selector) \
    - (viewClass *)selector { \
        if ([self isViewLoaded] && [self.view isKindOfClass:[viewClass class]]) { \
            return (viewClass *)self.view; \
        } \
        \
        return nil; \
    }

#define ANSViewControllerBaseViewProperty(viewControllerClass, baseViewClass, propertyName) \
    @interface viewControllerClass (__ANSPrivateBaseView) \
    ANSViewPropertySynthesize(baseViewClass, propertyName) \
    \
    @end \
    \
    @implementation viewControllerClass (__ANSPrivateBaseView) \
    @dynamic propertyName; \
    \
    ANSViewGetterSynthesize(baseViewClass, propertyName) \
    @end \

//# Strongify / Weakify
//Weakify and Strongify object before using in block
#define ANSWeakify(object) \
    __weak __typeof(object) __ANSWeekified_##object = object \
//you should call this method after you called ANSWeakify for the same object
#define ANSStrongify(object) \
    __strong __typeof(object) object = __ANSWeekified_##object \

#define ANSStrongifyAndReturnValue(object, value) \
    ANSStrongify(object); \
    if(!object) { \
        return value; \
    } \

//you should call this method after you called ANSWeakify for the same object
#define ANSStrongifyAndReturnNil(object) \
    ANSStrongifyAndReturnValue(object, nil) \

#define ANSStrongifyAndReturn(object) \
    ANSStrongifyAndReturnValue(object, ANSEmptyResult) \

//# performBlock
#define ANSPerformBlock(block, ...) \
    if (block) { \
        block(__VA_ARGS__); \
    } \

#define ANSPerformBlockWithArguments(block, ...) \
    ANSPerformBlock(block, __VA_ARGS__) \

#define ANSPerformBlockWithoutArguments(block) \
    ANSPerformBlock(block, ANSEmptyResult) \

//# object retain count
#define ANSPrintObjectRetainCount(object) \
    NSLog(@#object" retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)object));

//# calls NSException when you call invalid identifier 
#define ANSInvalidIdentifierExceprionRaise(cls) \
 if ([self class] == [cls class]) { \
    [NSException raise:@"Invalid identifier" \
                format:@"You should never call init method for" #cls]; \
} \

