//
//  DDStatusFrame.h
//  蛋蛋微博
//
//  Created by LiDan on 15/8/23.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//  一个DDSttusFrame模型里面包含的信息
//  1.存放一个cell内部所有子空间的frame数据
//  2.存放一个cell的高度
//  3.存放着一个数据模型DDStatus

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define cellNameFont [UIFont systemFontOfSize:15]
//时间字体
#define cellTimeFont [UIFont systemFontOfSize:13]
//来源字体
#define cellSourceFont [UIFont systemFontOfSize:13]

#define cellMarginW 6
#define cellBorderW 8


@class Statuses;

@interface DDStatusFrame : NSObject
@property (nonatomic,copy) Statuses * status;

/** 原创微博整体*/
@property(nonatomic,assign) CGRect originalViewF;
/** 头像*/
@property(nonatomic,assign) CGRect iconViewF;
/** 配图*/
@property(nonatomic,assign) CGRect photosViewF;
/** 会员图标*/
@property(nonatomic,assign) CGRect vipViewF;
/** 昵称*/
@property(nonatomic,assign) CGRect namelabelF;
/** 时间*/
@property(nonatomic,assign) CGRect timelabelF;
/** 来源*/
@property(nonatomic,assign) CGRect sourcelabelF;
/** 正文*/
@property(nonatomic,assign) CGRect contentlabelF;
/** cell的高度*/
@property(nonatomic,assign) CGFloat cellHeight;

/*转发*/
/** 转发整体*/
@property(nonatomic,assign) CGRect retweetViewF;
/** 转发正文*/
@property(nonatomic,assign) CGRect retweetContentLabelF;
/** 转发配图*/
@property(nonatomic,assign) CGRect retweetphotosViewF;

/** 底部工具条*/
@property (nonatomic,assign) CGRect toolbarF;

@end
