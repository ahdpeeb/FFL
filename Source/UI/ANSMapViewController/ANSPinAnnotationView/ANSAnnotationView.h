//
//  ANSAnnotationView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 24.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <MapKit/MapKit.h>

#import "ANSLoadableModel.h"

@class ANSImageView;
@class ANSFBUser;
                
@interface ANSAnnotationView : MKAnnotationView 
@property (nonatomic, strong) IBOutlet ANSImageView *imageView;

- (void)fillWithUser:(ANSFBUser *)user annotation:(id <MKAnnotation>)annotation;

@end
