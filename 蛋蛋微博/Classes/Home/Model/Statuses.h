//
//  Statuses.h
//  蛋蛋微博
//
//  Created by LiDan on 15/8/21.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfo,Statuses;

@interface Statuses : NSObject
/** string 字符串型用户UID*/
@property (nonatomic,copy) NSString *idstr;

/** string 微博信息内容*/
@property (nonatomic,copy) NSString *text;

/** object 微博作者的用户信息字段*/
@property (nonatomic,strong) UserInfo* user;

/** string 微博创建时间*/
@property (nonatomic,copy) NSString *created_at;

/** string 微博来源*/
@property (nonatomic,copy) NSString *source;

/** 微博配图 多图返回连接 无图返回[]*/
@property (nonatomic,strong) NSArray *pic_urls;

/**  被转发的原微博信息字段 */
@property (nonatomic, strong) Statuses *retweeted_status;

/** int 转发数*/
@property (nonatomic, assign) int reposts_count;
/** int 转发数*/
@property (nonatomic, assign) int comments_count;
/** int 转发数*/
@property (nonatomic, assign) int attitudes_count;

+(instancetype) statusWithDict:(NSDictionary *)dict;

@end
