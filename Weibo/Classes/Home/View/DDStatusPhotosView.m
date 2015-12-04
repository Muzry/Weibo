//
//  DDStatusPhotosView.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/28.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//  

#import "DDStatusPhotosView.h"
#import "DDPhoto.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#import "DDStatusPhotoView.h"

#define DDStatusPhotoWH(count) ((count < 4) ? 90 : 70)
#define DDStatusPhotoMargin 8
#define DDStatusPhotoMaxCol(count) ((count == 4) ? 2 : 3)

@implementation DDStatusPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

+ (CGSize)SizeWithCount:(NSUInteger)count
{
    // 最大列数（一行最多有多少列）
    NSUInteger maxCols = DDStatusPhotoMaxCol(count);
    
    NSUInteger cols = (count >= maxCols)? maxCols : count;
    CGFloat photosW = cols * DDStatusPhotoWH(count) + (cols - 1) * DDStatusPhotoMargin;
    
    // 行数
    NSUInteger rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * DDStatusPhotoWH(count) + (rows - 1) * DDStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    NSUInteger photosCount = photos.count;

    while (self.subviews.count < photosCount)
    {
        DDStatusPhotoView *photoView = [[DDStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    for (int i = 0; i<self.subviews.count; i++)
    {
        DDStatusPhotoView *photoView = self.subviews[i];
        
        if (i < photosCount)
        {
            photoView.photo = photos[i];
            photoView.hidden = NO;
        }
        else
        {
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置图片的尺寸和位置
    NSUInteger photosCount = self.photos.count;
    int maxCol = DDStatusPhotoMaxCol(photosCount);
    for (int i = 0; i<photosCount; i++) {
        DDStatusPhotoView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.x = col * (DDStatusPhotoWH(photosCount) + DDStatusPhotoMargin);
        
        int row = i / maxCol;
        photoView.y = row * (DDStatusPhotoWH(photosCount) + DDStatusPhotoMargin);
        photoView.width = DDStatusPhotoWH(photosCount);
        photoView.height = DDStatusPhotoWH(photosCount);
    }
}


@end