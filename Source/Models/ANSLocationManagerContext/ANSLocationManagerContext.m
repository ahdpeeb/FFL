    //
//  ANSLocationManagerContext.m
//  Objective-C UI Project
//
//  Created by Nikola Andriiev on 17.10.16.
//  Copyright © 2016 Andriiev.Mykola. All rights reserved.
//

#import "ANSLocationManagerContext.h"

#import "ANSTargetViewController.h"
#import "ANSLoginView.h"
#import "ANSConstants.h"

#import "UIAlertController+ANSExtenison.h"
#import "ANSGCD.h"

static const    int64_t kANSTimeInterval  = 5;

@interface ANSLocationManagerContext ()
@property (nonatomic, weak)     ANSTargetViewController       *targetViewController;
@property (nonatomic, strong)   NSString                      *targetUserID;
@property (nonatomic, strong)   NSString                      *userID;
@property (nonatomic, strong)   NSDate                        *startDate;

@property (nonatomic, strong) CLLocationManager               *locationManager;
@property (nonatomic, assign) CLLocationDegrees                latitude;
@property (nonatomic, assign) CLLocationDegrees                longitude;

@property (nonatomic, strong) SRWebSocket                      *webSocket;

- (void)connectSocket;
- (NSData *)JSONCoodrinatesDataWithLatitude:(CLLocationDegrees)latitude
                                  longitude:(CLLocationDegrees)longitude;

@end

@implementation ANSLocationManagerContext

#pragma mark -
#pragma mark Initialization and deallocation

- (instancetype)init {
    self = [super init];
    self.locationManager = [CLLocationManager new];
    
    return self;
}

- (instancetype)initWithViewController:(ANSTargetViewController *)controller
                          targetUserID:(NSString *)targetUserID
                          userID:(NSString *)userID
{
    self = [self init];
    self.targetViewController = controller;
    self.targetUserID = targetUserID;
    self.userID = userID;
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (void)setLocationManager:(CLLocationManager *)locationManager {
    if (_locationManager != locationManager) {
        _locationManager = locationManager;
        
        [self askAutorizationStatus];
        
        _locationManager.delegate = self;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.pausesLocationUpdatesAutomatically = NO;
    }
}

#pragma mark -
#pragma mark Private methods

- (void)connectSocket {
    NSURL *url = [NSURL URLWithString:kASNServerAdress];
    self.webSocket = [[SRWebSocket alloc] initWithURL:url];
    self.webSocket.delegate = self;
    [self.webSocket open];
}

- (NSData *)JSONCoodrinatesDataWithLatitude:(CLLocationDegrees)latitude
                                  longitude:(CLLocationDegrees)longitude
{
    NSString *userID = self.userID;
    NSString *targetUserID = self.targetUserID;
    NSDictionary *json = @{@"type":@"send_geo",
                          @"fb_id":userID,
                      @"target_id":targetUserID,
                            @"lat":@(latitude),
                            @"lng":@(longitude)};
    
    return [NSJSONSerialization dataWithJSONObject:json
                                           options:NSJSONWritingPrettyPrinted
                                             error:nil];
}

#pragma mark -
#pragma mark Public Methods

- (void)askAutorizationStatus {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (void)execute {
    [self.locationManager startUpdatingLocation];
}

- (void)cancel {
    [self.locationManager stopUpdatingLocation];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    [self cancel];
    ANSTargetViewController *controller = self.targetViewController;
    UIAlertController *allertController =
    [UIAlertController controllerWithTitle:@"Сan't find location"
                                   message:nil
                          rightAcitonTitle:@"Cancel"
                              rightHandler:^(UIAlertAction *action) {
                         } leftAcitonTitle:@"Repeat"
                               leftHandler:^(UIAlertAction *action) {
                                   [self askAutorizationStatus];
                                   [self execute];
                               }];
    [controller presentAllertController:allertController];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    self.targetViewController.targetView.loadingViewVisible = YES;
    CLLocation *currentLocation = [locations lastObject];
    NSDate *now = [NSDate date];
    NSTimeInterval interval = self.startDate ? [now timeIntervalSinceDate:self.startDate] : 0;
    if (!self.startDate || interval >= kANSTimeInterval) {
        if (self.startDate) {
            [self cancel];
            self.latitude = currentLocation.coordinate.latitude;
            self.longitude = currentLocation.coordinate.longitude;
            [self connectSocket];
        }
        
        self.startDate = now;
    }
}

#pragma mark -
#pragma mark SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    self.targetViewController.targetView.loadingViewVisible = NO;

    NSData *massege = [self JSONCoodrinatesDataWithLatitude:self.latitude
                                                  longitude:self.longitude];
    [webSocket send:massege];
    [webSocket close];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"[INFO]webSocket did receive message - %@", message);
    
    ANSTargetViewController *controller = self.targetViewController;
    UIAlertController *OKController =
    [UIAlertController controllerWithTitle:@"Location sended"
                                   message:@"ВСЕ ЗАЕБИСЬ"
                               acitonTitle:@"OK"
                             acitonHandler:^(UIAlertAction *action) {
                             }];
    
    [controller presentAllertController:OKController];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    self.targetViewController.targetView.loadingViewVisible = NO;
    NSLog(@"[ERROr] %@", [error localizedDescription]);
    
    ANSTargetViewController *controller = self.targetViewController;
    UIAlertController *failedController =
    [UIAlertController controllerWithTitle:@"No server connection"
                                   message:nil
                          rightAcitonTitle:@"Cancel"
                              rightHandler:^(UIAlertAction *action) {
                              } leftAcitonTitle:@"Repeat"
                               leftHandler:^(UIAlertAction *action) {
                                   [self connectSocket];
                               }];
    
    [controller presentAllertController:failedController];
}

@end
