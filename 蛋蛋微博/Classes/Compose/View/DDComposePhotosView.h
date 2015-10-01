//
//  DDComposePhotosView.h
//  蛋蛋微博
//
//  Created by LiDan on 15/8/31.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDComposePhotosView : UIView
-(void)addPhoto:(UIImage *)photo;
@property (nonatomic, strong, readonly) NSMutableArray *photos;

@end
