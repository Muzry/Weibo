//
//  DDEmotionTabBar.m
//  蛋蛋微博
//
//  Created by LiDan on 15/9/1.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDEmotionTabBar.h"
#import "UIView+Extension.h"
#import "DDEmotionTabBarButton.h"

@interface DDEmotionTabBar()
@property (nonatomic ,weak) DDEmotionTabBarButton *selectedBtn;

@end

@implementation DDEmotionTabBar

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupBtn:@"最近" buttonType:DDEmotionTabBarButtonYpeRecent];
        [self setupBtn:@"默认" buttonType:DDEmotionTabBarButtonTypeDefault];
        [self setupBtn:@"Emoji" buttonType:DDEmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:DDEmotionTabBarButtonTypeLXH];
    }
    return self;
}


-(DDEmotionTabBarButton *)setupBtn:(NSString *)title buttonType:(DDEmotionTabBarButtonType)buttonType
{
    DDEmotionTabBarButton *btn = [[DDEmotionTabBarButton alloc]init];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    // 默认的图片名
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    
    [self addSubview:btn];
    
    // 显示键盘图标
    if (self.subviews.count == 1)
    {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    }
    else if(self.subviews.count == 4)
    {
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }
    btn.tag = buttonType;
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];

    return btn;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // 设置按钮的frame
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        DDEmotionTabBarButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = btnH;
    }
}

-(void) setDelegate:(id<DDEmotionTabBarDelegate>)delegate
{
    _delegate = delegate;
    
    [self btnClick:(DDEmotionTabBarButton *)[self viewWithTag:DDEmotionTabBarButtonTypeDefault]];
    
}

-(void)btnClick:(DDEmotionTabBarButton *)btn
{
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:btn.tag];
    }
}

@end
