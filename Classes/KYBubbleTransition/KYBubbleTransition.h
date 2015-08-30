//
//  KYBubbleTransition.h
//  guji
//
//  Created by Kitten Yang on 5/15/15.
//  Copyright (c) 2015 Guji Tech Ltd. All rights reserved.
//

typedef enum BubbleTranisionMode{
    Present,
    Dismiss
}BubbleTranisionMode;


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KYBubbleTransition : NSObject<UIViewControllerAnimatedTransitioning>


/*
 *动画执行的时间
 */
@property(nonatomic,assign)CGFloat duration;


/*
 *圆心位置
 */
@property(nonatomic,assign)CGPoint startPoint;


/*
 *颜色
 */
@property(nonatomic,strong)UIColor *bubbleColor;


/*
 *转场类型
 */
@property(nonatomic,assign)BubbleTranisionMode transitionMode;





@end




