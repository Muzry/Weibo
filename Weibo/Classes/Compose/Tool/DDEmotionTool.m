//
//  DDEmotionTool.m
//  蛋蛋微博
//
//  Created by LiDan on 15/12/3.
//  Copyright © 2015年 LiDan. All rights reserved.
//

#import "DDEmotionTool.h"
#import "DDEmotion.h"
#import "MJExtension.h"


#define DDRecentEmotionPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"emotions.archive"]

@implementation DDEmotionTool

static NSMutableArray *_recentEmotions;
static NSArray *_emojisEmotions;
static NSArray *_defaultsEmotions;
static NSArray *_lxhsEmotions;


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

+(NSArray *)defaultEmotions
{
    if (!_defaultsEmotions)
    {
        NSString *path =[[NSBundle mainBundle] pathForResource:@"defaultinfo.plist" ofType:nil];
        _defaultsEmotions = [DDEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultsEmotions;
}

+(NSArray *)emojiEmotions
{
    if (!_emojisEmotions)
    {
        NSString *path =[[NSBundle mainBundle] pathForResource:@"emojiinfo.plist" ofType:nil];
        _emojisEmotions = [DDEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojisEmotions;
}

+(NSArray *)lxhEmotions
{
    if (!_lxhsEmotions)
    {
        NSString *path =[[NSBundle mainBundle] pathForResource:@"lxhinfo.plist" ofType:nil];
        _lxhsEmotions = [DDEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhsEmotions;
}

+(DDEmotion *)emotionWithChs:(NSString *)chs
{
    NSArray *defaults = [self defaultEmotions];
    for (DDEmotion * emotion in defaults)
    {
        if ([emotion.chs isEqualToString:chs])
        {
            return emotion;
        }
    }
    NSArray *lxhs = [self lxhEmotions];
    for (DDEmotion * emotion in lxhs)
    {
        if ([emotion.chs isEqualToString:chs])
        {
            return emotion;
        }
    }
    return nil;
}

@end
