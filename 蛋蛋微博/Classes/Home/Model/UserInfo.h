//
//  UserInfo.h
//  蛋蛋微博
//
//  Created by LiDan on 15/8/21.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    userVerifiedTypeNone = -1, // 没有认证
    userVerifiedTypePersonal = 0,
    userVerifiedTypeOrgEnterprice = 2,  //官方认证
    userVerifiedTypeOrgMedia = 3,       //官方认证
    userVerifiedTypeOrgWebsite =5,      //
    userVerifiedTypeDaren = 220         //微博达人
}userVerifiedType;

@interface UserInfo : NSObject
/** string 字符串型用户UID*/
@property (nonatomic,copy) NSString *idstr;

/** string 显示名称*/
@property (nonatomic,copy) NSString *name;

/** string 用户头像地址，50 * 50 像素 */
@property (nonatomic,copy) NSString *profile_image_url;

/** 会员类型 > 2，才代表是会员 */
@property (nonatomic,assign)int mbtype;

/** 会员等级*/
@property (nonatomic,assign)int mbrank;

@property (nonatomic,assign,getter=isVip)BOOL Vip;

@property (nonatomic, assign) userVerifiedType verified_type;

+(instancetype) userWithDict:(NSDictionary *)dict;
@end
