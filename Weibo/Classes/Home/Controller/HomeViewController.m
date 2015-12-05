//
//  HomeViewController.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/7.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "Weibo-Prefix.pch"
#import "UIView+Extension.h" 
#import "UIImage+Extension.h"
#import "DDDropdownMenu.h"
#import "DDTitleMenuViewController.h"
#import "AFNetworking.h"
#import "DDAccountTool.h"
#import "DDTitleButton.h"
#import "UIImageView+WebCache.h"
#import "Statuses.h"
#import "UserInfo.h"
#import "DDLoadMoreFooter.h"
#import "DDStatusCell.h"
#import "DDStatusFrame.h"

@interface HomeViewController ()<DDDropDownMenuDelegate>


@property (nonatomic, strong) NSMutableArray *statusFrames;
@end

@implementation HomeViewController

-(NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        self.statusFrames = [[NSMutableArray alloc] init];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1];
    
    // 设置导航栏内容
    [self setupNav];
    
    // 获得用户信息（昵称）
    [self setupUserInfo];
    
    
    // 加载最新的微博数据
    [self setupDownRefresh];
    
    // 集成上拉刷新空间
    [self setupUpRefresh];

}

-(void)setupUpRefresh
{
    DDLoadMoreFooter *footer = [DDLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

- (void)setupDownRefresh
{
    UIRefreshControl *control = [[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:control];
    
    // 2.马上进入刷新
    [control beginRefreshing];
    
    // 3.马上加载数据
    [self loadNewStatus:control];
}

- (void)showNewStatusCount:(int)count
{
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 30;
    if (count != 0) {
        label.text =[NSString stringWithFormat:@"%d条新微博",count];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        label.y = 64 - label.height;
        
        [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
        CGFloat duration = 1.0;
        [UIView animateWithDuration:duration animations:^{
            
            label.transform = CGAffineTransformMakeTranslation(0, label.height);
            
        } completion:^(BOOL finished) {
            
            CGFloat delay = 1.0;
            
            [UIView animateKeyframesWithDuration:duration delay:delay options:UIViewAnimationCurveLinear animations:^{
                label.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
            }];
        }];
    }
    
}

- (void)loadNewStatus:(UIRefreshControl *)control
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    DDAccount *account = [DDAccountTool account];
    
    params[@"access_token"] = account.access_token;
    DDStatusFrame *firstStatusF = [self.statusFrames firstObject];
    if (firstStatusF)
    {
        params[@"since_id"] = firstStatusF.status.idstr;
    }
    
    // 3. 发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject)
     {
         NSArray *newStatuses = responseObject[@"statuses"];
         NSMutableArray *newStatusFrames = [NSMutableArray array];
         // 将 “微博字典” 数组 转为模型
         
         for (NSDictionary *dict in newStatuses)
         {
             Statuses *status = [Statuses statusWithDict:dict];
             DDStatusFrame *statusF = [[DDStatusFrame alloc]init];
             statusF.status = status;
             [newStatusFrames addObject:statusF];
         }
         if(newStatusFrames != nil)
         {
             NSRange range = NSMakeRange(0, newStatusFrames.count);
             NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
             [self.statusFrames insertObjects:newStatusFrames atIndexes:set];
         }
         
         // 刷新表格
         
         [self.tableView reloadData];
         //结束刷新
         [control endRefreshing];
         [self showNewStatusCount:newStatusFrames.count];
         
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"请求失败-%@",error);
         //结束刷新
         [control endRefreshing];
     }];

}

-(void)loadMoreStatus
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    DDAccount *account = [DDAccountTool account];
    
    params[@"access_token"] = account.access_token;
    DDStatusFrame *lastStatusF = [self.statusFrames lastObject];
    if (lastStatusF)
    {
        long long maxId = lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    // 3. 发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject)
     {
         NSArray *newStatuses = responseObject[@"statuses"];
         NSMutableArray *newStatusFrame = [NSMutableArray array];
         
         // 将 “微博字典” 数组 转为模型
         
         for (NSDictionary *dict in newStatuses)
         {
             Statuses *status = [Statuses statusWithDict:dict];
             DDStatusFrame *statusF = [[DDStatusFrame alloc]init];
             statusF.status = status;
             [newStatusFrame addObject:statusF];
         }
         if(newStatusFrame != nil)
         {
             [self.statusFrames addObjectsFromArray:newStatusFrame];
         }
         
         // 刷新表格
         
         [self.tableView reloadData];
         //结束刷新
         self.tableView.tableFooterView.hidden = YES;
         
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"请求失败-%@",error);
         //结束刷新
         self.tableView.tableFooterView.hidden = YES;
     }];
  
}

// 设置导航栏内容
- (void) setupNav
{
    /* 设置导航栏上面的内容 */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(popSearch) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    /* 中间的标题按钮 */
    DDTitleButton *titleButton = [[DDTitleButton alloc] init];
    // 设置图片和文字
    NSString *name = [DDAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    // 监听标题点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}

// 获得用户信息（昵称）
- (void)setupUserInfo
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    DDAccount *account = [DDAccountTool account];
    
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3. 发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject)
    {
        // 标题按钮
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        //设置名字
        UserInfo *user = [UserInfo userWithDict:responseObject];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 存储昵称到沙盒中
        account.name = user.name;
        [DDAccountTool saveAccount:account];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
         NSLog(@"请求失败-%@",error);
     }];
   
}

- (void)titleClick:(UIButton *)titleButton
{
    //显示下拉菜单
    DDDropdownMenu *menu = [DDDropdownMenu menu];
    DDTitleMenuViewController *vc = [[DDTitleMenuViewController alloc]init];
    vc.view.height = 44 * 3;
    vc.view.width = 150;
    menu.contentController = vc;
    menu.delegate = self;
    
    //显示
    [menu showFrom:titleButton];
    
    
}

-(void)friendSearch
{
    NSLog(@"friendSearch------");
}

-(void)popSearch
{
    NSLog(@"popSearch-------");
}

#pragma mark - DropdownMenuDelegate


-(void)dropdownMenuDidDismiss:(DDDropdownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = NO;
}

-(void)dropdownMenuDidShow:(DDDropdownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDStatusCell *cell = [DDStatusCell cellWithTableView:tableView];
    
    // 给cell传递模型数据
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}


/**
 *  1.将字典转为模型
    2.下拉刷新微博数据
    3.上拉加载最新的微博数据
 */

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO)
    {
        return ;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom
    -scrollView.height - self.tableView.tableFooterView.height;
    
    if (offsetY >= judgeOffsetY) {
        self.tableView.tableFooterView.hidden = NO;
        [self loadMoreStatus];
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
