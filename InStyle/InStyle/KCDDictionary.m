//
//  KCDClosetModel.m
//  InStyle
//
//  Created by Karl Campanella-Dysart on 11/24/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import "KCDDictionary.h"

@interface KCDDictionary ()


@end


@implementation KCDDictionary

+(NSDictionary*)dictionaryWithContentsOfJSONURLString:
(NSString*)urlAddress
{
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString: urlAddress] ];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

-(NSData*)toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;    
}

@end


