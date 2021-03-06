//
//  MessageCenterViewController.m
//  shopping
//
//  Created by 谷朝阳 on 2017/12/29.
//  Copyright © 2017年 GCY. All rights reserved.
//

#import "MessageCenterViewController.h"

#import "SystemNotificsViewController.h"

@interface MessageCenterViewController ()

@end

@implementation MessageCenterViewController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNavigationItem];
    
    [self layoutView];
}

- (void)createNavigationItem{
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = @"消息中心";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = Dark_TextColor;
    self.navigationItem.titleView = title;
    
    //导航返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.tag = 100;
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    //图片左移
    [backBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    [backBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:image(NAV_BACKBTN_NAME) forState:UIControlStateNormal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = left;
    
}

- (void)layoutView{
    
    __weak typeof(self) weakSelf = self;//防止循环引用
    
    NSArray *mesImages = @[@"img_message_person",@"img_message_system"];

    //创建2个白色底层按钮
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 200+i;
        [button setBackgroundColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [weakSelf.view addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.view);
            make.top.mas_equalTo(70*SProportion_Height*i);
            make.height.mas_equalTo(70*SProportion_Height);
        }];
        
        //图片
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = image(mesImages[i]);
        [button addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(button).mas_offset(20*SProportion_Width);
            make.top.equalTo(button).mas_offset(12.5f*SProportion_Width);
            make.size.mas_equalTo(CGSizeMake(45*SProportion_Height, 45*SProportion_Height));
        }];
        
        //top文字
        UILabel *topLabel = [[UILabel alloc] init];
        topLabel.font = [UIFont boldSystemFontOfSize:16];
        topLabel.text = @"系统消息";
        if (i == 1) {
            topLabel.text = @"我的消息";
        }
        topLabel.textColor = Dark_TextColor;
        topLabel.adjustsFontSizeToFitWidth = YES;
        [button addSubview:topLabel];
        
        [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).mas_offset(15*SProportion_Width);
            make.top.equalTo(imageView).mas_offset(5*SProportion_Width);
            make.size.mas_equalTo(CGSizeMake(100*SProportion_Width, 20*SProportion_Height));
        }];
        
        //bottom文字
        UILabel *bottomLabel = [[UILabel alloc] init];
        bottomLabel.font = font(15);
        bottomLabel.text = @"这里是系统消息";
        if (i == 1) {
            bottomLabel.text = @"专属权益、积分提醒等在这里查看哦 ~";
        }
        bottomLabel.textColor = Light_TextColor;
        bottomLabel.adjustsFontSizeToFitWidth = YES;
        [button addSubview:bottomLabel];
        
        [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topLabel);
            make.top.equalTo(topLabel.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(200*SProportion_Width, 20*SProportion_Height));
        }];
    }
    
    //三条分割线
    for (int i=0; i<3; i++) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = BackgroundColor;
        [weakSelf.view addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.view);
            make.top.mas_equalTo(70*SProportion_Height*i);
            make.height.mas_equalTo(SProportion_Height);
        }];
    }
}

- (void)buttonClick:(UIButton *)button{
    
    if (button.tag == 100) {
        //返回
        [self.navigationController popViewControllerAnimated:YES];
    }else if (button.tag == 200){
        //系统消息
        SystemNotificsViewController *snvc = [[SystemNotificsViewController alloc] init];
        [self.navigationController pushViewController:snvc animated:YES];
    }else if (button.tag == 201){
        //我的消息
        [XSInfoView showInfo:@"暂无个人消息" onView:self.view];
    }
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
