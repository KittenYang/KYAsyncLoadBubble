//
//  WebViewController.m
//  KYAsyncLoadBubbleDemo
//
//  Created by Kitten Yang on 7/5/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>


@end

@implementation WebViewController{
    NSString *URL;
}


-(id)initWithURL:(NSString *)url{
    self = [super init];
    if (self) {
        
        self = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WebViewController"];
        URL = [url copy];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _webView.scalesPageToFit = YES;
    
    [_webView loadHTMLString:self.webContent baseURL:[NSURL URLWithString:URL]];

    self.title = @"载入中...";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;//显示状态栏的loading图标

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goForward:(id)sender {
    
    if ([_webView canGoForward]) {
        [_webView goForward];
    }
}
- (IBAction)goBack:(id)sender {
    
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
}
- (IBAction)stopLoading:(id)sender {
    
    [_webView stopLoading];

}
- (IBAction)refresh:(id)sender {
    
        [_webView reload];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;//显示状态栏的loading图标
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];    //如何在nav上显示网站的title（执行js代码）
    self.title = title;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"网页加载失败:%@",error);
}

@end
