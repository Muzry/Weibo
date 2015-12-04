//
//  UIWindow+Extension.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/19.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "DDTabBarViewController.h"
#import "DDNewfeatureViewController.h"

@implementation UIWindow (Extension)

- (void)switchRootViewController
{
    NSString *key = @"CFBundleVersion";
    //存储在沙盒中得版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //获取当前版本
    NSString * currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    //将版本号存储至沙盒
    
    if([lastVersion isEqualToString: currentVersion])
    {
        DDTabBarViewController *tabBar = [[DDTabBarViewController alloc]init];
        self.rootViewController = tabBar;
    }
    else
    {
        self.rootViewController = [[DDNewfeatureViewController alloc]init];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
