//
//  ANSAnnotationView.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSAnnotationView.h"

#import "ANSFBUser.h"
#import "ANSImageView.h"
#import "ANSProtocolObservationController.h"
#import "ANSImageModel.h"

#import "NSBundle+ANSExtenison.h"
#import "ANSImageView+ANSExtension.h"

@interface ANSAnnotationView ()

@end

@implementation ANSAnnotationView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bounds = self.imageView.bounds;
}

- (void)fillWithUser:(ANSFBUser *)user
          annotation:(id <MKAnnotation>)annotation
{
    self.annotation = annotation;
    self.imageView.imageModel = user.imageModel;
    
    self.canShowCallout = YES;
    
    self.rightCalloutAccessoryView = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.leftCalloutAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mapIcon"]];
}

- (void)layoutSubviews {
    [self.imageView roundWithBorderColor:[UIColor blackColor]
                             borderWidth:2.0];
}


@end
