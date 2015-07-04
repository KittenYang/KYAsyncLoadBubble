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

@property(nonatomic,strong)KYAsyncLoadBubble *bubble;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bubble = [KYAsyncLoadBubble new];
    _bubble.bubbleColor = [UIColor colorWithRed:0.0 green:0.487 blue:1.0 alpha:1.0];
    _bubble.progress = 0.3;
    _bubble.bubbleText = @"网页";
    [self.view addSubview:_bubble];
    
    
    
    [self.progressSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];

}

- (void)sliderValueChanged:(UISlider *)sender {
    _bubble.progress = sender.value;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
