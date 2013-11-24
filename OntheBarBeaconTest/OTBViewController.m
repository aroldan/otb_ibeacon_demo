//
//  OTBViewController.m
//  OntheBarBeaconTest
//
//  Created by Anthony Roldan on 11/24/13.
//  Copyright (c) 2013 Onthebar. All rights reserved.
//

#import "OTBViewController.h"

@interface OTBViewController ()

@end

@implementation OTBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.regionManager = [OTBRegionManager sharedInstance];
    self.regionManager.delegate = self;
    
    self.locationServices = [OTBLocationServices sharedInstance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)broadcastingWasToggled:(id)sender {
    if(self.regionManager.isAvertising) {
        [self.regionManager stopAdvertising];
    } else {
        [self.regionManager beginRegionBroadcast];
    }
    
    [self updateButton];
}

- (IBAction)searchWasToggled:(id)sender {
    [self.locationServices.locationManager startMonitoringForRegion:self.regionManager.otbRegion];
}

- (void)regionManagerStatusChangedTo:(NSString *)status {
    NSLog(@"Changing status: %@", status);
    self.statusText.text = status;
    
    [self updateButton];
}

- (void)updateButton {
    NSString *buttonTitle;
    if([self.regionManager isAvertising]) {
        buttonTitle = @"Stop Broadcasting";
    } else {
        buttonTitle = @"Start Broadcasting";
    }
    
    [self.broadcastToggleButton setTitle:buttonTitle forState:UIControlStateNormal];
}

@end
