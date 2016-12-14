//
//  NSJSONSerialization+Extension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 26.09.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (Extension)

//A data object containing JSON data. If an error occurs while parsing data, returns error, owirwice foundation object from the JSON data 
+ (id)JSONFromData:(NSData *)data;

@end
