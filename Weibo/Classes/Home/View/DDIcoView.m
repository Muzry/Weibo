//
//  DDIcoView.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/29.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDIcoView.h"
#import "UserInfo.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"

@interface DDIcoView()
@property (nonatomic,weak) UIImageView *verifiedView;
@end

@implementation DDIcoView

-(UIImageView *)verifiedView
{
    if (!_verifiedView)
    {
        UIImageView * verifiedView = [[UIImageView alloc]init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    return _verifiedView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

-(void)setUser:(UserInfo *)user
{
    _user = user;
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    switch (user.verified_type)
    {
        case userVerifiedTypePersonal:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case userVerifiedTypeOrgEnterprice:
        case userVerifiedTypeOrgMedia:
        case userVerifiedTypeOrgWebsite:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case userVerifiedTypeDaren:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
        default:
            self.verifiedView.hidden = YES;
            break;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.verifiedView.size = self.verifiedView.image.size;
    self.verifiedView.x = self.width - self.verifiedView.width * 0.7;
    self.verifiedView.y = self.height - self.verifiedView.height * 0.7;
}

@end
