//
//  ANSMapViewController.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 23.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class ANSMapView;
@class ANSFBUser;

@interface ANSMapViewController : UIViewController <MKMapViewDelegate>
@property (nonatomic, readonly) ANSMapView        *mapView;

@property (nonatomic, strong)   ANSFBUser         *userFriend;
@property (nonatomic, assign)   CLLocationDegrees frindLatitude;
@property (nonatomic, assign)   CLLocationDegrees frindlongitude;

@end
