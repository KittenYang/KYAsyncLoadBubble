//
//  ViewController.m
//  KYAsyncLoadBubbleDemo
//
//  Created by Kitten Yang on 7/1/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "ViewController.h"
#import "KYAsyncLoadBubble.h"
#import "KYBubbleTransition.h"
#import "WebViewController.h"

#import "AFURLConnectionOperation.h"



@interface ViewController ()<UINavigationControllerDelegate,TapBubbleDelegate>

@property(nonatomic,strong)KYAsyncLoadBubble *bubble;
@property (strong,nonatomic)KYBubbleTransition *bubbleTransition;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    [self.progressSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];

}

- (void)sliderValueChanged:(UISlider *)sender {
    _bubble.progress = sender.value;
    
}

- (IBAction)addBubble:(id)sender {

    
    for (UIView *subview in self.view.subviews) {
        if ([subview isKindOfClass:[KYAsyncLoadBubble class]]) {
            return;
        }
    }
    _bubble = [KYAsyncLoadBubble new];
    _bubble.bubbleColor = [UIColor colorWithRed:0.0 green:0.487 blue:1.0 alpha:1.0];
    _bubble.progress = 0.0;
    _bubble.bubbleText = @"网页";
    _bubble.delegate = self;
    _bubble.webUrl = @"http://kittenyang.com/deformationandgooey/";
    [self.view addSubview:_bubble];
        
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- TapBubbleDelegate
-(void)bubbleDidTapped:(NSString *)webContent{
    WebViewController *webVc = [[WebViewController alloc]initWithURL:_bubble.webUrl];
    webVc.webContent = webContent;
    [self.navigationController pushViewController:webVc animated:YES];
}



#pragma mark -- UINavigationControllerDelegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        self.bubbleTransition = [KYBubbleTransition new];
        self.bubbleTransition.transitionMode = Present;
        self.bubbleTransition.startPoint = _bubble.center;
        self.bubbleTransition.bubbleColor = _bubble.bubbleColor;
        self.bubbleTransition.duration = 0.4;
        return self.bubbleTransition;
    }else if(operation == UINavigationControllerOperationPop){
        self.bubbleTransition = [KYBubbleTransition new];
        self.bubbleTransition.transitionMode = Dismiss;
        self.bubbleTransition.startPoint = _bubble.center;
        self.bubbleTransition.bubbleColor = _bubble.bubbleColor;
        self.bubbleTransition.duration = 0.4;
        return self.bubbleTransition;
    }
    return nil;
}

@end
