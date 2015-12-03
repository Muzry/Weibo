//
//  DDEmotionListView.m
//  蛋蛋微博
//
//  Created by LiDan on 15/9/1.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDEmotionListView.h"
#import "UIView+Extension.h"
#import "DDEmotionPageView.h"
#import "Weibo-Prefix.pch"



@interface DDEmotionListView() <UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView *scrollerView;
@property (nonatomic,weak) UIPageControl *pageControl;

@end

@implementation DDEmotionListView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.pagingEnabled = YES;
        [self addSubview:scrollView];
        self.scrollerView = scrollView;
        self.scrollerView.showsHorizontalScrollIndicator = NO;
        self.scrollerView.showsVerticalScrollIndicator = NO;
        self.scrollerView.delegate = self;
        
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        
        pageControl.userInteractionEnabled = NO;
        
        //只有一页时自动隐藏
        pageControl.hidesForSinglePage = YES;
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"currentPageImage"];
        
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    NSUInteger count = (emotions.count + DDEmotionPageSize -1) / DDEmotionPageSize;
    //设置页数
    
    self.pageControl.numberOfPages = count;
    for (int i = 0;i < self.pageControl.numberOfPages; i++)
    {
        DDEmotionPageView *pageView = [[DDEmotionPageView alloc] init];
        
        NSRange range;
        range.location = i * DDEmotionPageSize;
        NSUInteger count = emotions.count - range.location;
        range.length = count > DDEmotionPageSize ? DDEmotionPageSize : count;
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollerView addSubview:pageView];
    }


}

-(void)layoutSubviews
{
    [super subviews];
    
    self.pageControl.width = self.width;
    self.pageControl.height = 25;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    self.scrollerView.width = self.width;
    self.scrollerView.height = self.pageControl.y;
    self.scrollerView.x = self.scrollerView.y = 0;
    

    NSUInteger count = self.scrollerView.subviews.count;
    for (int i = 0; i < count; i ++) {
        DDEmotionPageView * pageView = self.scrollerView.subviews[i];
        pageView.height = self.scrollerView.height;
        pageView.width = [UIScreen mainScreen].bounds.size.width;
        pageView.x = pageView.width * i;
        pageView.y = 0;
    }
    
    self.scrollerView.contentSize = CGSizeMake(count * self.scrollerView.width, 0);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double Page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(Page + 0.5);
}

@end
