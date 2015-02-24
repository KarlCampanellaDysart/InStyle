//
//  UICollectionView+KCDCollectionViewQuerryClothes.h
//  InStyle
//
//  Created by Karl Campanella-Dysart on 12/11/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCDDictionary.h"
#import "KCDDetailViewController.h"
#import "KCDUserClosetModel.h"

@interface KCDCollectionViewQuerryClothes : UICollectionViewController

@property (strong, nonatomic) NSString * querry;
@property (strong, nonatomic) KCDUserClosetModel* userCloset;
@end
