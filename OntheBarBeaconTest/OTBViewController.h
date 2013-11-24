//
//  OTBViewController.h
//  OntheBarBeaconTest
//
//  Created by Anthony Roldan on 11/24/13.
//  Copyright (c) 2013 Onthebar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTBViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *broadcastToggleButton;
@property (weak, nonatomic) IBOutlet UITextView *statusText;
- (IBAction)broadcastingWasToggled:(id)sender;

@end
