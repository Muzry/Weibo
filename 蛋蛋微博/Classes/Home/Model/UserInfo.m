//
//  UserInfo.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/21.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//  用户模型

#import "UserInfo.h"

@implementation UserInfo

+(instancetype) userWithDict:(NSDictionary *)dict
{
    UserInfo * user = [[UserInfo alloc]init];
    user.idstr = dict[@"idstr"];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    user.mbrank = [dict[@"mbrank"] intValue];
    user.mbtype = [dict[@"mbtype"] intValue];
    user.verified_type = [dict[@"verified_type"] intValue];
    return user;
}

-(void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    self.Vip = mbtype > 2;
}

@end
