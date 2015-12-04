//
//  DDComposePhotosView.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/31.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDComposePhotosView.h"
#import "UIView+Extension.h"

@interface DDComposePhotosView()

@end

@implementation DDComposePhotosView


-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _photos = [NSMutableArray array];
    }
    
    return self;
}

-(void)addPhoto:(UIImage *)photo
{
    UIImageView *photoView = [[UIImageView alloc]init];
    photoView.image = photo;
    [self addSubview:photoView];
    [self.photos addObject:photo];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger photosCount = self.subviews.count;
    int maxCol = 3;
    CGFloat imageWH = 70;
    CGFloat imageMargin = 10;
    for (int i = 0; i<photosCount; i++) {
        UIImageView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.x = col * (imageWH+ imageMargin);
        
        int row = i / maxCol;
        photoView.y = row * (imageWH + imageMargin);
        photoView.width = imageWH;
        photoView.height = imageWH;
    }
}
@end
