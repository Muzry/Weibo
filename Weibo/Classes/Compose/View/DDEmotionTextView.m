//
//  DDEmotionTextView.m
//  蛋蛋微博
//
//  Created by LiDan on 15/9/6.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDEmotionTextView.h"
#import "DDEmotion.h"
#import "NSString+Emoji.h"
#import "UITextView+Extension.h"
#import "DDEmotionAttachment.h"
#import "Weibo-Prefix.pch"

@implementation DDEmotionTextView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

-(void)insertEmotion:(DDEmotion *)emotion
{
    if (emotion.code)
    {
        [self insertText:emotion.code.emoji];
    }
    else if (emotion.png)
    {
        // 加载图片
        DDEmotionAttachment *attch = [[DDEmotionAttachment alloc] init];
        attch.emotion = emotion;
        
        CGFloat attchWH = self.font.lineHeight;
        attch.bounds = CGRectMake(0, -4, attchWH, attchWH);
        
        // 根据附件创建一个属性文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
        
        // 插入属性文字到光标位置

        [self insertAttributeText:imageStr settingBlock:^(NSMutableAttributedString *attributedText) {
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
            
        }];
    }
    NSNotification *notification = [NSNotification notificationWithName:UITextViewTextDidChangeNotification object:self];
    [DDNotificationCenter postNotification:notification];
}

-(NSString *)fullText
{
    NSMutableString *fullText = [NSMutableString string];
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0,self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop)
    {
        DDEmotionAttachment *attch = attrs[@"NSAttachment"];
        
        if(attch)
        {
            [fullText appendString:attch.emotion.chs];
        }
        else
        {
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
        
    }];
    return fullText;
}

@end
