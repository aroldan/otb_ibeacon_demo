//
//  OTBRegionManager.h
//  OntheBarBeaconTest
//
//  Created by Anthony Roldan on 11/24/13.
//  Copyright (c) 2013 Onthebar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol OTBRegionManagerDelegate <NSObject>

- (void)regionManagerStatusChangedTo:(NSString *)status;

@end

@interface OTBRegionManager : NSObject<CBPeripheralManagerDelegate>

+ (instancetype)sharedInstance;
- (void)beginRegionBroadcast;
- (void)stopAdvertising;
- (BOOL)isAvertising;

- (CLBeaconRegion *)otbRegion;

@property (strong, nonatomic) CBPeripheralManager *perhipheralManager;
@property (weak, nonatomic) id<OTBRegionManagerDelegate> delegate;
@property (strong, nonatomic) NSUUID *otbUUID;

@end
