//
//  DDStatusToolBar.h
//  蛋蛋微博
//
//  Created by LiDan on 15/8/26.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Statuses;
@interface DDStatusToolBar : UIView
+ (instancetype)toolBar;
@property (nonatomic, strong) Statuses *status;

@end
