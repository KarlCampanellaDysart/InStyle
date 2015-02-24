//
//  UIViewController+KCDClosetTableView.h
//  InStyle
//
//  Created by Karl Campanella-Dysart on 12/11/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCDUserClosetModel.h"
#import "KCDWebViewItem.h"
#import "KCDLoginViewController.h"

@interface  KCDClosetTableView : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) KCDUserClosetModel * userCloset;

@property (strong, nonatomic) UITableView * tableView;

- (NSInteger) numberOfSectionsInTableView:
(UITableView *) tableView;

- (NSInteger) tableView: (UITableView *) tableView
  numberOfRowsInSection: (NSInteger) section;

- (UITableViewCell *) tableView: (UITableView *)
tableView cellForRowAtIndexPath: (NSIndexPath *)
indexPath;

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

@end
