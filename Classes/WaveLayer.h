//
//  WaveLayer.h
//  KYAsyncLoadBubbleDemo
//
//  Created by Kitten Yang on 7/4/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface WaveLayer : CAShapeLayer


/**
 *  The speed of wave 波浪的快慢
 */
@property (nonatomic,assign)CGFloat waveSpeed;

/**
 *  The amplitude of wave 波浪的震荡幅度
 */
@property (nonatomic,assign)CGFloat waveAmplitude;

/**
 *  The height of wave，between 0~1 波浪的高度(下载的进度) 0~1之间
 */
@property (nonatomic,assign)CGFloat progress;

/**
 *  Start waving
 */
-(void) wave;


/**
 *  Stop waving
 */
-(void) stop;

@end
