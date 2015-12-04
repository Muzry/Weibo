//
//  UITextView+Extension.h
//  蛋蛋微博
//
//  Created by LiDan on 15/9/6.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)
- (void)insertAttributeText:(NSAttributedString *)text;
- (void)insertAttributeText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString * attributedText)) settingBlock;
@end
