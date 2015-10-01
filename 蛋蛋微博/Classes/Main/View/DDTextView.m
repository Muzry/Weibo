//
//  DDTextView.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/30.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDTextView.h"
#import "Weibo-Prefix.pch"

@implementation DDTextView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 通知
        [DDNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}



-(void)textDidChange
{
    [self setNeedsDisplay];
}

-(void)dealloc
{
    [DDNotificationCenter removeObserver:self];
}

- (void)drawRect:(CGRect)rect
{
    if(self.hasText)
    {
        return ;
    }
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor ? self.placeholderColor : [UIColor grayColor];

    
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat h = rect.size.height - 2 * y;
    
    
    CGRect placeholderRect = CGRectMake(x , y , w , h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}

//set方法的重写 完善自定义控件
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

@end
