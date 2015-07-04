//
//  KYAsyncLoadBubble.m
//  KYAsyncLoadBubbleDemo
//
//  Created by Kitten Yang on 7/1/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#define SCREENWIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT   [UIScreen mainScreen].bounds.size.height
#define RADIUS         40


#import "KYAsyncLoadBubble.h"
#import "MultiplePulsingHaloLayer.h"

@interface KYAsyncLoadBubble()

@property(nonatomic,weak)UIView *spView;

@end

@implementation KYAsyncLoadBubble{
    
    UIView *closeArea;
    MultiplePulsingHaloLayer *pulseLayer;
}


-(id)init{

    self = [super init];
    if (self){
        
    }
    return self;
    
}



#pragma mark -- PUBLIC METHOD


#pragma mark -- OVERRIDE METHOD
-(void)willMoveToSuperview:(UIView *)newSuperview{
    
    self.backgroundColor = self.bubbleColor;
    self.layer.cornerRadius = RADIUS/2;
    self.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT + RADIUS);
    [UIView animateWithDuration:0.6 delay:1.0 usingSpringWithDamping:0.6f initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        self.frame = CGRectMake(SCREENWIDTH-RADIUS, 100, RADIUS, RADIUS);
        
    } completion:^(BOOL finished) {
        
    }];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragBubble:)];
    self.spView = newSuperview;
    [self addGestureRecognizer:pan];
    
}


#pragma mark -- PRIVATE METHOD

-(void)dragBubble:(UIPanGestureRecognizer *)panGes{
    
    CGPoint currentPoint = [panGes locationInView:self.spView];
    
    CGPoint destinationPoint;
    
    if (panGes.state == UIGestureRecognizerStateBegan) {

        if (closeArea == nil) {
            closeArea = [[UIView alloc]init];
            closeArea.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT-RADIUS/2);
            closeArea.bounds = CGRectMake(0, 0, RADIUS, RADIUS);
            closeArea.layer.cornerRadius = RADIUS/2;
            closeArea.backgroundColor = self.bubbleColor;
            
            
            UILabel *closeText = [[UILabel alloc]initWithFrame:closeArea.bounds];
            closeText.font = [UIFont systemFontOfSize:16.0f];
            closeText.textColor = [UIColor whiteColor];
            closeText.textAlignment = NSTextAlignmentCenter;
            closeText.text = @"关闭";
            
            [closeArea addSubview:closeText];
            [self.spView addSubview:closeArea];
            
            
            closeArea.transform = CGAffineTransformScale(closeText.transform, 0.2, 0.2);
            
            [UIView animateWithDuration:0.6 delay:0.0 usingSpringWithDamping:0.6f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{

                closeArea.transform = CGAffineTransformIdentity;
                
            } completion:^(BOOL finished) {
                
                if (pulseLayer == nil && closeArea != nil) {
                    pulseLayer = [[MultiplePulsingHaloLayer alloc] initWithHaloLayerNum:3 andStartInterval:1];
                    pulseLayer.position = closeArea.center;
                    pulseLayer.useTimingFunction = NO;
                    pulseLayer.animationDuration = 2.0f;
                    [pulseLayer buildSublayers];
                    pulseLayer.fromValueForRadius = 0.3;
                    pulseLayer.haloLayerColor = self.bubbleColor.CGColor;
                    [self.spView.layer insertSublayer:pulseLayer below:closeArea.layer];
                }
                
            }];
        
        }
        
        
    }else if (panGes.state == UIGestureRecognizerStateChanged){

        self.center = currentPoint;
        
        if (CGRectContainsPoint(closeArea.frame,currentPoint)) {
            
            [UIView animateWithDuration:0.3 animations:^{
                closeArea.transform = CGAffineTransformMakeScale(1.5, 1.5);
            } completion:^(BOOL finished) {
                
            }];
            
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                closeArea.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }
        
    }else if (panGes.state == UIGestureRecognizerStateEnded || panGes.state == UIGestureRecognizerStateCancelled){
        
        [pulseLayer stopPulse];
        pulseLayer  = nil;

        destinationPoint = [self destinationPoint:currentPoint];
        [UIView animateWithDuration:0.2 animations:^{

            closeArea.transform = CGAffineTransformMakeScale(0.1, 0.1);
            
        } completion:^(BOOL finished) {
            [closeArea removeFromSuperview];
            closeArea = nil;
        }];
        
        [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            self.center = destinationPoint;
            
        } completion:nil];
        
    }

    
}


//判断属于哪一个象限
-(NSInteger)pointBelongsWhichPart:(CGPoint)point{
    
    if (point.x <= SCREENWIDTH/2) {
        if (point.y <= SCREENHEIGHT/2) {
            return 2;
        }else{
            return 3;
        }
    }else{
        if (point.y <= SCREENHEIGHT/2) {
            return 1;
        }else{
            return 4;
        }
    }

}


//通过起始坐标判断终点坐标
-(CGPoint)destinationPoint:(CGPoint)initialPoint{
    CGPoint destinationPoint;
    destinationPoint.x = initialPoint.x >= SCREENWIDTH/2 ? SCREENWIDTH-RADIUS/2 : RADIUS/2;
    destinationPoint.y = initialPoint.y ;
    
    return destinationPoint;
}


//Point是否在CGRect内
-(BOOL)ifInsideWithPoint:(CGPoint)point withRect:(CGRect)rect{
    
    if ((point.x >= rect.origin.x && point.x <= rect.origin.x+rect.size.width) && (point.y >= rect.origin.y && point.y <= rect.origin.y + rect.size.height)) {
        return YES;
    }else{
        return NO;
    }
    
}


@end
