//
//  DDStatusPhotosView.h
//  蛋蛋微博
//
//  Created by LiDan on 15/8/28.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//  cell的配图相册

#import <UIKit/UIKit.h>

@interface DDStatusPhotosView : UIView

@property (nonatomic,copy) NSArray *photos;
+ (CGSize)SizeWithCount:(NSUInteger)count;
@end
