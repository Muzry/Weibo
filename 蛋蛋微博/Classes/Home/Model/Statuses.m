//
//  Statuses.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/21.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//  微博模型

#import "Statuses.h"
#import "UserInfo.h"
#import "DDPhoto.h"
#import "NSDate+Extension.h"

@implementation Statuses

-(NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];

    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    //                 Thu Aug 27 11:02:30 +0800 2015
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour|NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents * cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if ([createDate isThisYear])
    {
        if ([createDate isToday])
        {
            if (cmps.hour >= 1)
            {
                return [NSString stringWithFormat:@"%ld小时前",(long)cmps.hour];
            }
            else if (cmps.minute >= 1)
            {
                return [NSString stringWithFormat:@"%ld分钟前",(long)cmps.minute];
            }
            else
            {
                return @"刚刚";
            }
        }
        else if([createDate isYesterday])
        {
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        }
        else
        {
            fmt.dateFormat = @"MM-dd";
            return [fmt stringFromDate:createDate];
        }
    }
    else
    {
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }
}

-(void)setSource:(NSString *)source
{
    if (source.length)
    {
        _source = source;
        NSRange range;
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</"].location - range.location;
        _source = [NSString stringWithFormat:@"来自 %@",[source substringWithRange:range]];
    }
}

+(instancetype) statusWithDict:(NSDictionary *)dict
{
    Statuses * status = [[Statuses alloc]init];
    status.idstr = dict[@"idstr"];
    status.text  = dict[@"text"];
    status.user = [UserInfo userWithDict:dict[@"user"]];
    status.created_at = dict[@"created_at"];
    status.source = dict[@"source"];
    if (dict[@"retweeted_status"] != nil)
    {
        Statuses *retweeted_status = [Statuses statusWithDict:dict[@"retweeted_status"]];
        status.retweeted_status = retweeted_status;
    }
    else
    {
        status.retweeted_status = nil;
    }
    NSArray *pic_urls = dict[@"pic_urls"];
    if (pic_urls.count != 0)
    {
        NSMutableArray *tempPhoto = [NSMutableArray array];
        for (NSDictionary *dict in pic_urls)
        {
            DDPhoto *photo = [DDPhoto photoWithDict:dict];
            [tempPhoto addObject:photo];
        }
        status.pic_urls = tempPhoto;
    }
    else
    {
        status.pic_urls = nil;
    }
    status.reposts_count = [dict[@"reposts_count"] intValue];
    status.comments_count = [dict[@"comments_count"] intValue];
    status.attitudes_count = [dict[@"attitudes_count"] intValue];
    
    return status;
}
@end
