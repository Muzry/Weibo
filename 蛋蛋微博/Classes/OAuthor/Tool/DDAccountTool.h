//
//  DDAccountTool.h
//  蛋蛋微博
//
//  Created by LiDan on 15/8/18.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDAccount.h"

@interface DDAccountTool : NSObject

+ (void) saveAccount:(DDAccountTool *)account;

+ (DDAccount *)account;
@end
