//
//  DDEmotionTool.m
//  蛋蛋微博
//
//  Created by LiDan on 15/12/3.
//  Copyright © 2015年 LiDan. All rights reserved.
//

#import "DDEmotionTool.h"


#define DDRecentEmotionPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"emotion.archive"]

@implementation DDEmotionTool

+(void)saveRecentEmotion:(DDEmotion *)emotion
{
    
    NSMutableArray *emotions = (NSMutableArray *)[self recentEmotions];
    if (emotions == nil)
    {
        emotions = [NSMutableArray array];
    }
    
    [emotions insertObject:emotion atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:emotion toFile:DDRecentEmotionPath];
}

+(NSArray *)recentEmotions
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:DDRecentEmotionPath];
}

@end
