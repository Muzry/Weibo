//
//  DDLoadMoreFooter.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/22.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDLoadMoreFooter.h"

@implementation DDLoadMoreFooter

+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DDLoadMoreFooter" owner:nil options:nil]lastObject];
}

@end
