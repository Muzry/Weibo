//
//  DDComposeToolbar.h
//  蛋蛋微博
//
//  Created by LiDan on 15/8/31.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum
{
    DDComposeToolbarButtonTypeCamera,
    DDComposeToolbarButtonTypeAlbum,
    DDComposeToolbarButtonTypeMention,
    DDComposeToolbarButtonTypeTrend,
    DDComposeToolbarButtonTypeEmotion
}DDComposeToolbarButtonType;

@class DDComposeToolbar;

@protocol DDComposeToolbarDelegate <NSObject>

@optional
-(void) composeToolbar:(DDComposeToolbar *) toolbar didClickButton:(DDComposeToolbarButtonType) buttonType;
@end

@interface DDComposeToolbar : UIView
@property (nonatomic,weak) id <DDComposeToolbarDelegate> delegate;
@property (nonatomic, assign) BOOL showKeyBoardButton;
@end
