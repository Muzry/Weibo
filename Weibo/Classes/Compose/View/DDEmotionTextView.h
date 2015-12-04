//
//  DDEmotionTextView.h
//  蛋蛋微博
//
//  Created by LiDan on 15/9/6.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDTextView.h"

@class DDEmotion;

@interface DDEmotionTextView : DDTextView

-(void)insertEmotion:(DDEmotion *)emotion;
-(NSString *)fullText;

@end
