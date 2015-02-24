//
//  UIViewController+KCDClosetTableView.m
//  InStyle
//
//  Created by Karl Campanella-Dysart on 12/11/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import "KCDClosetTableView.h"

@interface KCDClosetTableView ()

@property NSInteger selectedIndex;

@end

@implementation KCDClosetTableView

- (NSInteger) numberOfSectionsInTableView:
(UITableView *) tableView{
    return 1;
}
- (IBAction)logoutButton:(id)sender {
    NSLog(@"logging out");
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (NSInteger) tableView: (UITableView *) tableView
  numberOfRowsInSection: (NSInteger) section{
    NSLog(@"%lu", (unsigned long)[self.userCloset.closetContent count]);
    return [self.userCloset.closetContent count];
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath{
    //ClosetItem
    static NSString * CellIdentifier = @"ClosetItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    for(id key in [self.userCloset.closetContent objectAtIndex: indexPath.row]){
        cell.textLabel.text = key;
    }
    return cell;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    //NSIndexPath* indexPath = [self.tableView indexPathForRowAtPoint:hitPoint];
    //UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.selectedIndex];

    KCDWebViewItem *dvc = segue.destinationViewController;
    for(id key in [self.userCloset.closetContent objectAtIndex:self.selectedIndex]){
        dvc.url = [[self.userCloset.closetContent objectAtIndex:self.selectedIndex] objectForKey:key];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;
}


- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete){
        NSString* keys;
        for(id key in [self.userCloset.closetContent objectAtIndex: indexPath.row]){
            keys = key;
        }
        [self.userCloset.closetContent removeObjectAtIndex: indexPath.row];
        [self.userCloset.closet removeObjectForKey:keys];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.userCloset saveCloset];
    }
    else if(editingStyle==UITableViewCellEditingStyleInsert){}
}

- (void) viewDidLoad{
    [super viewDidLoad];
    
    self.selectedIndex = 0;
    
    self.tableView.delegate = self;
    
    self.userCloset = [KCDUserClosetModel sharedModel];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}


@end
