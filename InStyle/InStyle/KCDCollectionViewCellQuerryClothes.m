//
//  UICollectionViewCell+KCDCollectionViewCellQuerryClothes.m
//  InStyle
//
//  Created by Karl Campanella-Dysart on 12/11/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import "KCDCollectionViewCellQuerryClothes.h"

@interface  KCDCollectionViewCellQuerryClothes ()

@property (weak, nonatomic) IBOutlet UILabel *labelOutlet;

@property (weak, nonatomic) IBOutlet UIImageView *imageOutlet;

@end

@implementation KCDCollectionViewCellQuerryClothes

-(void) setClothesQuerry:(NSMutableDictionary *)typeClothes{
    
    //dispatch_async(dispatch_get_global_queue(0,0), ^{
        //NSString * imageUrl =[[[[typeClothes objectForKey:@"image_urls"] objectForKey:@"300x400"] objectAtIndex:0] objectForKey:@"url"];

        //NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageUrl]];
        //if ( data == nil )
        //return;
        //dispatch_async(dispatch_get_main_queue(), ^{
          //  UIImage * imageI = [UIImage imageWithData: data];
           // self.imageOutlet.image = imageI;
       // });
    //});
    NSString * imageUrl =[[[[typeClothes objectForKey:@"image_urls"] objectForKey:@"300x400"] objectAtIndex:0] objectForKey:@"url"];
    NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageUrl]];
    
    if ( data == nil ){
        return;
    }
    
    UIImage * imageI = [UIImage imageWithData: data];
    self.imageOutlet.image = imageI;
    [self.labelOutlet setText:[typeClothes objectForKey:@"name"]];
}

@end
