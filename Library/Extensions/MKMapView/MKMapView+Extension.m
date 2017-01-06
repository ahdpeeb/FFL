//
//  MKMapView+Extension.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 1/6/17.
//  Copyright © 2017 Andriiev.Mykola. All rights reserved.
//

#import "MKMapView+Extension.h"

@implementation MKMapView (Extension)

- (double)zoomLevel{
    CLLocationDegrees longitudeDelta = self.region.span.longitudeDelta;
    CGFloat mapWidthInPixels = self.bounds.size.width;
    double zoomScale = longitudeDelta * MERCATOR_RADIUS * M_PI / (180.0 * mapWidthInPixels);
    double zoomer = MAX_GOOGLE_LEVELS - log2( zoomScale );
    if ( zoomer < 0 ) zoomer = 0;
    
    return zoomer;
}

@end
