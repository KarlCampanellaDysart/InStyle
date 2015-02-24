//
//  UICollectionViewCell+KCDCollectionViewTypeClothesCell.m
//  InStyle
//
//  Created by Karl Campanella-Dysart on 12/3/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import "KCDCollectionViewTypeClothesCell.h"

@interface KCDCollectionViewTypeClothesCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageOutlet;
@property (weak, nonatomic) IBOutlet UILabel *labelOutlet;

@end

@implementation KCDCollectionViewTypeClothesCell

-(void) setTypeClothes:(NSMutableDictionary *)typeClothes{
    
    UIImage * imageI = [UIImage imageNamed:[typeClothes objectForKey:@"picture"]];
    
    self.imageOutlet.image = imageI;
    [self.labelOutlet setText:[typeClothes objectForKey:@"name"]];
}

@end
