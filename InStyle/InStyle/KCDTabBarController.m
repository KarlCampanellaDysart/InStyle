//
//  UITabBarController+KCDTabBarController.m
//  InStyle
//
//  Created by Karl Campanella-Dysart on 11/26/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import "KCDTabBarController.h"

@interface KCDTabBarController ()

@end

@implementation KCDTabBarController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    KCDTabBarController *tabBar = (KCDTabBarController *)self.tabBarController;
    tabBar.navigationItem.hidesBackButton = YES;
}

@end


