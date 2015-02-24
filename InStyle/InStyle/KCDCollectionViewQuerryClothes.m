//
//  UICollectionView+KCDCollectionViewQuerryClothes.m
//  InStyle
//
//  Created by Karl Campanella-Dysart on 12/11/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import "KCDCollectionViewQuerryClothes.h"
#import "KCDCollectionViewCellQuerryClothes.h"

@interface KCDCollectionViewQuerryClothes ()

@end

@implementation KCDCollectionViewQuerryClothes

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    return 1;
}

- (NSInteger)collectionView: (UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    // data is an array that holds info for the collection view
    //return [self.places count];
    return [self.userCloset.querryData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *) collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KCDCollectionViewCellQuerryClothes * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClothesQuerry" forIndexPath:indexPath];
    
    // Call CollectionViewCell method to set up cell
    
    [cell setClothesQuerry: [self.userCloset.querryData objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation)
toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)
    [self.collectionView collectionViewLayout];
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        
        layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        NSLog(@"flipped");
    } else {
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"DetailSegue"])
    {
        NSArray* indexPathArray = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = indexPathArray[0];
        
        //NSDictionary* typeClothes = [NSDictionary dictionaryWithDictionary:[self.querryData objectAtIndex:indexPath.row]];
        
        //NSString * imageUrl =[[[[typeClothes objectForKey:@"image_urls"] objectForKey:@"300x400"] objectAtIndex:0] objectForKey:@"url"];
        //NSLog(@"%@",imageUrl);
        
        KCDDetailViewController *dvc = segue.destinationViewController;
        dvc.clothing = [self.userCloset.querryData objectAtIndex: indexPath.row];
        
        self.userCloset.numQuerry = indexPath.row;
    }
}


-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.userCloset = [KCDUserClosetModel sharedModel];
    
    NSString * gender;
    if([self.userCloset.loggedGender isEqualToString:@"Female"]){
        gender = @"women";
    }
    else if([self.userCloset.loggedGender isEqualToString:@"Male"]){
        gender = @"men";
    }
    NSString* giltUrl = [NSString stringWithFormat:@"https://api.gilt.com/v1/products?q=%@&store=%@&apikey=a30bc12dca2b7a77fb317bea3a6c5f823e0b1ba445b0a45eb57429503969fbf8",self.querry, gender];
    
    KCDDictionary * userQuerry = [KCDDictionary dictionaryWithContentsOfJSONURLString:giltUrl];
    
    
    self.userCloset.querryData = [[NSMutableArray alloc] initWithArray:[userQuerry objectForKey:@"products"]];
}

@end
