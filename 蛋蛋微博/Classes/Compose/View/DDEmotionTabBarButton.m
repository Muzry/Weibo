//
//  DDEmotionTabBarButton.m
//  蛋蛋微博
//
//  Created by LiDan on 15/9/3.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDEmotionTabBarButton.h"

@implementation DDEmotionTabBarButton
-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}
@end
