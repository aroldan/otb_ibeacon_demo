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

- (void)startBroadcastingRegion {
    
}

@end
