//
//  UIViewController+KCDDetailViewController.m
//  InStyle
//
//  Created by Karl Campanella-Dysart on 12/11/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import "KCDDetailViewController.h"

@interface KCDDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageOutlet;
@property (weak, nonatomic) IBOutlet UILabel *descriptionOutlet;
@property (weak, nonatomic) IBOutlet UILabel *nameOutlet;


@end
@implementation KCDDetailViewController

- (IBAction)addItemToCloset:(id)sender {
    [self.userCloset addToCloset:self.nameOutlet.text WithUrl: [self.clothing objectForKey:@"url"]];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    KCDWebViewItem * dvc = segue.destinationViewController;
    
    dvc.url = [self.clothing objectForKey:@"url"];
}

- (void) viewDidLoad{
    [super viewDidLoad];
    
    self.userCloset = [KCDUserClosetModel sharedModel];
    self.clothing = [self.userCloset.querryData objectAtIndex:self.userCloset.numQuerry];
    
    self.imageUrl =[[[[self.clothing objectForKey:@"image_urls"] objectForKey:@"300x400"] objectAtIndex:0] objectForKey:@"url"];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: self.imageUrl]];
    self.imageOutlet.image = [UIImage imageWithData: imageData];
    
    NSString * descriptionText = [[self.clothing objectForKey:@"content"] objectForKey:@"description"];
    [self.descriptionOutlet setText:descriptionText];
    
    NSString * name = [self.clothing objectForKey:@"name"];
    [self.nameOutlet setText:name];
}


@end
