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
#import "WaveLayer.h"
#import "MultiplePulsingHaloLayer.h"
#import "MCFireworksView.h"
#import "AFHTTPRequestOperation.h"

@interface KYAsyncLoadBubble()

@property(nonatomic,weak)UIView *spView;
@property(copy,nonatomic)NSString *webContent;

@end

@implementation KYAsyncLoadBubble{
    
    UIView *closeArea;
    MultiplePulsingHaloLayer *pulseLayer;
    MCFireworksView *fireworkView;
    WaveLayer *waveLayer;
    UILabel *bubbleLabel;
    AFHTTPRequestOperation *operation;
}


-(id)init{

    self = [super init];
    if (self){
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.5f;
        self.layer.shadowRadius = 3.0f;
        self.layer.shadowOffset = CGSizeMake(0, -4);
    }
    return self;
    
}


#pragma mark -- PUBLIC METHOD
-(void)setProgress:(CGFloat)progress{
    
//    NSLog(@"progress:%f",progress);
    waveLayer.progress = 1.0 - progress;
    bubbleLabel.center = CGPointMake(RADIUS/2,RADIUS/4 + progress * (RADIUS/4));
    if (progress >= 0.73f && progress != 1.0f) {
        
        bubbleLabel.text = @"即将完成";
        bubbleLabel.font = [UIFont systemFontOfSize:10.0f];
        bubbleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        bubbleLabel.textColor = [UIColor whiteColor];
        [self bringSubviewToFront:bubbleLabel];
        
    }else if (progress == 1.0f){
        
        bubbleLabel.text = @"完成";
        bubbleLabel.font = [UIFont systemFontOfSize:13.0f];
        bubbleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        bubbleLabel.textColor = [UIColor whiteColor];
        [self bringSubviewToFront:bubbleLabel];
        
    }else{

        bubbleLabel.text = self.bubbleText;
        bubbleLabel.font = [UIFont systemFontOfSize:13.0f];
        bubbleLabel.textColor = self.bubbleColor;

    }
    
}

#pragma mark -- OVERRIDE METHOD
-(void)willMoveToSuperview:(UIView *)newSuperview{
    
    self.spView = newSuperview;
    
    //self
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = RADIUS/2;
    self.layer.masksToBounds = YES;
    self.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT + RADIUS);
    self.bounds = CGRectMake(0, 0, RADIUS, RADIUS);

    //label
    if (bubbleLabel == nil) {
        bubbleLabel= [[UILabel alloc]init];
        bubbleLabel.bounds = CGRectMake(0, 0, RADIUS, RADIUS/2);
        bubbleLabel.center = CGPointMake(RADIUS/2, RADIUS/4);
        
        bubbleLabel.text = self.bubbleText;
        bubbleLabel.textAlignment = NSTextAlignmentCenter;
        bubbleLabel.font = [UIFont systemFontOfSize:13.0f];
        bubbleLabel.textColor = self.bubbleColor;
        [self addSubview:bubbleLabel];
    }

    //start wave
    if (waveLayer == nil) {
        waveLayer = [WaveLayer layer];
        waveLayer.frame = self.bounds;
        waveLayer.waveSpeed = 10.0f;
        waveLayer.waveAmplitude = 1.0f;
        waveLayer.fillColor = self.bubbleColor.CGColor;
        [waveLayer wave];
        [self.layer addSublayer:waveLayer];
    }

    //jump from bottom
    [UIView animateWithDuration:0.6 delay:1.0 usingSpringWithDamping:0.6f initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        self.frame = CGRectMake(SCREENWIDTH-RADIUS, 100, RADIUS, RADIUS);
        
    } completion:^(BOOL finished) {
        
        //异步请求网页内容
        NSURLRequest  *request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.webUrl]];
        
        operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
        __weak __typeof__(self) weakSelf = self;
        
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead)
         {
             NSLog(@"下载中...");
             float progress = (float)bytesRead / totalBytesRead;
             weakSelf.progress = progress;
         }];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSString *content=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             weakSelf.webContent=content;
             weakSelf.progress = 1.0;
             NSLog(@"下载成功");
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSLog(@"下载失败");
         }];
        [operation start];
        
    }];
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragBubble:)];
    [self addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBubble:)];
    [self addGestureRecognizer:tap];
    
}


#pragma mark -- PRIVATE METHOD

-(void)tapBubble:(UITapGestureRecognizer *)tapGes{
    
    if ([self.delegate respondsToSelector:@selector(bubbleDidTapped:)]) {

        [self.delegate bubbleDidTapped:_webContent];
    }
    
}

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
        
        
        if (CGRectContainsPoint(closeArea.frame,currentPoint)) {
            fireworkView = [[MCFireworksView alloc]initWithFrame:closeArea.frame];
            fireworkView.particleImage = [self getCurrentCGImageRefOfView:closeArea];
            fireworkView.particleScale = 0.04;
            fireworkView.particleScaleRange = 0.01;
            [self.spView addSubview:fireworkView];
            [fireworkView animate];
            
            [self removeFromSuperview];
            [waveLayer stop];
            
        }else{
            
            [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
                
                self.center = destinationPoint;
                
            } completion:nil];
        
        }
    
        [UIView animateWithDuration:0.2 animations:^{
            
            closeArea.transform = CGAffineTransformMakeScale(0.1, 0.1);
            
        } completion:^(BOOL finished) {
            [closeArea removeFromSuperview];
            closeArea = nil;
        }];
        
    }
    
}


-(void)dealloc{
    closeArea = nil;
    pulseLayer = nil;
    waveLayer = nil;
    bubbleLabel = nil;
    fireworkView = nil;
}


#pragma mark -- Helper Method

-(UIImage *)getCurrentCGImageRefOfView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, view.contentScaleFactor);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Convert UIImage to CGImage
//    CGImageRef cgImage = image.CGImage;
    return image;
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
