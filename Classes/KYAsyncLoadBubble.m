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

@interface KYAsyncLoadBubble()

@property(nonatomic,weak)UIView *spView;

@end

@implementation KYAsyncLoadBubble


-(id)init{



    self = [super init];
    if (self){

        [self initialize];
        
    }
    return self;
    
}

#pragma mark -- PUBLIC METHOD
-(void)initialize{
    self.frame = CGRectMake(SCREENWIDTH-RADIUS, 100, RADIUS, RADIUS);
    self.backgroundColor = [UIColor redColor];
    self.layer.cornerRadius = RADIUS/2;

}


#pragma mark -- OVERRIDE METHOD
-(void)willMoveToSuperview:(UIView *)newSuperview{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragBubble:)];
    self.spView = newSuperview;
    [self addGestureRecognizer:pan];
    
}


#pragma mark -- PRIVATE METHOD

-(void)dragBubble:(UIPanGestureRecognizer *)panGes{
    
    CGPoint currentPoint = [panGes locationInView:self.spView];
    CGPoint destinationPoint;
    
    
    if (panGes.state == UIGestureRecognizerStateBegan) {
        
    }else if (panGes.state == UIGestureRecognizerStateChanged){

        self.center = currentPoint;
        
    }else if (panGes.state == UIGestureRecognizerStateEnded || panGes.state == UIGestureRecognizerStateCancelled){
        
        destinationPoint = [self destinationPoint:currentPoint];
        
        [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            self.center = destinationPoint;
            
        } completion:nil];
        
    }

    
}

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


-(CGPoint)destinationPoint:(CGPoint)initialPoint{
    CGPoint destinationPoint;
    destinationPoint.x = initialPoint.x >= SCREENWIDTH/2 ? SCREENWIDTH-RADIUS/2 : RADIUS/2;
    destinationPoint.y = initialPoint.y ;
    
    return destinationPoint;
}


@end
