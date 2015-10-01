//
//  DDAccount.h
//  蛋蛋微博
//
//  Created by LiDan on 15/8/17.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDAccount : NSObject <NSCoding>

/**string 用于调用access_token,接口获取授权后的access token*/
@property (nonatomic,copy) NSString * access_token;

/**string access token的生命周期*/
@property (nonatomic,copy) NSString * expires_in;

/**string 当前授权用户的UID*/
@property (nonatomic,copy) NSString * uid;

@property (nonatomic,strong) NSDate *created_Time;

@property (nonatomic,copy) NSString * name;

+ (instancetype)accountWithDic:(NSDictionary *)dict;

@end
