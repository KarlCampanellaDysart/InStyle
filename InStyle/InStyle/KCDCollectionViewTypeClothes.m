//
//  UICollectionView+KCDCollectionViewTypeClothes.m
//  InStyle
//
//  Created by Karl Campanella-Dysart on 12/3/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import "KCDCollectionViewTypeClothes.h"

@interface KCDCollectionViewTypeClothes ()

@end

@implementation KCDCollectionViewTypeClothes

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    return 1;
}

- (NSInteger)collectionView: (UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    // data is an array that holds info for the collection view
    //return [self.places count];
    return [self.relavantClothes count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *) collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KCDCollectionViewTypeClothesCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TypeClothes" forIndexPath:indexPath];
    
    // Call CollectionViewCell method to set up cell
    for(NSMutableDictionary *dict in self.userClosets.clothesTypes){
        if([[dict objectForKey:@"name"] isEqualToString:[self.relavantClothes objectAtIndex:indexPath.row]]){
            [cell setTypeClothes: dict];
        }
    }
    
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
    if([segue.identifier isEqualToString:@"QuerrySegue"])
    {
        NSArray* indexPathArray = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = indexPathArray[0];
        
        
        KCDCollectionViewQuerryClothes *dvc = segue.destinationViewController;
        
        NSArray * splitQuerry = [[self.relavantClothes objectAtIndex:indexPath.row] componentsSeparatedByString:@" "];
        
        if([splitQuerry count] > 0){
            NSString * newQuerry = @"";
            for(int i = 0; i<[splitQuerry count];i++){
                if(i == [splitQuerry count]-1){
                    newQuerry = [newQuerry stringByAppendingString:[splitQuerry objectAtIndex:i]];
                }
                else{
                    NSString * tempString =[NSString stringWithFormat:@"%@+",[splitQuerry objectAtIndex:i]];
                    newQuerry = [newQuerry stringByAppendingString:tempString];
                }
            }
            dvc.querry = newQuerry;
        }
        else{
            dvc.querry = [self.relavantClothes objectAtIndex:indexPath.row];
        }
        
    }
}

-(void) viewDidLoad{
    [super viewDidLoad];
    self.userClosets = [KCDUserClosetModel sharedModel];
    //[self.navigationItem.t]
    self.navigationItem.hidesBackButton = YES;
    
    //set up what's in relavantClothes
    
    if(self.userClosets.isPrecip){
        if([self.userClosets.typeWeather isEqualToString:@"freezing"]){
            self.relavantClothes = [[NSMutableArray alloc] initWithObjects:@"snow jackets", @"boots", @"earmuffs", @"longsleeves",@"snow pants", nil];
        }
        else{
            self.relavantClothes = [[NSMutableArray alloc] initWithObjects:@"rain jackets", @"boots", @"longsleeves",@"pants",@"hats", @"hoodies", nil];
        }
    }
    else{
        if([self.userClosets.typeWeather isEqualToString:@"freezing"]){
            self.relavantClothes = [[NSMutableArray alloc] initWithObjects:@"heavy jackets", @"boots", @"earmuffs", @"longsleeve",@"pants", nil];
        }
        else if([self.userClosets.typeWeather isEqualToString:@"cold"]){
            self.relavantClothes = [[NSMutableArray alloc] initWithObjects:@"sweaters", @"sneakers", @"longsleeves", @"button down shirts", @"scarfs", @"pants", nil];
        }
        else if([self.userClosets.typeWeather isEqualToString:@"moderate"]){
            self.relavantClothes = [[NSMutableArray alloc] initWithObjects:@"light jackets",@"scarfs", @"pants", @"flannels", @"buttonups", @"sneakers", nil];
        }
        else if([self.userClosets.typeWeather isEqualToString:@"warm"]){
            self.relavantClothes = [[NSMutableArray alloc] initWithObjects:@"shorts", @"tees", @"boatshoes",@"sneakers",@"hats", nil];
        }
        else if([self.userClosets.typeWeather isEqualToString:@"hot"]){
            self.relavantClothes = [[NSMutableArray alloc] initWithObjects:@"sandles", @"tees", @"hats", @"bathing suits", @"shorts", @"tanktops", nil];
        }
    }
    
}

@end

