//
//  DDEmotionPopView.h
//  蛋蛋微博
//
//  Created by LiDan on 15/9/6.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDEmotion,DDEmotionButton;

@interface DDEmotionPopView : UIView
+(instancetype)popView;

-(void)showFrom:(DDEmotionButton *)button;

@end
