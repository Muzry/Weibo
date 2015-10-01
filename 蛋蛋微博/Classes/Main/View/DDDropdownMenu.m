//
//  DDDropdownMenu.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/13.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDDropdownMenu.h"
#import "UIView+Extension.h"

@interface DDDropdownMenu()
@property(nonatomic,weak) UIImageView *containerView;//懒加载只能用强指针
@end

@implementation DDDropdownMenu


-(UIImageView *) containerView
{
    if (!_containerView)
    {
        // 添加一个灰色图片控件
        
        UIImageView *containerView = [[UIImageView alloc]init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)menu
{
    return [[self alloc]init];
}

- (void)setContent:(UIView *)content
{
    _content = content;
    content.x = 10;
    content.y = 15;
    
    self.containerView.height = CGRectGetMaxY(content.frame)+ 12;
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    
    [self.containerView addSubview:content];
}

-(void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    self.content = contentController.view;
}

/**
 *  显示下拉窗口
 */

- (void)showFrom:(UIView *)from
{
    // 1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    // 2.添加自己到窗口上
    
    [window addSubview:self];
    
    // 3.设置尺寸
    self.frame = window.bounds;
    
    // 4.调整自己的位置
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);

    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)])
    {
        [self.delegate dropdownMenuDidShow:self];
    };
}


/**
 *  销毁下拉窗口
 */
-(void)dismiss
{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)])
    {
        [self.delegate dropdownMenuDidDismiss:self];
    };
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}


@end
