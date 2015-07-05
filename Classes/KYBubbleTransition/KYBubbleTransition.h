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



@property(nonatomic,assign)CGFloat duration;
@property(nonatomic,assign)CGPoint startPoint;
@property(nonatomic,assign)BubbleTranisionMode transitionMode;
@property(nonatomic,strong)UIColor *bubbleColor;

@end
