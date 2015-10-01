//
//  DDOAuthViewController.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/17.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDOAuthViewController.h"
#import "AFNetworking.h"
#import "DDTabBarViewController.h"
#import "DDNewfeatureViewController.h"
#import "DDAccount.h"
#import "MBProgressHUD+MJ.h"
#import "DDAccountTool.h"
#import "UIWindow+Extension.h"

@interface DDOAuthViewController ()<UIWebViewDelegate>

@end

@implementation DDOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.创建一个WebView
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    // 2.加载登陆界面
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=458916935&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.delegate = self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0)
    {
        long fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        
        [self accessTokenWithCode:code];
        return NO; //禁止回调
    }
    
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"client_id"] = @"458916935";
    params[@"client_secret"] = @"942a8b4e084b31058aaaaad2ab84dae6";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.baidu.com";
    
    // 3. 发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject)
    {
        [MBProgressHUD hideHUD];

        // 将返回的账号字典数据转换成模型，存进沙盒
        DDAccount *account = [DDAccount accountWithDic:responseObject];
        
        // 存储账号信息
        [DDAccountTool saveAccount:account];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
        NSLog(@"请求失败-%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
