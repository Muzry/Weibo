//
//  DDComposeToolbar.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/31.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDComposeToolbar.h"
#import "UIView+Extension.h"
@interface DDComposeToolbar()

@property (nonatomic,weak) UIButton *emotionButton;

@end

@implementation DDComposeToolbar

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        [self setupBtn:@"compose_camerabutton_background" hightImage:@"compose_camerabutton_background_highlighted" tag:DDComposeToolbarButtonTypeCamera];
        [self setupBtn:@"compose_toolbar_picture" hightImage:@"compose_toolbar_picture_highlighted" tag:DDComposeToolbarButtonTypeAlbum];
        [self setupBtn:@"compose_mentionbutton_background" hightImage:@"compose_mentionbutton_background_highlighted" tag:DDComposeToolbarButtonTypeMention];
        [self setupBtn:@"compose_trendbutton_background" hightImage:@"compose_trendbutton_background_highlighted" tag:DDComposeToolbarButtonTypeTrend];
        self.emotionButton =  [self setupBtn:@"compose_emoticonbutton_background" hightImage:@"compose_emoticonbutton_background_highlighted" tag:DDComposeToolbarButtonTypeEmotion];
    }
    
    return self;
}


- (void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)])
    {
        [self.delegate composeToolbar:self didClickButton:btn.tag];
    }
}

-(void)setShowKeyBoardButton:(BOOL)showKeyBoardButton
{
    _showKeyBoardButton = showKeyBoardButton;
    
    // 默认的图片名
    NSString *image = @"compose_emoticonbutton_background";
    NSString *highImage = @"compose_emoticonbutton_background_highlighted";
    
    // 显示键盘图标
    if (showKeyBoardButton) {
        image = @"compose_keyboardbutton_background";
        highImage = @"compose_keyboardbutton_background_highlighted";
    }
    
    // 设置图片
    [self.emotionButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.emotionButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
}

-(UIButton *)setupBtn:(NSString *)image hightImage:(NSString *)hightImage tag:(DDComposeToolbarButtonType)type
{
    UIButton * btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed: image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed: hightImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    btn.tag = type;
    return btn;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    
    for (NSUInteger i = 0;  i < count; i ++)
    {
        UIButton *btn = self.subviews[i];
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }
}

@end
