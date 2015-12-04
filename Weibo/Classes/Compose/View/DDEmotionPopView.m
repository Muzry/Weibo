//
//  DDEmotionPopView.m
//  蛋蛋微博
//
//  Created by LiDan on 15/9/6.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDEmotionPopView.h"
#import "DDEmotion.h"
#import "DDEmotionButton.h"
#import "UIView+Extension.h"

@interface DDEmotionPopView()
@property (weak, nonatomic) IBOutlet DDEmotionButton *emotionButton;

@end

@implementation DDEmotionPopView


-(void)showFrom:(DDEmotionButton *)button
{
    
    if (button == nil)
    {
        return;
    }
    
    self.emotionButton.emotion = button.emotion;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    self.y = CGRectGetMaxY(btnFrame) - self.height * 1.1;
    self.centerX = CGRectGetMidX(btnFrame);
}

+(instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DDEmotionPopView" owner:nil options:nil] lastObject];
}

@end
