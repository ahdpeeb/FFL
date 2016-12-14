//
//  NSString+ANSExtension.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 09.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "NSString+ANSExtension.h"

@implementation NSString (ANSExtension)

+ (instancetype)randomStringWithLength:(NSUInteger)length
                              alphabet:(NSString *)alphabet
{
    NSMutableString *string = [NSMutableString stringWithCapacity:length];
    for (NSUInteger index = 0; index < length; index ++) {
        [string appendFormat:@"%c", [alphabet characterAtIndex:arc4random_uniform((u_int32_t)length)]];
    }
    
    return [self stringWithString:string];
}
   
+ (instancetype)alphabetWithUnicodeFirstSymbol:(unichar)firstSymbol
                                    lastSymbol:(unichar)lastSymbol
{
    NSMutableString *result = [NSMutableString string];
    NSUInteger headValue = MIN(firstSymbol, lastSymbol);
    NSUInteger tailValue = MAX(firstSymbol, lastSymbol);
    NSRange range = NSMakeRange(headValue, tailValue - headValue + 1);
    for (NSUInteger index = range.location; index <= NSMaxRange(range); index ++) {
        NSString *buffer = [[NSString alloc]initWithBytes:&index
                                                   length:1
                                                 encoding:NSUTF8StringEncoding];
        [result appendString:buffer];
    }
    
    return [self stringWithString:result];
}

+ (instancetype)alphanumericAlphabet {
    NSMutableString *result = [NSMutableString stringWithString:[self letterAlphabet]];
    [result appendString:[self numericAlphabet]];
    
    return [self stringWithString:result];
}

+ (instancetype)numericAlphabet {
    return [self alphabetWithUnicodeFirstSymbol:'0' lastSymbol:'9'];
}

+ (instancetype)lowercaseLetterAlphabet {
    return [self alphabetWithUnicodeFirstSymbol:'a' lastSymbol:'z'];
}

+ (instancetype)capitalizedLetterAlphabet {
    return [self alphabetWithUnicodeFirstSymbol:'A' lastSymbol:'Z'];
}

+ (instancetype)letterAlphabet {
    NSMutableString *result = [NSMutableString new];
    [result appendString:[self lowercaseLetterAlphabet]];
    [result appendString:[self capitalizedLetterAlphabet]];
    
    return [self stringWithString:result];
}

- (NSArray *)symbols {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.length];
    NSUInteger length = [self length];
    
    for (NSUInteger index = 0; index < length; index ++) {
        unichar resultChar = [self characterAtIndex:index];
        [result addObject:[NSString stringWithFormat:@"%c", resultChar]];
    }
    
    return [result copy];
}

@end
