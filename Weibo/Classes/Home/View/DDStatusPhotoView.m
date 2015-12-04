//
//  DDStatusPhotoView.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/28.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//  一张配图

#import "DDStatusPhotoView.h"
#import "DDPhoto.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"


@interface DDStatusPhotoView()
@property (nonatomic, weak) UIImageView *gifView;
@end

@implementation DDStatusPhotoView

- (UIImageView *)gifView
{
    if (!_gifView)
    {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 超出边框的内容都剪掉
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setPhoto:(DDPhoto *)photo
{
    _photo = photo;
    // 设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];

    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}


@end
