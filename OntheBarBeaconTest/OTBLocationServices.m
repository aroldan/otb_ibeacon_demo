//
//  OTBLocationServices.m
//  OnTheBarNew
//
//  Created by Anthony Roldan on 11/6/12.
//
//

#import "OTBLocationServices.h"
@implementation OTBLocationServices

static OTBLocationServices *sharedInstance = nil;

+ (id)sharedInstance {
    if(sharedInstance == nil) {
        sharedInstance = [[OTBLocationServices alloc] init];
        [sharedInstance initLocationManager];
    }
    
    return sharedInstance;
}

- (void)initLocationManager {
    if(![CLLocationManager locationServicesEnabled]) {
        NSLog(@"Location services not enabled");
        return;
    }
    
    if(_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = 20.0;
        [_locationManager startUpdatingLocation];
    }
}

- (CLLocation *)location {
    return self.locationManager.location;
}

- (BOOL)isEnabled {
    return [CLLocationManager locationServicesEnabled];
}
#pragma mark -
#pragma mark CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    for(CLBeacon *beacon in beacons) {
        NSString *proxString;
        switch(beacon.proximity) {
            case CLProximityFar:
                proxString = @"Far";
                break;
            case CLProximityImmediate:
                proxString = @"immediate";
                break;
            case CLProximityNear:
                proxString = @"Near";
                break;
            case CLProximityUnknown:
                proxString = @"unknown";
                break;
        }
        
        NSLog(@"Beacon %@ at %@", beacon, proxString);
        
        if([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive && beacon.proximity == CLProximityImmediate) {
            NSLog(@"So close");
            UILocalNotification *closeNote = [[UILocalNotification alloc] init];
            closeNote.alertBody = [NSString stringWithFormat:@"Very close to beacon %@ %@", beacon.major, beacon.minor];
            [[UIApplication sharedApplication] scheduleLocalNotification:closeNote];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    NSLog(@"Monitoring for region: %@", region);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *lastLocation = [locations lastObject];
    if(lastLocation.horizontalAccuracy <= self.locationManager.desiredAccuracy) {
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    
    NSLog(@"Entering region %@", [region identifier]);
    NSLog(@"Region type: %@", region);
    
    if([region isKindOfClass:[CLBeaconRegion class]]) {
        NSLog(@"Found a CLBeaconRegion.");
        [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
        
        UILocalNotification *closeNote = [[UILocalNotification alloc] init];
        closeNote.alertBody = [NSString stringWithFormat:@"In region %@", region];
        [[UIApplication sharedApplication] scheduleLocalNotification:closeNote];
    }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"Leaving region %@", [region identifier]);
    
    if([region isKindOfClass:[CLBeaconRegion class]]) {
        [self.locationManager stopRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
    
    if([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
        // if app is active, I don't even know
        NSLog(@"App is active");
    } else {
        NSLog(@"Removing notification");
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
    
}

@end