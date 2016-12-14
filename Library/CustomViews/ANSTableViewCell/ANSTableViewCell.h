//
//  ANSTableViewCell.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 21.07.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>

// You shold never expect the cell have the reuseIdentifier you passed during initialization 
@interface ANSTableViewCell : UITableViewCell

+ (instancetype)cellWithStyle:(UITableViewCellStyle)style;

@end
