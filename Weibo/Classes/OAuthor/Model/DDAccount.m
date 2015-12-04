//
//  DDAccount.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/17.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDAccount.h"
#import "MJExtension.h"

@implementation DDAccount

+ (instancetype)accountWithDic:(NSDictionary *)dict
{
    DDAccount * account = [[self alloc]init];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    account.created_Time = [NSDate date];
    
    return account;
}



- (void)encodeWithCoder:(NSCoder *)enCoder
{
    [enCoder encodeObject:self.access_token forKey:@"access_token"];
    [enCoder encodeObject:self.expires_in   forKey:@"expires_in"];
    [enCoder encodeObject:self.uid forKey:@"uid"];
    [enCoder encodeObject:self.created_Time forKey:@"created_Time"];
    [enCoder encodeObject:self.name forKey:@"name"];
}


 // 从沙盒中解析一个对象时，调用这个方法
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.created_Time = [decoder decodeObjectForKey:@"created_Time"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
