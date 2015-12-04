//
//  NSDate+Extension.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/27.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *datecmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowcmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return datecmps.year == nowcmps.year;
}

-(BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    return [dateStr isEqualToString:nowStr];
}

-(BOOL)isYesterday
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    NSDate *date = [fmt dateFromString:dateStr];
    
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.day == 1 && cmps.month == 0 && cmps.year == 0;

}
@end
