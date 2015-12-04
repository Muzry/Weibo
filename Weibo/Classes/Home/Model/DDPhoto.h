//
//  DDPhoto.h
//  蛋蛋微博
//
//  Created by LiDan on 15/8/25.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDPhoto : NSObject
/* 缩略图地址*/
@property (nonatomic,copy)NSString *thumbnail_pic;
+(instancetype) photoWithDict:(NSDictionary *)dict;
@end
