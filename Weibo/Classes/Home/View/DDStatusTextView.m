//
//  DDStatusTextView.m
//  Weibo
//
//  Created by LiDan on 15/12/5.
//  Copyright © 2015年 LiDan. All rights reserved.
//

#import "DDStatusTextView.h"
#import "Weibo-Prefix.pch"
#import "DDSpecialText.h"

#define DDStatusTextViewCoverTag 999

@implementation DDStatusTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.editable = NO;
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        self.scrollEnabled = NO;
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    
    BOOL contains = NO;
    for (DDSpecialText *special in specials)
    {
        self.selectedRange = special.range;
        
        // 获得选中范围的矩形框
        NSArray *rects = [self selectionRectsForRange:self.selectedTextRange];
        
        // 清空选中范围
        self.selectedRange = NSMakeRange(0, 0);
        
        for (UITextSelectionRect *selectionRect in rects)
        {
            CGRect rect = selectionRect.rect;
            if (rect.size.width == 0 || rect.size.height == 0)
            {
                continue;
            }
            if (CGRectContainsPoint(rect, point)) { // 点中了某个特殊字符串
                contains = YES;
                break;
            }
        }
            
        if (contains)
        {
            for (UITextSelectionRect *selectionRect in rects)
            {
                CGRect rect = selectionRect.rect;
                if (rect.size.width == 0 || rect.size.height == 0) continue;
                
                UIView *cover = [[UIView alloc] init];
                cover.backgroundColor = DDColor(190, 223, 254);
                cover.frame = rect;
                cover.tag = DDStatusTextViewCoverTag;
                cover.layer.cornerRadius = 5;
                [self insertSubview:cover atIndex:0];
            }
            
            break;
        }
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 去掉特殊字符串后面的高亮背景
    for (UIView *child in self.subviews)
    {
        if (child.tag == DDStatusTextViewCoverTag)
        {
            [child removeFromSuperview];
        }
    }
}

@end
