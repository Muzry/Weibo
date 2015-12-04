//
//  DDTitleMenuViewController.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/13.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDTitleMenuViewController.h"

@interface DDTitleMenuViewController ()

@end

@implementation DDTitleMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"好友圈";
    }
    
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"密友圈";
    }
    else if (indexPath.row == 2) {
            cell.textLabel.text = @"全部";
        }
    
    
    return cell;
}


@end
