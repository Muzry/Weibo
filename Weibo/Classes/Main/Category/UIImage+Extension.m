//
//  UIImage+Extension.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/10.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)resizeImage: (NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
@end
