//
//  DDTabBarViewController.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/7.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDTabBarViewController.h"
#import "Weibo-Prefix.pch"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "DiscoverViewController.h"
#import "MeTableViewController.h"
#import "DDNavigationController.h"
#import "UIView+Extension.h"
#import "DDTabbar.h"
#import "DDComposeViewController.h"

@interface DDTabBarViewController () <DDTabBarDelegate>

@end

@implementation DDTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加子控制器
    HomeViewController *home = [[HomeViewController alloc]init];
    [self addOneChildVc:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    MessageViewController *message = [[MessageViewController alloc]init];
    [self addOneChildVc:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    DiscoverViewController *discover = [[DiscoverViewController alloc]init];
    [self addChildViewController:discover];
    [self addOneChildVc:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    MeTableViewController *me = [[MeTableViewController alloc]init];
    [self addOneChildVc:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    
    // 2.添加tabbar
    [self setValue:[[DDTabbar alloc] init] forKeyPath:@"tabBar"];
    [self.tabBar setTintColor:[UIColor orangeColor]];

}


- (void) addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *) selectedImageName
{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    if (iOS7)
    {
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVc.tabBarItem.selectedImage = selectedImage;
    
    DDNavigationController *nav = [[DDNavigationController alloc]initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarDidClickMidButton:(DDTabbar *)tabBar
{
    DDComposeViewController *compose = [[DDComposeViewController alloc] init];
    DDNavigationController *nav = [[DDNavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}



@end
