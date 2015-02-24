//
//  KCDUserClosetModel.h
//  InStyle
//
//  Created by Karl Campanella-Dysart on 11/24/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "KCDDictionary.h"

@interface KCDUserClosetModel : NSObject

@property (strong, nonatomic) NSString * typeWeather;
@property bool isPrecip;

@property (strong, nonatomic) NSMutableDictionary * plist;
@property (strong, nonatomic) NSMutableDictionary * closet;
@property (strong, nonatomic) NSMutableArray * closetContent;

@property (strong,nonatomic) NSString * loggedUser;
@property (strong,nonatomic) NSString * loggedGender;

@property (strong,nonatomic) NSMutableArray * clothesTypes;

@property (strong, nonatomic) NSMutableArray * querryData;
@property NSInteger numQuerry;

-(BOOL)doesUsernameExistInFile: (NSString*) username;
-(void)makeNewAccount: (NSString*) username withPass: (NSString*) pass AndGender: (NSString*) gender;
-(BOOL)checkPassword: (NSString*)password ForUsername:(NSString*) username;

-(void)addToCloset: (NSString*) itemName WithUrl: (NSString*) url;
-(void)saveCloset;
-(void)userLoggedIn;
+ (instancetype) sharedModel;

@end