//
//  MKMapView+Extension.h
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 1/6/17.
//  Copyright © 2017 Andriiev.Mykola. All rights reserved.
//

#import <MapKit/MapKit.h>

#define MERCATOR_RADIUS 85445659.44705395
#define MAX_GOOGLE_LEVELS 20

@interface MKMapView (Extension)

- (double)zoomLevel;

@end
