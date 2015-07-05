//
//  KYAsyncLoadBubble.h
//  KYAsyncLoadBubbleDemo
//
//  Created by Kitten Yang on 7/1/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TapBubbleDelegate <NSObject>

/**
 *  bubble tapped protocol method
 */
-(void)bubbleDidTapped:(NSString *)webContent;

@end

@interface KYAsyncLoadBubble : UIView

/**
 *  The color of bubble  加载球的主题颜色
 */
@property(nonatomic,strong)UIColor *bubbleColor;


/**
 *  The progress of downloading,between 0~1 下载的进度
 */
@property (nonatomic,assign)CGFloat progress;


/**
 *  The string shows on the bubble 显示的文字
 */
@property (nonatomic,strong)NSString *bubbleText;


/**
 *  The url of target web page 网页地址
 */
@property (nonatomic,strong)NSString *webUrl;


/**
 *  Delegate
 */
@property (nonatomic,weak)id <TapBubbleDelegate> delegate;


@end
