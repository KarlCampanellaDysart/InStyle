//
//  KCDClosetModel.h
//  InStyle
//
//  Created by Karl Campanella-Dysart on 11/24/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCDDictionary : NSMutableDictionary

+(NSDictionary*)dictionaryWithContentsOfJSONURLString:
(NSString*)urlAddress;
-(NSData*)toJSON;

@end
