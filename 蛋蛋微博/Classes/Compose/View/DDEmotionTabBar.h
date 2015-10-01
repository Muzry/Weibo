//
//  DDEmotionTabBar.h
//  蛋蛋微博
//
//  Created by LiDan on 15/9/1.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDEmotionTabBar;

typedef enum
{
    DDEmotionTabBarButtonYpeRecent,
    DDEmotionTabBarButtonTypeDefault,
    DDEmotionTabBarButtonTypeEmoji,
    DDEmotionTabBarButtonTypeLXH
}DDEmotionTabBarButtonType;

@protocol DDEmotionTabBarDelegate <NSObject>

@optional
-(void)emotionTabBar:(DDEmotionTabBar *)tabBar didSelectButton:(DDEmotionTabBarButtonType)buttonType;
@end

@interface DDEmotionTabBar : UIView
@property (nonatomic,weak) id<DDEmotionTabBarDelegate> delegate;
@end
