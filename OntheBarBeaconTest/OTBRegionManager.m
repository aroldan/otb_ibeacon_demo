//
//  OTBRegionManager.m
//  OntheBarBeaconTest
//
//  Created by Anthony Roldan on 11/24/13.
//  Copyright (c) 2013 Onthebar. All rights reserved.
//

#import "OTBRegionManager.h"

static OTBRegionManager *sharedInstance = nil;

@implementation OTBRegionManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[OTBRegionManager alloc] init];
    });
    
    return sharedInstance;
}

- (void)beginRegionBroadcast {
    if(self.perhipheralManager == nil) {
        self.perhipheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        self.otbUUID = [[NSUUID alloc] initWithUUIDString:@"9c07c312-14d2-475b-beee-3853ffc14eb4"];
    }
    return self;
}

- (CLBeaconRegion *)otbRegion {
    return [[CLBeaconRegion alloc] initWithProximityUUID:self.otbUUID identifier:@"onthebarRegion"];
}

- (void)startAdvertisingRegion {
    CLBeaconRegion *advertisingRegion = [[CLBeaconRegion alloc] initWithProximityUUID:self.otbUUID major:10 minor:5 identifier:@"onthebarRegion"];
    
    NSDictionary *beaconConfig = [advertisingRegion peripheralDataWithMeasuredPower:nil];
    
    [self.perhipheralManager startAdvertising:beaconConfig];
    [self.delegate regionManagerStatusChangedTo:[NSString stringWithFormat:@"Broadcasting for region with UUID %@", self.otbUUID]];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (void)stopAdvertising {
    [self.perhipheralManager stopAdvertising];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (BOOL)isAvertising {
    return [self.perhipheralManager isAdvertising];
}

#pragma mark - CBPeripheralManagerDelegate methods

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    
    NSString *status;
    switch (peripheral.state) {
        case CBPeripheralManagerStateUnsupported:
            // ensure you are using a device supporting Bluetooth 4.0 or above.
            // not supported on iOS 7 simulator
            status = @"Device platform does not support BTLE peripheral role.";
            break;
            
        case CBPeripheralManagerStateUnauthorized:
            // verify app is permitted to use Bluetooth
            status = @"App is not authorized to use BTLE peripheral role.";
            break;
            
        case CBPeripheralManagerStatePoweredOff:
            // Bluetooth service is powered off
            status = @"Bluetooth service is currently powered off on this device.";
            break;
            
        case CBPeripheralManagerStatePoweredOn:
            // start advertising CLBeaconRegion
            status = @"Now advertising iBeacon signal.  Monitor other device for location updates.";
            [self startAdvertisingRegion];
            break;
            
        case CBPeripheralManagerStateResetting:
            // Temporarily lost connection
            status = @"Bluetooth connection was lost.  Waiting for update...";
            [self stopAdvertising];
            break;
            
        case CBPeripheralManagerStateUnknown:
        default:
            // Connection status unknown
            status = @"Current peripheral state unknown.  Waiting for update...";
            break;
    }
    
    [self.delegate regionManagerStatusChangedTo:status];
}

@end
