//
//  ANSTableViewcell.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSTableViewCell.h"

@interface ANSTableViewCell ()

@end

@implementation ANSTableViewCell

#pragma mark -
#pragma mark Public methods

+ (instancetype)cellWithStyle:(UITableViewCellStyle)style {
   return [[self alloc] initWithStyle:(style) reuseIdentifier:NSStringFromClass([self class])];
}

#pragma mark -
#pragma mark Reloaded property

- (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
