//
//  KCDUserClosetModel.m
//  InStyle
//
//  Created by Karl Campanella-Dysart on 11/24/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//
//http://api.worldweatheronline.com/free/v2/weather.ashx?key=adc806be389bed380ac6f465c53e6&q=48.85,2.35&num_of_days=2&tp=3&format=json

#import "KCDUserClosetModel.h"

@interface KCDUserClosetModel ()

@property (strong, nonatomic) NSString * documentsDirectory;

@end

NSString *const userPlist = @"userClosets.plist";
NSString *const name = @"username";
NSString *const closet = @"closet";

@implementation KCDUserClosetModel

- (id)init
{
    self = [super init];
    if (self) {
        _querryData = [[NSMutableArray alloc] init];
        _clothesTypes = [[NSMutableArray alloc]init];
        _closetContent = [[NSMutableArray alloc]init];
        _closet = [[NSMutableDictionary alloc]init];
        
        //file io stuff
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
        _documentsDirectory = [paths objectAtIndex:0];
        
        NSLog(@"%@",_documentsDirectory);
        
        NSString * filepath = [_documentsDirectory stringByAppendingPathComponent:userPlist];
        
        _plist = [NSMutableDictionary dictionaryWithContentsOfFile:filepath];
        
        if(!_plist){
            _plist = [[NSMutableDictionary alloc] init];

            //[_plist setObject:@"test" forKey:@"test"];
            [_plist writeToFile:filepath atomically:YES];
        }
        else{
            //we have all the accounts loaded
        }
    }
    return self;
}

-(void) save{
    NSString * filepath = [self.documentsDirectory stringByAppendingPathComponent:userPlist];
    
    [self.plist writeToFile:filepath atomically:YES];
}

-(BOOL)checkPassword: (NSString*)password ForUsername:(NSString*) username{
    if([[self.plist objectForKey:username]  isEqualToString:password]){
        return true;
    }
    return false;
}

-(BOOL)doesUsernameExistInFile: (NSString*) username{
    if([self.plist objectForKey:username]){
        return true;
    }
    return false;
}

-(void)userLoggedIn{
    NSMutableString* filename = [[NSMutableString alloc]initWithString:self.loggedUser];
    [filename appendString:@".plist"];
    NSString* filepath = [self.documentsDirectory stringByAppendingPathComponent:filename];
    
    if(!self.closet){
        NSLog(@"issue with user plists");
    }
    self.closet = [NSMutableDictionary dictionaryWithContentsOfFile:filepath];
    self.loggedGender = [self.closet objectForKey:@"gender"];
    
    [self.closetContent removeAllObjects];
    for(id key in self.closet){
        if([key isEqualToString:@"gender"]){}
        //else if([self.closetContent count] == [self.closet count]-1){}
        else{
            NSDictionary *tuple = [NSDictionary dictionaryWithObject:[self.closet objectForKey:key] forKey:key];
            [self.closetContent addObject:tuple];
        }
    }
}

-(void)makeNewAccount: (NSString*) username withPass: (NSString*) pass AndGender: (NSString*) gender{
    
    ///Make a new file//
    NSMutableString* filename = [[NSMutableString alloc]initWithString:username];
    [filename appendString:@".plist"];
    NSString* filepath = [self.documentsDirectory stringByAppendingPathComponent:filename];
    
    NSMutableDictionary* allClothes = [[NSMutableDictionary alloc] init];
    
    [allClothes setObject:gender forKey:@"gender"];
    self.closet = [NSMutableDictionary dictionaryWithDictionary:allClothes];
    [allClothes writeToFile:filepath atomically:YES];
    
    [self.plist setObject:pass forKey:username];
    self.loggedGender = gender;
    [self save];
}

-(void)addToCloset: (NSString*) itemName WithUrl: (NSString*) url{
    if(!url){}
    else{
     [self.closet setObject:url forKey:itemName];
        NSDictionary *tempDict = [NSDictionary dictionaryWithObject:url forKey:itemName];
        NSDictionary *tuple = [[NSDictionary alloc] initWithDictionary:tempDict];
        [self.closetContent addObject:tuple];
        //NSLog(@"added %@",itemName);
        [self saveCloset];
    }
}

-(void)saveCloset{
    NSMutableString* filename = [[NSMutableString alloc]initWithString:self.loggedUser];
    [filename appendString:@".plist"];
    NSString* filepath = [self.documentsDirectory stringByAppendingPathComponent:filename];
    
    [self.closet writeToFile:filepath atomically:YES];
}

+(instancetype) sharedModel{
    static KCDUserClosetModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedModel = [[self alloc] init];
        
    });
    return _sharedModel;
}



@end
