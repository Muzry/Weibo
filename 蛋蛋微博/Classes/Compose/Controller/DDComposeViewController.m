//
//  DDComposeViewController.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/29.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "DDComposeViewController.h"
#import "DDAccountTool.h"
#import "UIView+Extension.h"
#import "DDEmotionTextView.h"
#import "Weibo-Prefix.pch"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "DDComposeToolbar.h"
#import "DDComposePhotosView.h"
#import "DDEmotionKeyBoard.h"
#import "DDEmotion.h"
#import "NSString+Emoji.h"


@interface DDComposeViewController() <UITextViewDelegate , DDComposeToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,weak) DDEmotionTextView *textView;
@property (nonatomic,weak) DDComposeToolbar *toolbar;

@property (nonatomic ,weak) DDComposePhotosView *photosView;
@property (nonatomic ,strong) DDEmotionKeyBoard *emotionKeyboard;
@property (nonatomic ,assign) BOOL switchingKeyboard;



@end

@implementation DDComposeViewController


-(DDEmotionKeyBoard *)emotionKeyboard
{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[DDEmotionKeyBoard alloc] init];
        self.emotionKeyboard.height = 216;
        self.emotionKeyboard.width = self.view.width;
    }
    return _emotionKeyboard;
}

#pragma mark - 初始化方法

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.rightBarButtonItem.enabled = NO;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    [self setupTextView];
    [self setupToolbar];
    [self setupPhotosView];
}

-(void)setupPhotosView
{
    DDComposePhotosView *photosView = [[DDComposePhotosView alloc]init];
    [self.textView addSubview:photosView];
    self.photosView = photosView;
    photosView.width = self.view.width;
    photosView.height = self.view.height;
    photosView.y = 100;
}

-(void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    
    UILabel *titleView = [[UILabel alloc]init];
    titleView.width = 200;
    titleView.height = 44;
    titleView.textAlignment = NSTextAlignmentCenter;
    
    // 自动换行
    titleView.numberOfLines = 0;
    NSString *name = [DDAccountTool account].name;
    NSString *prefix = @"发微博";
    
    if (name)
    {
        NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:[str rangeOfString:name]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:[str rangeOfString:prefix]];
        titleView.attributedText = attrStr;
        
        self.navigationItem.titleView = titleView;
    }
    else
    {
        self.title = prefix;
    }
}


-(void)setupTextView
{
    DDEmotionTextView * textView = [[DDEmotionTextView alloc] init];
    [self.view addSubview:textView];
    textView.frame = self.view.bounds;
    textView.alwaysBounceVertical = YES;
    textView.placeholder = @"分享新鲜事...";
    textView.font = [UIFont systemFontOfSize:18];
    textView.delegate = self;
    self.textView = textView;
    
    // 监听通知
    [DDNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    [DDNotificationCenter addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    //表情选中的通知
    [DDNotificationCenter addObserver:self selector:@selector(emotionDidSelect:) name:DDEmotionDidSelect object:nil];
    
    [DDNotificationCenter addObserver:self selector:@selector(emotionDidDelete) name:DDEmotionDidDeleteNotification object:nil];
}


-(void)emotionDidDelete
{
    [self.textView deleteBackward];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

-(void)setupToolbar
{
    DDComposeToolbar *toolbar= [[DDComposeToolbar alloc]init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

-(void)dealloc
{
    [DDNotificationCenter removeObserver:self];
}

/**
 *  监听文字改变
 */

-(void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

-(void)keyboardWillChange:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyBoardRect = [userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (self.switchingKeyboard)
    {
        return ;
    }
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.y = keyBoardRect.origin.y - self.toolbar.height;
    }];
    
}

-(void)emotionDidSelect:(NSNotification*) notification
{
    DDEmotion *emotion = notification.userInfo[DDSelectemotionKey];
    [self.textView insertEmotion:emotion];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    // https://api.weibo.com/2/statuses/update.json
    // 参数:
    /** status true string 要发布的微博内容，必须做URLencode */
    /** access_token true string 要发布的微博内容 */
    /** pic binary 微博的配图 */
    
    if (self.photosView.photos.count)
    {
        [self sendWithImage];
    }
    else
    {
        [self sendWithoutImage];
    }
    
    #warning TODO:模仿新浪微博的发送成功/失败 用uiwindow实现形式

    // 3. 发送请求

    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)sendWithImage
{

    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"access_token"] = [DDAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

-(void)sendWithoutImage
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"access_token"] = [DDAccountTool account].access_token;
    params[@"status"] = self.textView.fullText;
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject)
     {
         [MBProgressHUD showSuccess:@"发送成功"];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [MBProgressHUD showError:@"发送失败"];
     }];
}

- (void)composeToolbar:(DDComposeToolbar *)toolbar didClickButton:(DDComposeToolbarButtonType)buttonType
{
    switch (buttonType)
    {
        case DDComposeToolbarButtonTypeCamera:
            [self openCamera];
            break;
        case DDComposeToolbarButtonTypeAlbum:
            [self openAlbum];
            break;
        case DDComposeToolbarButtonTypeMention:
            break;
        case DDComposeToolbarButtonTypeTrend:
            break;
        case DDComposeToolbarButtonTypeEmotion:
            [self switchKeyboard];
            break;
    }
}

-(void) switchKeyboard
{
    if (self.textView.inputView == nil)
    {
        self.textView.inputView = self.emotionKeyboard;
        self.toolbar.showKeyBoardButton = YES;
    }
    else
    {
        self.textView.inputView = nil;
        self.toolbar.showKeyBoardButton = NO;
    }
    
    self.switchingKeyboard = YES;
    
    [self.textView endEditing:YES];
    
    self.switchingKeyboard = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];

    });
}

-(void)openCamera
{
    [self openImageIpckerController:UIImagePickerControllerSourceTypeCamera];
}

-(void)openAlbum
{
    [self openImageIpckerController:UIImagePickerControllerSourceTypePhotoLibrary];
}


-(void)openImageIpckerController:(UIImagePickerControllerSourceType) type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) {
        return;
    }
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addPhoto:image];
    if (!self.textView.hasText) {
        [self.textView insertText:@"分享图片"];
    }

}


@end
