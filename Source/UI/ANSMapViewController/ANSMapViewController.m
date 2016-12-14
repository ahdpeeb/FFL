//
//  ANSMapViewController.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 23.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//
#import <AFNetworking.h>

#import "ANSMapViewController.h"

#import "ANSMapView.h"
#import "ANSFBUser.h"
#import "ANSAnnotationView.h"
#import "ANSConstants.h"
#import "ANSLocationManagerContext.h"

#import "NSBundle+ANSExtenison.h"

#import "ANSMacros.h"

ANSViewControllerBaseViewProperty(ANSMapViewController, ANSMapView, mapView);

@interface ANSMapViewController ()
@property (nonatomic, readonly) CLLocation         *friendLocation;
@property (nonatomic, assign)   CLLocation         *userLocationOnMap;
@property (nonatomic, assign)   CLLocationDistance distace;
@property (nonatomic, strong)   NSHashTable        *annotationViews;
@property (nonatomic, strong)   MKPolyline         *route;
@property (nonatomic, assign)   BOOL               shouldDrawRoute;

- (void)showFriendOnMap;
- (CLLocationDistance)distanseToUserLocation:(CLLocation *)userLocation;
- (void)resizeViewsWithLatitudeDelte:(CLLocationDegrees)latitudeDelta;
- (void)setRegionWithCenter:(CLLocationCoordinate2D)center distance:(CLLocationDistance)distance;
- (void)updateRegionWithDistanceDelte:(CLLocationDistance)distanceDelte;

@end

@implementation ANSMapViewController

@dynamic friendLocation;

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    self.annotationViews = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.annotationViews = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
    
    return self;
}

#pragma mark -
#pragma mark View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [[ANSLocationManagerContext new] askAutorizationStatus];
    [self showFriendOnMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Accsessors

- (CLLocation *)friendLocation {
    return [[CLLocation alloc] initWithLatitude:self.frindLatitude
                                      longitude:self.frindlongitude];
}

- (void)setRoute:(MKPolyline *)route {
    if (_route != route) {
        [self.mapView.map removeOverlay:_route];
        _route = route;
        if (route) {
            [self.mapView.map addOverlay:route];
        }
    }
}

#pragma mark -
#pragma mark BarButton items

- (IBAction)friendLocation:(UIBarButtonItem *)sender {
    [self setRegionWithCenter:self.friendLocation.coordinate
                     distance:ANSDistance];
}

- (IBAction)friendsLocation:(UIBarButtonItem *)sender {
    [self updateRegionWithDistanceDelte: -1];
}

- (IBAction)userLocation:(UIBarButtonItem *)sender {
     [self setRegionWithCenter:self.userLocationOnMap.coordinate
                      distance:ANSDistance];
}

- (IBAction)Return:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Private methods

- (void)showFriendOnMap {
    self.mapView.map.showsUserLocation = YES;
    MKPointAnnotation *point = [MKPointAnnotation new];
    CLLocationCoordinate2D coordinate = self.friendLocation.coordinate;
    
    point.coordinate = coordinate;
    point.title = self.userFriend.fullName;

    [self.mapView.map addAnnotation:point];
}

- (CLLocationDistance)distanseToUserLocation:(CLLocation *)userLocation {
    return [self.friendLocation distanceFromLocation:userLocation];
}

- (void)resizeViewsWithLatitudeDelte:(CLLocationDegrees)latitudeDelta {
    CGFloat value = 1 - (latitudeDelta + 10) / 50;
    if (latitudeDelta > 20) {
        value = 0.3;
    }
    
    CGAffineTransform transform = CGAffineTransformMakeScale(value, value);
    for (UIView *view in self.annotationViews) {
        [UIView animateWithDuration:0.5 animations:^{
            view.transform = transform;
        }];
    }
}

- (void)setRegionWithCenter:(CLLocationCoordinate2D)center distance:(CLLocationDistance)distance {
    MKMapView *map = self.mapView.map;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(center, distance, distance);
    [map setRegion:[map regionThatFits:region] animated:YES];
}

- (void)updateRegionWithDistanceDelte:(CLLocationDistance)distanceDelte {
    CLLocation *userLocation = self.userLocationOnMap;
    CLLocationDistance newDistance = [self distanseToUserLocation:userLocation];
    if (!self.distace || newDistance > self.distace + distanceDelte || newDistance < self.distace - distanceDelte) {
        self.distace = newDistance;
        [self setRegionWithCenter:self.userLocationOnMap.coordinate
                         distance: newDistance * 2.25];
    }
}

- (void)drawRoute {
    CLLocationCoordinate2D coordinateArray[2];
    coordinateArray[0] = self.friendLocation.coordinate;
    coordinateArray[1] = self.userLocationOnMap.coordinate;
    MKPolyline *route = [MKPolyline polylineWithCoordinates:coordinateArray count:2];
    self.route = route;
}

#pragma mark -
#pragma mark MKMapViewDelegate protocol

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    double latitudeDelta = mapView.region.span.latitudeDelta;
    [self resizeViewsWithLatitudeDelte:latitudeDelta];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    self.userLocationOnMap = userLocation.location;
    [self updateRegionWithDistanceDelte:ANSAutoResizeDistance];
    self.shouldDrawRoute ? [self drawRoute] : [self setRoute:nil];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }

    NSString *identifier = NSStringFromClass([ANSAnnotationView class]);
    ANSAnnotationView *annotationView =
    (ANSAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView) {
        annotationView = [NSBundle objectWithClass:[ANSAnnotationView class] owner:nil];
    }

    [annotationView fillWithUser:self.userFriend annotation:annotation];
    [self.annotationViews addObject:annotationView];
    
    return annotationView;
}

- (void)                  mapView:(MKMapView *)mapView
                   annotationView:(MKAnnotationView *)view
    calloutAccessoryControlTapped:(UIControl *)control
{
    if([control class] == [UISwitch class]) {
        UISwitch *swich = (UISwitch *)control;
        self.shouldDrawRoute = swich.isOn;
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id <MKOverlay>)overlay
{
    MKPolylineRenderer *line = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    line.strokeColor = [UIColor lightGrayColor];
    line.lineWidth = 2.0;
    return line;
}

@end
