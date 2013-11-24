//
//  OTBLocationServices.h
//  OnTheBarNew
//
//  Created by Anthony Roldan on 11/6/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol OTBLocationBTLEDelegate <NSObject>

@end

@interface OTBLocationServices : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

+ (id)sharedInstance;

- (BOOL)isEnabled;
- (CLLocation *)location;

@end
