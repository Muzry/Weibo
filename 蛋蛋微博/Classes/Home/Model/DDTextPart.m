//
//  DDTextPart.m
//  蛋蛋微博
//
//  Created by LiDan on 15/12/4.
//  Copyright © 2015年 LiDan. All rights reserved.
//  文字分割

#import "DDTextPart.h"

@implementation DDTextPart

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@",self.text,NSStringFromRange(self.range)];
}

@end
