//
//  DDEmotionTool.h
//  蛋蛋微博
//
//  Created by LiDan on 15/12/3.
//  Copyright © 2015年 LiDan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDEmotion;

@interface DDEmotionTool : NSObject


// 添加最近表情
+ (void)saveRecentEmotion:(DDEmotion *)emotion;

//获取最近表情
+ (NSArray *)recentEmotions;

//获取默认表情
+ (NSArray *)defaultEmotions;

//获取浪小花表情
+ (NSArray *)lxhEmotions;

//获取emoji表情
+ (NSArray *)emojiEmotions;

+ (DDEmotion *)emotionWithChs:(NSString*)chs;


@end
