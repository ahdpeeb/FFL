//
//  ANSArrayModelTest.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 18.08.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "Kiwi.h"

#import "ANSArrayModel.h"
#import "ANSUser.h"
#import "NSArray+ANSExtension.h"

SPEC_BEGIN(ANSArrayModelTest);

describe(@"ANSArrayModel", ^{
    __block ANSArrayModel *collection;
    
    registerMatchers(@"BG");
    context(@"a state the component is in", ^{
        });
        
        beforeAll(^{
            collection = [ANSArrayModel new];
        });
    
        beforeEach(^{
            NSArray *objects = [NSArray objectsWithCount:100 block:^id{
                return [[ANSUser alloc] init];
            }];
            
            [collection addObjectsInRange:objects];
        });
    
        it(@"objectAtIndex:100 shoudNot raise", ^{
            [[theBlock(^{
                [collection objectAtIndex:100];
            }) should] raise];
        });
    
        it(@"should contain's  200 objects", ^{
            [[theValue(200) should] equal:theValue(collection.count)];
        });
            
        it(@"user99 must move to user0 position, user0 automatically become user1 ", ^{
            ANSUser *user0 = [collection objectAtIndex:0];
            ANSUser *user99 = [collection objectAtIndex:99];
            [collection moveObjectFromIndex:99 toIndex:0];
            
            [[[collection objectAtIndex:0] should] beIdenticalTo:user99];
            [[[collection objectAtIndex:1] should] beIdenticalTo:user0];
        });
    
        it(@"user0 should stay on 0 position after move on 400index", ^{
            ANSUser *user0 = [collection objectAtIndex:0];
            
            [[theValue(collection.count) should] equal:theValue(400)];
            
            [collection moveObjectFromIndex:0 toIndex:400];
            [[[collection objectAtIndex:0] should] beIdenticalTo:user0];
        });
    
        afterEach(^{ // Occurs after each enclosed "it"
        });
        
        afterAll(^{ // Occurs once
        });
        
        specify(^{
            [[collection shouldNot] beNil];
        });
        
        context(@"inner context", ^{
            it(@"does another thing", ^{
            });
            
        });
    });

SPEC_END
    