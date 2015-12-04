//
//  DDTextPart.h
//  蛋蛋微博
//
//  Created by LiDan on 15/12/4.
//  Copyright © 2015年 LiDan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDTextPart : NSObject

/** 选取文字 */
@property (nonatomic,copy) NSString *text;

/** 选取范围 */
@property (nonatomic,assign) NSRange range;

/** 是否为特殊文字 */
@property (nonatomic,assign,getter=isSpecial) BOOL special;

/** 是否为表情 */
@property (nonatomic,assign,getter=isEmotion) BOOL emotion;

/** 是否为连接 */
@property (nonatomic,assign,getter=isURL) BOOL url;

@end
