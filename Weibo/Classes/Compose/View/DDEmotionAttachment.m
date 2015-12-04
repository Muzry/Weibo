//
//  DDEmotionAttachment.m
//  蛋蛋微博
//
//  Created by LiDan on 15/9/6.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDEmotionAttachment.h"
#import "DDEmotion.h"

@implementation DDEmotionAttachment
-(void)setEmotion:(DDEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
}
@end
