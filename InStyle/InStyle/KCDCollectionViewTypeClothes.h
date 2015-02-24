//
//  UICollectionView+KCDCollectionViewTypeClothes.h
//  InStyle
//
//  Created by Karl Campanella-Dysart on 12/3/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.

//gilt api key
//a30bc12dca2b7a77fb317bea3a6c5f823e0b1ba445b0a45eb57429503969fbf8

/*basic clothes/weather distinctions

gender - male, female
 
snow - snow jacket, boots, earmuffs, longsleeve
rain - rain jacket, rain boots, pants, longsleeve, hoods
hot - sandles, sun hat, bathing suits, shorts, tanks
cold and dry - sweater, sneakers, longsleeve, buttonups
warm - shorts, teeshirts, boatshoes, 
fall moderate - scarf, pants, flannels, buttonups, sneakers
*/

#import <UIKit/UIKit.h>
#import "KCDUserClosetModel.h"
#import "KCDCollectionViewTypeClothesCell.h"
#import "KCDCollectionViewQuerryClothes.h"

@interface KCDCollectionViewTypeClothes : UICollectionViewController

@property (strong, nonatomic) NSMutableArray * relavantClothes;
@property (strong,nonatomic) KCDUserClosetModel * userClosets;

@end
