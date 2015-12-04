//
//  UITextView+Extension.m
//  蛋蛋微博
//
//  Created by LiDan on 15/9/6.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

-(void)insertAttributeText:(NSAttributedString *)text
{
    [self insertAttributeText:text settingBlock:nil];
}

- (void)insertAttributeText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributedText)) settingBlock;
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 拼接之前的文字（图片和普通文字）
    [attributedText appendAttributedString:self.attributedText];
    
    // 拼接图片
    NSUInteger loc = self.selectedRange.location;
    [attributedText replaceCharactersInRange:self.selectedRange withAttributedString:text];
    
    if (settingBlock)
    {
        settingBlock(attributedText);
    }
    
    [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
    self.attributedText = attributedText;
    
    // 移除光标到表情的后面
    self.selectedRange = NSMakeRange(loc + 1, 0);
}
@end
