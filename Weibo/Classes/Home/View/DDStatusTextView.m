//
//  DDStatusTextView.m
//  Weibo
//
//  Created by LiDan on 15/12/5.
//  Copyright © 2015年 LiDan. All rights reserved.
//

#import "DDStatusTextView.h"

@implementation DDStatusTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.textContainerInset = UIEdgeInsetsMake(0,-5 , 0, -5);
        self.editable = NO;
        self.scrollEnabled = NO;
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    // 找出触摸点在哪个特殊字符
    
    // 在被触摸的特殊字符串后面显示高亮背景
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 去掉特殊字符串后面的高亮背景
}

@end
