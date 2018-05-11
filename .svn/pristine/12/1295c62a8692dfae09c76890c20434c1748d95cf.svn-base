//
//  GoldMallViewController.m
//  shopping
//
//  Created by 谷朝阳 on 2018/3/2.
//  Copyright © 2018年 GCY. All rights reserved.
//
//现金记录、金币记录等H5页面

#import "GoldMallViewController.h"

@interface GoldMallViewController ()<UIWebViewDelegate>
{
    MBProgressHUD *_hud;
}
@property(nonatomic, strong)UIWebView *webView;

@end

@implementation GoldMallViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor] frame:self.navigationController.navigationBar.bounds] forBarMetrics:UIBarMetricsDefault];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    //注册网络请求拦截
    [NSURLProtocol registerClass:[RichURLSessionProtocol class]];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
//    [self.navigationController.navigationBar setBackgroundImage:image(@"home_img_navBackground") forBarMetrics:UIBarMetricsDefault];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //取消注册网络请求拦截
    [NSURLProtocol unregisterClass:[RichURLSessionProtocol class]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackgroundColor;
    
    [self createNavigationItem];
    
    [self layoutView];
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)createNavigationItem{
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    switch (self.type) {
        case 0:
            title.text = @"现金记录";
            break;
        case 1:
            title.text = @"金币记录";
            break;
        case 2:
            title.text = @"邀请记录";
            break;
    }
    
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    //导航返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.tag = 100;
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    [backBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:image(NAV_WHITE_BACKBTN_NAME) forState:UIControlStateNormal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = left;
}

- (void)layoutView{
    
    __weak typeof(self) weakSelf = self;//防止循环引用
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(weakSelf.view);
    }];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"开始加载");
}
//开始获取到网页内容时返回
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSLog(@"加载完成");
    
    [_hud hideAnimated:YES];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    NSLog(@"网页加载失败原因：%@",error);
    
    [_hud hideAnimated:YES];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.backgroundColor = BackgroundColor;
        _webView.delegate = self;
        [_webView setScalesPageToFit:YES];
        [self.view addSubview:_webView];
        
        NSString *requestString = @"";
        switch (self.type) {
            case 0:
                requestString = [NSString stringWithFormat:@"%@%@",[BasicInfoClass shared].base_url, CASH_RECORD];
                break;
            case 1:
                requestString = [NSString stringWithFormat:@"%@%@",[BasicInfoClass shared].base_url, GOLD_RECORD];
                break;
            case 2:
                requestString = [NSString stringWithFormat:@"%@%@",[BasicInfoClass shared].base_url, INVITE_RECORD];
                break;
        }
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestString]];
        //设置请求头
        [request setValue:[Helper createRequestHeadString] forHTTPHeaderField:@"auth"];
        [_webView loadRequest:request];
    }
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
