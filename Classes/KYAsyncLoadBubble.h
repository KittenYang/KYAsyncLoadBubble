//
//  KYAsyncLoadBubble.h
//  KYAsyncLoadBubbleDemo
//
//  Created by Kitten Yang on 7/1/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import <UIKit/UIKit.h>


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

@end
