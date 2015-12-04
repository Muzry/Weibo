//
//  DDStatusFrame.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/23.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDStatusFrame.h"
#import "Statuses.h"
#import "UserInfo.h"
#import "UIView+Extension.h"
#import "NSString+Extension.h"
#import "DDStatusPhotosView.h"

@implementation DDStatusFrame

-(void)setStatus:(Statuses *)status
{
    _status = status;
    
    UserInfo *user = status.user;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;

    /* 头像*/
    CGFloat iconWH = 35;
    CGFloat iconX = cellBorderW;
    CGFloat iconY = cellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /* 昵称*/
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + cellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithLabelFont:cellNameFont ];
    self.namelabelF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);

    /* 会员图标*/
    CGFloat vipX = CGRectGetMaxX(self.namelabelF) + cellBorderW;
    CGFloat vipY = nameY;
    CGFloat vipH = nameSize.height;
    CGFloat vipW = 14;
    self.vipViewF = CGRectMake(vipX,vipY, vipW, vipH);

    /* 时间*/
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.namelabelF) +cellBorderW;
    CGSize timeSize = [status.created_at sizeWithLabelFont:cellTimeFont];
    self.timelabelF = (CGRect){{timeX,timeY},timeSize};

    /* 来源*/
    
    CGFloat sourceX = CGRectGetMaxX(self.timelabelF) +cellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithLabelFont:cellSourceFont];
    self.sourcelabelF = (CGRect){{sourceX,sourceY},sourceSize};

    /* 正文*/
    
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timelabelF)) + cellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [status.attributedText boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.contentlabelF = (CGRect){{contentX,contentY},contentSize};
    
    /* 配图*/
    CGFloat originalH;
    if (status.pic_urls != nil) {
        CGFloat photosX = contentX;
        CGFloat photosY = CGRectGetMaxY(self.contentlabelF) + cellBorderW;
        CGSize photosSize = [DDStatusPhotosView SizeWithCount:status.pic_urls.count];
        
        self.photosViewF = (CGRect){{photosX,photosY},photosSize};

        originalH  = CGRectGetMaxY(self.photosViewF) + cellBorderW;
    }
    else
    {
        originalH  = CGRectGetMaxY(self.contentlabelF) + cellBorderW;
    }

    
    
    /* 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = 0;

    self.originalViewF = CGRectMake(originalX, originalY,cellW, originalH);
    
    CGFloat toolbarY = 0;
    
    /* 被转发微博 */
    if(status.retweeted_status)
    {
        /* 被转发微博正文 */
        Statuses *retweeted_status = status.retweeted_status;
        CGFloat retweetContentX = cellBorderW;
        CGFloat retweetContentY = cellBorderW;
        CGSize retweetContentSize = [status.retweeted_status.attributedText boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
        self.retweetContentLabelF = (CGRect){{retweetContentX,retweetContentY},retweetContentSize};

        /* 被转发微博配图 */
        CGFloat retweetH;
        if (retweeted_status.pic_urls)
        {
            CGFloat retweetphotosX = retweetContentX;
            CGFloat retweetphotosY = CGRectGetMaxY(self.retweetContentLabelF) + cellBorderW;
            CGSize retweetphotosSize = [DDStatusPhotosView SizeWithCount:status.retweeted_status.pic_urls.count];
            self.retweetphotosViewF  = (CGRect){{retweetphotosX,retweetphotosY},retweetphotosSize};
            retweetH = CGRectGetMaxY(self.retweetphotosViewF) + cellBorderW;
        }
        else
        {
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + cellBorderW;
        }
        
        /* 被转发微博 */
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = cellW;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        toolbarY = CGRectGetMaxY(self.retweetViewF);
    }
    else
    {
        toolbarY = CGRectGetMaxY(self.originalViewF);
    }
    
    /** 工具条 */
    
    CGFloat toolbarX = 0;
    CGFloat toolbarW = cellW;
    CGFloat toolbarH = 30;
    
    self.toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    self.cellHeight = CGRectGetMaxY(self.toolbarF) + cellMarginW;
    
}

@end
