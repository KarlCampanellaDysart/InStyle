//
//  UIViewController+KCDWebViewItem.m
//  InStyle
//
//  Created by Karl Campanella-Dysart on 12/11/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import "KCDWebViewItem.h"

@interface KCDWebViewItem ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation KCDWebViewItem


- (IBAction)logout:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
}

-(void) viewDidLoad{
    [super viewDidLoad];
    
    NSURL *webUrl = [NSURL URLWithString: self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL: webUrl];
    [self.webView loadRequest: request];
}

@end
