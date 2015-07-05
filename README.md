<p align="left" >
  <img src="logo.png" alt="KYAsyncLoadBubble" title="KYAsyncLoadBubble" width = "700">
</p>

![CocoaPods Version](https://img.shields.io/badge/pod-v1.0.2-brightgreen.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-iOS-red.svg)

<p align="left" >
  <img src="asyncloadbubble.gif" alt="asyncloadbubble" title="asyncloadbubble" width = "320">
</p>


##Intro

A bubble which can async-load web content without interrupt your current process.


##Installation

`pod 'KYAsyncLoadBubble', '~> 1.0.2'`


##How to use
```objc

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

```
###Then,you need to immplement the protocol method

```objc
#pragma mark -- TapBubbleDelegate
-(void)bubbleDidTapped:(NSString *)webContent{
    WebViewController *webVc = [[WebViewController alloc]initWithURL:_bubble.webUrl];
    webVc.webContent = webContent;
    [self.navigationController pushViewController:webVc animated:YES];
}

```

## *See more information from the demo project.*



~~***HOLD ON A SECOND...***~~
