//
//  DDNewfeatureViewController.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/14.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDNewfeatureViewController.h"
#import "DDTabBarViewController.h"
#import "UIView+Extension.h"

#define New_Feature_Count 4

@interface DDNewfeatureViewController ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIPageControl * pageControl;
@end

@implementation DDNewfeatureViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 创建一个scrollview：显示所有的新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    //传0代表这个方向上不能滚动
    [self.view addSubview:scrollView];
    
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    
    scrollView.contentSize = CGSizeMake(New_Feature_Count * scrollW, 0);
    
    for (int i = 0; i < New_Feature_Count; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i * scrollW;
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        // 如果是最后一个imageView，就往里面添加其他内容
        if (i == New_Feature_Count - 1)
        {
            [self setUpLastImageView:imageView];
        }
    } 
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    //4.展示第几页
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = New_Feature_Count;
    pageControl.width = 100;
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50;
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:253/255.0 green:98/255.0 blue:42/255.0 alpha:1];;
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
}

-(void)setUpLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    
    // 1. 分享给大家 (checkbox)
    UIButton * shareBtn = [[UIButton alloc]init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBtn setTitle:@"分享给大家"  forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    shareBtn.width = 200;
    shareBtn.height = 30; 
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.centerY = imageView.height * 0.7;
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
    
    UIButton *startBtn = [[UIButton alloc]init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height * 0.8;
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    
}

- (void)shareClick:(UIButton *)shareBtn
{
    shareBtn.selected = !shareBtn.isSelected;
}


- (void)startClick
{
    // 跳转首页
    /**
     *  1.push
        2.modal
        3.切换window的rootViewController
     *
     */
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[DDTabBarViewController alloc]init];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
