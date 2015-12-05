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

-(void)setSpecialsRects
{
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    
    for (DDSpecialText *special in specials)
    {
        self.selectedRange = special.range;
        
        // 获得选中范围的矩形框
        NSArray *selectionRects = [self selectionRectsForRange:self.selectedTextRange];
        
        // 清空选中范围
        self.selectedRange = NSMakeRange(0, 0);
        
        NSMutableArray *rects = [NSMutableArray array];
        
        for (UITextSelectionRect *selectionRect in selectionRects)
        {
            CGRect rect = selectionRect.rect;
            if (rect.size.width == 0 || rect.size.height == 0)
            {
                continue;
            }
            [rects addObject:[NSValue valueWithCGRect:rect]];
        }
        special.rects = rects;
    }

}

/**
 *  找出被触摸的特殊字符串
 */

-(DDSpecialText *)touchingSpecialWithPoint:(CGPoint)point
{
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    
    for (DDSpecialText *special in specials)
    {
        for (NSValue *rectValue in special.rects)
        {
            if (CGRectContainsPoint(rectValue.CGRectValue, point))
            {
                return special;
            }
        }
    }
    return nil;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    //触摸点
    CGPoint point = [touch locationInView:self];
    
    [self setSpecialsRects];
    
    // 根据触摸点获取被触摸的特殊字符串
    
    DDSpecialText *special = [self touchingSpecialWithPoint:point];
    
    for (NSValue *rectValue in special.rects)
    {
        CGRect rect = rectValue.CGRectValue;
        
        UIView *cover = [[UIView alloc] init];
        cover.backgroundColor = DDColor(190, 223, 254);
        cover.frame = rect;
        cover.tag = DDStatusTextViewCoverTag;
        cover.layer.cornerRadius = 5;
        [self insertSubview:cover atIndex:0];
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
