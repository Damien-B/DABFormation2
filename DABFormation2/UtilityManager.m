//
//  UtilityManager.m
//  DABFormation2
//
//  Created by mac mini pprod 3 on 24/02/2016.
//  Copyright © 2016 mac mini pprod 3. All rights reserved.
//

#import "UtilityManager.h"

@implementation UtilityManager

+ (UtilityManager *)sharedUtilityManager {
    static UtilityManager *sharedManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManager = [[UtilityManager alloc] init];
    });
    return sharedManager;
}

-(CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [CLLocationManager new];
        [_locationManager setDelegate:self];
    }
    return _locationManager;
}

-(void)askForLocationPermission {
    [self.locationManager requestWhenInUseAuthorization];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    DLog(@"didChangeAuthorizationStatus : %d", status);
}

@end
