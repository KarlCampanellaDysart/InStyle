//
//  UIViewController+KCDDetailViewController.h
//  InStyle
//
//  Created by Karl Campanella-Dysart on 12/11/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCDUserClosetModel.h"
#import "KCDWebViewItem.h"

@interface KCDDetailViewController : UIViewController

@property (strong, nonatomic) NSDictionary *clothing;
@property (strong, nonatomic) NSString * imageUrl;
@property NSInteger numQuerry;

@property (strong, nonatomic) KCDUserClosetModel * userCloset;
//@property (strong, nonatomic) NSString *imageUrl;

@end
