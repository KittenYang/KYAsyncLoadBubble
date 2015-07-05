//
//  WebViewController.h
//  KYAsyncLoadBubbleDemo
//
//  Created by Kitten Yang on 7/5/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;

/**
 *  init method
 *
 *  @param url  The url you wanna request.
 *
 *  @return self
 */
- (id)initWithURL:(NSString *)url;

@end
