//
//  UtilityManager.h
//  DABFormation2
//
//  Created by mac mini pprod 3 on 24/02/2016.
//  Copyright © 2016 mac mini pprod 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface UtilityManager : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
+ (UtilityManager *)sharedUtilityManager;
-(void)askForLocationPermission;
@end
