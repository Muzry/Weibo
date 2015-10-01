 //
//  AppDelegate.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/7.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "AppDelegate.h"
#import "DDOAuthViewController.h"
#import "DDAccount.h"
#import "DDAccountTool.h"
#import "UIWindow+Extension.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [application setStatusBarHidden:NO];
    
    // 1.创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    // 2.设置窗口的根控制器
    
    DDAccount *account = [DDAccountTool account];
    
    if (account)
    {
        [self.window switchRootViewController];
    }
    else
    {
        self.window.rootViewController = [[DDOAuthViewController alloc] init];
    }
    
    // 3.显示窗口(成为主窗口)
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:task];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    
    // 1.取消下载
    [mgr cancelAll];

    // 2.清除内存中得所有图片
    [mgr.imageCache clearMemory];
}

@end
