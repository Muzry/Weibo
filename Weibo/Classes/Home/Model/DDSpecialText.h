//
//  DDSpecialText.h
//  Weibo
//
//  Created by LiDan on 15/12/5.
//  Copyright © 2015年 LiDan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDSpecialText : NSObject

/** 选取文字 */
@property (nonatomic,copy) NSString *text;

/** 选取范围 */
@property (nonatomic,assign) NSRange range;

@property (nonatomic,strong) NSArray *rects;

@end
