//
//  ViewController.m
//  KYAsyncLoadBubbleDemo
//
//  Created by Kitten Yang on 7/1/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "ViewController.h"
#import "KYAsyncLoadBubble.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KYAsyncLoadBubble *bubble = [KYAsyncLoadBubble new];
    bubble.bubbleColor = [UIColor colorWithRed:0.0 green:0.487 blue:1.0 alpha:1.0];
    [self.view addSubview:bubble];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
