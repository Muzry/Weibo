//
//  DDDropdownMenu.h
//  蛋蛋微博
//
//  Created by LiDan on 15/8/13.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDDropdownMenu;

@protocol DDDropDownMenuDelegate <NSObject>

@optional
- (void) dropdownMenuDidDismiss:(DDDropdownMenu *)menu;
- (void) dropdownMenuDidShow:(DDDropdownMenu *)menu;
@end

@interface DDDropdownMenu : UIView

@property (nonatomic,weak) id<DDDropDownMenuDelegate> delegate;

+ (instancetype)menu;

/**
 *  显示下拉窗口
 */

- (void)showFrom:(UIView *)from;


/**
 *  销毁下拉窗口
 */
-(void)dismiss;

@property (nonatomic,strong) UIView *content;
@property (nonatomic,strong) UIViewController *contentController;
@end
