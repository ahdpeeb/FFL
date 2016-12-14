//
//  ANSMapView.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 23.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <MapKit/MapKit.h>

#import "ANSRootView.h"

@interface ANSMapView : ANSRootView
@property (nonatomic, strong) IBOutlet MKMapView *map;
@property (nonatomic, strong) IBOutlet UITabBar  *tabBar;

@end
