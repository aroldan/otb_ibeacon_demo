//
//  OTBViewController.h
//  OntheBarBeaconTest
//
//  Created by Anthony Roldan on 11/24/13.
//  Copyright (c) 2013 Onthebar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTBRegionManager.h"

@interface OTBViewController : UIViewController<OTBRegionManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *broadcastToggleButton;
@property (weak, nonatomic) IBOutlet UITextView *statusText;
@property (strong, nonatomic) OTBRegionManager *regionManager;
- (IBAction)broadcastingWasToggled:(id)sender;

@end
