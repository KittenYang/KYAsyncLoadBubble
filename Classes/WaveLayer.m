//
//  WaveLayer.m
//  KYAsyncLoadBubbleDemo
//
//  Created by Kitten Yang on 7/4/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "WaveLayer.h"


@interface WaveLayer()

@property(nonatomic,strong)CADisplayLink *displayLink;
@property(nonatomic,strong)UILabel *label;

@end

@implementation WaveLayer{
 
    CGFloat offsetX;
    CGFloat waterWaveHeight;
    CGFloat waterWaveWidth;


}

-(id)init{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
    
}


-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    waterWaveHeight = frame.size.height;
    waterWaveWidth  = frame.size.width;

}

-(void)setProgress:(CGFloat)progress{

    waterWaveHeight = progress * self.frame.size.height;
    if (progress == 0.0f) {
//        [self stop];
    }else{
        [self wave];
    }
}



-(void)setUp{
    
}


-(void)wave{
    
    if (self.displayLink == nil) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

-(void)stop{
    
    [self.displayLink invalidate];
    self.displayLink = nil;

}

-(void)getCurrentWave:(CADisplayLink *)displayLink{
    

    offsetX += self.waveSpeed;
    self.path = [self getgetCurrentWavePath];
        
}

-(CGPathRef)getgetCurrentWavePath{
    
    UIBezierPath *p = [UIBezierPath bezierPath];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, waterWaveHeight);
    CGFloat y = 0.0f;
    for (float x = 0.0f; x <=  waterWaveWidth ; x++) {
        y = self.waveAmplitude* sinf((360/waterWaveWidth) *(x * M_PI / 180) - offsetX * M_PI / 180) + waterWaveHeight;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    
    p.CGPath = path;
    
    return path;
}





@end
