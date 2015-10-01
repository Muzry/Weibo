//
//  DDSearchBar.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/11.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDSearchBar.h"
#import "UIView+Extension.h"
#import "UIImage+Extension.h"

@implementation DDSearchBar

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

        self.background = [UIImage resizeImage:@"searchbar_textfield_background"];
        self.placeholder = @"请输入搜索条件";
        self.font = [UIFont systemFontOfSize:14];
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        UIImageView *leftView = [[UIImageView alloc]init];
        leftView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        leftView.frame = CGRectMake(0, 0, 40, self.size.height);
        leftView.contentMode = UIViewContentModeCenter;
        
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        //设置右边清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc] init];
}

@end
