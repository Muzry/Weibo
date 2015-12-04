//
//  DDAccountTool.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/18.
//  Copyright (c) 2015年 LiDan. All rights reserved.
// 处理账号相关的所有操作：存储账号、取出账号、验证账号

#import "DDAccountTool.h"
#import "DDAccount.h"
#define DDAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"account.archive"]

@implementation DDAccountTool



+ (void)saveAccount:(DDAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:DDAccountPath];
}

+ (DDAccount *)account
{
    // 加载模型
    DDAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:DDAccountPath];
    
    //过期秒数
    long long expires_in = [account.expires_in longLongValue];
    
    // 计算过期时间
    NSDate *expiresTime = [account.created_Time dateByAddingTimeInterval:expires_in];
    
    //获得当前时间
    NSDate *now = [NSDate date];
    
    NSComparisonResult result = [expiresTime compare:now];
    
    if (result != NSOrderedDescending)
    {
        return nil;
    }
    
    return account;
}


@end
