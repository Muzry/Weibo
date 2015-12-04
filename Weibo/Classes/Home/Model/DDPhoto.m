//
//  DDPhoto.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/25.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDPhoto.h"

@implementation DDPhoto
+(instancetype) photoWithDict:(NSDictionary *)dict
{
    DDPhoto *photo = [[DDPhoto alloc]init];
    photo.thumbnail_pic = dict[@"thumbnail_pic"];
    return photo;
}
@end
