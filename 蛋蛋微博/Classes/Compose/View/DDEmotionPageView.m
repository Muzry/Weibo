//
//  DDEmotionPageView.m
//  蛋蛋微博
//
//  Created by LiDan on 15/9/5.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDEmotionPageView.h"
#import "UIView+Extension.h"
#import "Weibo-Prefix.pch"
#import "DDEmotion.h"
#import "NSString+Emoji.h"
#import "DDEmotionPopView.h"
#import "DDEmotionButton.h"

@interface DDEmotionPageView()

@property (nonatomic,strong) DDEmotionPopView * popView;
@property (nonatomic,weak) UIButton *deleButton;
@end

@implementation DDEmotionPageView

-(DDEmotionPopView *)popView
{
    if(!_popView)
    {
        self.popView = [DDEmotionPopView popView];
    }
    return _popView;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 删除按钮
        UIButton *deleteButton = [[UIButton alloc]init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [self addSubview:deleteButton];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        self.deleButton = deleteButton;
        
        // 添加长安手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
    }
    return self;
}


-(DDEmotionButton *)emotionButtonWithLocation:(CGPoint)location
{
    NSUInteger count = self.emotions.count;
    for (int i = 0; i < count; i++)
    {
        DDEmotionButton *btn = self.subviews[i];
        if (CGRectContainsPoint(btn.frame, location))
        {
            return btn;
        }
    }
    return nil;
}

-(void)longPressPageView:(UILongPressGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:recognizer.view];
    DDEmotionButton *btn = [self emotionButtonWithLocation:location];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            [self.popView removeFromSuperview];
            
            if (btn)
            {
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                userInfo[DDSelectemotionKey] = btn.emotion;
                
                [DDNotificationCenter postNotificationName:DDEmotionDidSelect object:nil userInfo:userInfo];
            }
            
            break;
            
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            [self.popView showFrom:btn];
            break;
        }
        default:
            break;
    }
}

-(void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (int i = 0; i < count; i ++)
    {
        DDEmotionButton *btn = [[DDEmotionButton alloc]init];
        [self addSubview:btn];
        btn.emotion = emotions[i];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)layoutSubviews
{
    [super subviews];
    CGFloat padding = 10;
    CGFloat btnW = (self.width - 2 * padding) / DDEmotionMaxCols;
    CGFloat btnH = (self.height - padding) / DDEmotionMaxRows;
    NSUInteger count = self.emotions.count;
    for (int i = 0; i < count; i ++)
    {
        UIButton *btn = self.subviews[i + 1];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = padding + (i % DDEmotionMaxCols) * btnW;
        btn.y = padding + (i / DDEmotionMaxCols) * btnH;
    }
    self.deleButton.width = btnW;
    self.deleButton.height = btnH;
    self.deleButton.y = self.height - btnH;
    self.deleButton.x = self.width - padding - btnW;
}

-(void)deleteClick
{
    [DDNotificationCenter postNotificationName:DDEmotionDidDeleteNotification object:nil userInfo:nil];
}

-(void)btnClick:(DDEmotionButton *)btn
{
    [self.popView showFrom:btn];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
        
    });
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[DDSelectemotionKey] = btn.emotion;
    
    [DDNotificationCenter postNotificationName:DDEmotionDidSelect object:nil userInfo:userInfo];
}

@end
