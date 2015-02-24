//
//  ViewController.h
//  InStyle
//
//  Created by Karl Campanella-Dysart on 11/24/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "KCDUserClosetModel.h"
#import "KCDTabBarController.h"
#import "KCDDictionary.h"

@interface KCDLoginViewController : UIViewController <CLLocationManagerDelegate>

@property(strong,nonatomic) KCDUserClosetModel* userClosets;
@property(strong,nonatomic) KCDDictionary* userWeather;

//location stuff
@property (strong,nonatomic) CLLocationManager * locationManager;
@property (strong, nonatomic)CLLocation* location;
@property (strong,nonatomic ) NSString* latitude;
@property (strong,nonatomic ) NSString* longitude;

//constant setup
extern NSNumber *freezingTemp;
extern NSNumber *coldTemp;
extern NSNumber *moderateTemp;
extern NSNumber *warmTemp;
extern NSNumber *hotTemp;

extern NSNumber *precipWeather;
@end

