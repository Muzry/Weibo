//
//  DDEmotionKeyBoard.m
//  蛋蛋微博
//
//  Created by LiDan on 15/9/1.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDEmotionKeyBoard.h"
#import "DDEmotionTabBar.h"
#import "DDEmotionListView.h"
#import "UIView+Extension.h"
#import "DDEmotion.h"
#import "DDEmotionTool.h"
#import "Weibo-Prefix.pch"

@interface DDEmotionKeyBoard() <DDEmotionTabBarDelegate>

@property (nonatomic, weak) UIView *showingListView;
@property (nonatomic, strong) DDEmotionListView *lxhListView;
@property (nonatomic, strong) DDEmotionListView *emojiListView;
@property (nonatomic, strong) DDEmotionListView *recentListView;
@property (nonatomic, strong) DDEmotionListView *defaultListView;

@property (nonatomic,weak) DDEmotionTabBar *tabBar;

@end

@implementation DDEmotionKeyBoard


-(DDEmotionListView *)recentListView
{
    if(!_recentListView)
    {
        self.recentListView = [[DDEmotionListView alloc]init];
        //加载沙盒中的数据
        self.recentListView.emotions = [DDEmotionTool recentEmotions];
    }
    return _recentListView;
}

-(DDEmotionListView *)defaultListView
{
    if (!_defaultListView)
    {
        self.defaultListView = [[DDEmotionListView alloc]init];
        self.defaultListView.emotions = [DDEmotionTool defaultEmotions];
    }
    return _defaultListView;
}

-(DDEmotionListView *)emojiListView
{
    if (!_emojiListView)
    {
        self.emojiListView = [[DDEmotionListView alloc]init];
        self.emojiListView.emotions = [DDEmotionTool emojiEmotions];
    }
    return _emojiListView;
}

-(DDEmotionListView *)lxhListView
{
    if (!_lxhListView)
    {
        self.lxhListView = [[DDEmotionListView alloc]init];
        self.lxhListView.emotions = [DDEmotionTool lxhEmotions];
    }
    return _lxhListView;
}


-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        DDEmotionTabBar *tabBar = [[DDEmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        // 监听表情的选中
        [DDNotificationCenter addObserver:self selector:@selector(emotionDidSelect) name:DDEmotionDidSelect object:nil];
    }
    return self;
}

-(void)emotionDidSelect
{
    self.recentListView.emotions = [DDEmotionTool recentEmotions];
}

-(void)dealloc
{
    [DDNotificationCenter removeObserver:self];
}

-(void)emotionTabBar:(DDEmotionTabBar *)tabBar didSelectButton:(DDEmotionTabBarButtonType)buttonType
{
    [self.showingListView removeFromSuperview];
    switch (buttonType)
    {
        case DDEmotionTabBarButtonYpeRecent:
        {
            [self addSubview:self.recentListView];
            break;
        }
        case DDEmotionTabBarButtonTypeDefault:
        {
            [self addSubview:self.defaultListView];
            break;
        }
        case DDEmotionTabBarButtonTypeEmoji:
        {
            [self addSubview:self.emojiListView];
            break;
        }
        case DDEmotionTabBarButtonTypeLXH:
        {
            [self addSubview:self.lxhListView];
            break;
        }
        
    }
    self.showingListView = [self.subviews lastObject];
   
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    self.tabBar.y = self.height - self.tabBar.height;
    self.tabBar.x = 0;
    
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.y;

}

@end
