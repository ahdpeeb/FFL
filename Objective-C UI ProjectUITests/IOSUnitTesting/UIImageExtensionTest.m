//
//  UIImageExtensionTest.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 12.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "Kiwi.h"

#import "UIImage+ANSExtension.h"

SPEC_BEGIN(UIImageExtensionTest);

describe(@"image saving", ^{
    __block UIImage *image = nil;
    __block NSString *jpegPath = nil;
    __block NSString *pngPath = nil;
    __block NSFileManager *fileManager = nil;
    
    registerMatchers(@"BG");
    context(@"a state the component is in", ^{
    });
    
    beforeAll(^{
        fileManager = [NSFileManager defaultManager];
        
        CGSize size = CGSizeMake(50, 50);
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
        [[UIColor blackColor] setFill];
        UIRectFill(CGRectMake(0, 0, size.width, size.height));
        UIImage *customImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        image = customImage;
    });
    
    beforeEach(^{
//        NSString *path1 = [image pathToPNGRepresentationWithName:@"blia1"];
//        jpegPath = [image pathToJPEGRepresentationWithName:@"blia2" quality:0.5];
    });
    
    it(@"objects validity", ^{
        [[image shouldNot] beNil];
        [[fileManager shouldNot] beNil];
        
        [[jpegPath should] beNil];
        [[pngPath should] beNil];

    });
    
    it(@"saving image to pngPath and ", ^{
        pngPath = [image pathToSavedPNGWithName:@"!@#$%ˆ&*()?>"];
        [[pngPath shouldNot] beNil];
        
        jpegPath = [image pathToSavedJPEGWithName:@"Two!@#$%ˆ&*()?><" quality:1];
        [[jpegPath shouldNot] beNil];
    });
    
    it(@"images should exist at path", ^{
        [[theValue([fileManager fileExistsAtPath:pngPath]) should] beTrue];
        [[theValue([fileManager fileExistsAtPath:jpegPath]) should] beTrue];
    });
    
    it(@"images should be removed at path", ^{
        NSError *error1 = nil;
        [[theValue([fileManager removeItemAtPath:pngPath error:&error1]) should] beTrue];
        
        NSError *error2 = nil;
        [[theValue([fileManager removeItemAtPath:jpegPath error:&error2]) should] beTrue];
    });
    
    it(@"images should not exist at path", ^{
        [[theValue([fileManager fileExistsAtPath:pngPath]) should] beFalse];
        [[theValue([fileManager fileExistsAtPath:jpegPath]) should] beFalse];
    });
    
    afterEach(^{ // Occurs after each enclosed "it"
    });
    
    afterAll(^{ // Occurs once
    });
    
    specify(^{
        [[image shouldNot] beNil];
    });
    
    context(@"inner context", ^{
        it(@"does another thing", ^{
        });
        
    });
});

SPEC_END
