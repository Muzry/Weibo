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

+ (void)saveRecentEmotion:(DDEmotion *)emotion;

+ (NSArray *)recentEmotions;

@end
