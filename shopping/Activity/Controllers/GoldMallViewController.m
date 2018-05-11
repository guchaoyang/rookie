//
//  GoldMallViewController.m
//  shopping
//
//  Created by 谷朝阳 on 2018/3/2.
//  Copyright © 2018年 GCY. All rights reserved.
//

#import "GoldMallViewController.h"

@interface GoldMallViewController ()<UIWebViewDelegate>

@property(nonatomic, strong)UIWebView *webView;

@end

@implementation GoldMallViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor] frame:self.navigationController.navigationBar.bounds] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:image(@"home_img_navBackground") forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackgroundColor;
    
    [self createNavigationItem];
    
    [self layoutView];
}

- (void)createNavigationItem{
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = @"金币商城";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = Dark_TextColor;
    self.navigationItem.titleView = title;
    
    //导航返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.tag = 100;
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    [backBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:image(NAV_BACKBTN_NAME) forState:UIControlStateNormal];
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
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    NSLog(@"网页加载失败原因：%@",error);
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
        
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://activity.m.duiba.com.cn/signactivity/index?id=90&dpm=43925.41.1.0&dcm=216.90.51.0&appKey=3jiby5sMJVkuVoiHbD37JLLYdmva&open4share=tongdun"] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0f]];
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
