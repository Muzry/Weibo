//
//  DDTabbar.h
//  蛋蛋微博
//
//  Created by LiDan on 15/8/13.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDTabbar;

@protocol DDTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickMidButton:(DDTabbar *)tabBar;

@end

@interface DDTabbar : UITabBar
@property (nonatomic,strong) id <DDTabBarDelegate> delegate;
@end
