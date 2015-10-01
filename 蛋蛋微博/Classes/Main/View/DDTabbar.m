//
//  DDTabbar.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/13.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDTabbar.h"
#import "UIView+Extension.h"

@interface DDTabbar()
@property (nonatomic,weak) UIButton *midBtn;

@end

@implementation DDTabbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIButton *midBtn = [[UIButton alloc]init];
        [midBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [midBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [midBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [midBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        midBtn.size = midBtn.currentBackgroundImage.size;
        [midBtn addTarget:self action:@selector(midBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:midBtn];
        self.midBtn = midBtn;
    }
    return self;
}

-(void)midBtnClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickMidButton:)])
    {
        [self.delegate tabBarDidClickMidButton:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.midBtn.centerX = self.width * 0.5;
    self.midBtn.centerY = self.height * 0.5;
    CGFloat tabbarButtonW = self.width / 5;
    CGFloat tabbarButtonIndex = 0;
    
    
    NSUInteger count = self.subviews.count;
    for (int i = 0; i < count; i ++) {
        UIView *child = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = tabbarButtonW;
            child.x = tabbarButtonIndex * tabbarButtonW;
            tabbarButtonIndex++;
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex ++;
            }
        }
    }
}

@end
