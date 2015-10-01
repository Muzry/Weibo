//
//  DDStatusCell.h
//  蛋蛋微博
//
//  Created by LiDan on 15/8/23.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DDStatusFrame;

@interface DDStatusCell : UITableViewCell
@property (nonatomic,strong) DDStatusFrame * statusFrame;


+(instancetype) cellWithTableView:(UITableView *)tableView;
@end
