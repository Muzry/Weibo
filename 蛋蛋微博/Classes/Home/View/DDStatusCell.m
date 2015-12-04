//
//  DDStatusCell.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/23.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDStatusCell.h"
#import "DDStatusFrame.h"
#import "Statuses.h"
#import "UserInfo.h"
#import "DDPhoto.h"
#import "UIImageView+WebCache.h"
#import "DDStatusToolBar.h"
#import "NSString+Extension.h"
#import "DDStatusPhotosView.h"
#import "DDIcoView.h"

@interface DDStatusCell()
/*原创微博*/
/** 原创微博整体*/
@property(nonatomic,weak) UIView *originalView;
/** 头像*/
@property(nonatomic,weak) DDIcoView *iconView;
/** 配图*/
@property(nonatomic,weak) DDStatusPhotosView *photosView;
/** 会员图标*/
@property(nonatomic,weak) UIImageView *vipView;
/** 昵称*/
@property(nonatomic,weak) UILabel *namelabel;
/** 时间*/
@property(nonatomic,weak) UILabel *timelabel;
/** 来源*/
@property(nonatomic,weak) UILabel *sourcelabel;
/** 正文*/
@property(nonatomic,weak) UILabel *contentlabel;

/*转发*/
/** 转发整体*/
@property(nonatomic,weak) UIView *retweetView;
/** 转发正文*/
@property(nonatomic,weak) UILabel *retweetContentLabel;
/** 转发配图*/
@property(nonatomic,weak) DDStatusPhotosView *retweetphotosView;

/** 工具条*/
@property (nonatomic,weak) DDStatusToolBar * toolbar;
@end

@implementation DDStatusCell
+(instancetype) cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    DDStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[DDStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.y += cellMarginW;
    [super setFrame:frame];
}

/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置。
 *
 */

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupOriginal];
        [self setupRetweet];
        [self setupToolbar];
        
    }
    return self;
}

-(void)setupOriginal
{
    /** 原创微博*/
    UIView *originalView = [[UIView alloc]init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    /** 头像*/
    DDIcoView *iconView = [[DDIcoView alloc]init];
    [self.originalView addSubview:iconView];
    self.iconView = iconView;
    
    /** 配图*/
    DDStatusPhotosView *photosView = [[DDStatusPhotosView alloc]init];
    [self.originalView addSubview:photosView];
    self.photosView = photosView;
    
    /** 会员图标*/
    UIImageView *vipView = [[UIImageView alloc]init];
    vipView.contentMode = UIViewContentModeCenter;
    [self.originalView addSubview:vipView];
    self.vipView = vipView;
    
    /** 昵称*/
    UILabel *namelabel = [[UILabel alloc]init];
    namelabel.font = cellNameFont;
    [self.originalView addSubview:namelabel];
    self.namelabel = namelabel;
    
    /** 时间*/
    UILabel *timelabel = [[UILabel alloc]init];
    [self.originalView addSubview:timelabel];
    timelabel.font = cellTimeFont;
    self.timelabel = timelabel;
    
    
    /** 来源*/
    UILabel *sourcelabel = [[UILabel alloc]init];
    sourcelabel.font = cellSourceFont;
    [self.originalView addSubview:sourcelabel];
    self.sourcelabel = sourcelabel;
    
    /** 正文*/
    UILabel *contentlabel= [[UILabel alloc]init];
    contentlabel.numberOfLines = 0;
    [self.originalView addSubview:contentlabel];
    self.contentlabel = contentlabel;
}

- (void)setupRetweet
{
    UIView *retweetView = [[UIView alloc]init];
    retweetView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 正文*/
    UILabel *retweetContentlabel= [[UILabel alloc]init];
    retweetContentlabel.numberOfLines = 0;
    [retweetView addSubview:retweetContentlabel];
    self.retweetContentLabel = retweetContentlabel;
    
    /** 配图*/
    DDStatusPhotosView *retweetphotosView = [[DDStatusPhotosView alloc]init];
    [retweetView addSubview:retweetphotosView];
    self.retweetphotosView = retweetphotosView;
}

- (void)setupToolbar
{
    DDStatusToolBar *toolbar = [[DDStatusToolBar alloc]init];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
}

-(void)setStatusFrame:(DDStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    Statuses *status = statusFrame.status;
    UserInfo *user = status.user;
    
    /** 原创微博*/
    self.originalView.frame = statusFrame.originalViewF;
    /** 头像*/
    self.iconView.frame = statusFrame.iconViewF;
    self.iconView.user = user;
    
    
    /** 配图*/
    if (status.pic_urls != nil)
    {
        self.photosView.frame = statusFrame.photosViewF;
        self.photosView.photos = status.pic_urls;
        self.photosView.hidden = NO;
    }
    else
    {
        self.photosView.hidden = YES;
    }

    
    /** 会员图标*/
    
    if (status.user.isVip)
    {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipImageName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipImageName];
        self.namelabel.textColor = [UIColor orangeColor];
    }
    else
    {
        self.namelabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    /** 昵称*/
    self.namelabel.text = user.name;
    self.namelabel.frame = statusFrame.namelabelF;
    
    /* 时间*/
    NSString *time = status.created_at;
    CGFloat timeX = statusFrame.namelabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.namelabelF) +cellBorderW;
    CGSize timeSize = [time  sizeWithLabelFont:cellTimeFont];
    self.timelabel.frame = (CGRect){{timeX,timeY},timeSize};
    self.timelabel.text = time;
    self.timelabel.textColor = [UIColor orangeColor];
    
    /* 来源*/
    
    CGFloat sourceX = CGRectGetMaxX(self.timelabel.frame) +cellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithLabelFont:cellSourceFont];
    self.sourcelabel.text = status.source;
    self.sourcelabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    self.sourcelabel.textColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
    
    /** 正文*/
    self.contentlabel.attributedText = status.attributedText;
    self.contentlabel.frame = statusFrame.contentlabelF;
    
    /** 被转发的微博*/
    /** 被转发的微博的整体*/

    if(status.retweeted_status)
    {
        Statuses *retweeted_status = status.retweeted_status;
        
        self.retweetView.hidden = NO;
        self.retweetView.frame = statusFrame.retweetViewF;
        
        /** 转发微博的正文*/
        self.retweetContentLabel.attributedText = retweeted_status.attributedText;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        /** 转发微博的配图*/
        if (retweeted_status.pic_urls != nil)
        {
            self.retweetphotosView.frame = statusFrame.retweetphotosViewF;
            self.retweetphotosView.photos = retweeted_status.pic_urls;
            self.retweetphotosView.hidden = NO;
        }
        else
        {
            self.retweetphotosView.hidden = YES;
        }

    }
    else
    {
        self.retweetView.hidden = YES;
    }
    
    /*工具条*/
    self.toolbar.frame = statusFrame.toolbarF;
    self.toolbar.status = status;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
