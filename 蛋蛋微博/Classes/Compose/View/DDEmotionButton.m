//
//  DDEmotionButton.m
//  蛋蛋微博
//
//  Created by LiDan on 15/9/6.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDEmotionButton.h"
#import "DDEmotion.h"
#import "NSString+Emoji.h"

@implementation DDEmotionButton

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setup];
    }
    return self;
}

-(void)setup
{
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    self.adjustsImageWhenHighlighted = NO;
}

-(void)setEmotion:(DDEmotion *)emotion
{
    _emotion = emotion;
    if (emotion.png)
    {
        UIImage *image = [UIImage imageNamed:emotion.png];
        [self setImage:image forState:UIControlStateNormal];
    }
    else
    {
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
    }
}

@end
