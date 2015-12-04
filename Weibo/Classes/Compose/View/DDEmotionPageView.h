//
//  DDEmotionPageView.h
//  蛋蛋微博
//
//  Created by LiDan on 15/9/5.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DDEmotionMaxCols 7
#define DDEmotionMaxRows 3
#define DDEmotionPageSize (DDEmotionMaxCols * DDEmotionMaxRows - 1 )

@interface DDEmotionPageView : UIView
@property (nonatomic,strong) NSArray *emotions;
@end
