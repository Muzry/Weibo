//
//  DDEmotionTool.m
//  蛋蛋微博
//
//  Created by LiDan on 15/12/3.
//  Copyright © 2015年 LiDan. All rights reserved.
//

#import "DDEmotionTool.h"
#import "DDEmotion.h"


#define DDRecentEmotionPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"emotions.archive"]

@implementation DDEmotionTool

static NSMutableArray *_recentEmotions;

+(void)initialize
{
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:DDRecentEmotionPath];
    if (_recentEmotions == nil)
    {
        _recentEmotions = [NSMutableArray array];
    }
}

+(void)saveRecentEmotion:(DDEmotion *)emotion
{
    
    [_recentEmotions removeObject:emotion];
    
    [_recentEmotions insertObject:emotion atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:DDRecentEmotionPath];
}

+(NSArray *)recentEmotions
{
    return _recentEmotions;
}

@end
