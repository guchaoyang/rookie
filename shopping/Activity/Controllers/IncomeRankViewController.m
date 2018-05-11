//
//  IncomeRankViewController.m
//  shopping
//
//  Created by 谷朝阳 on 2017/12/27.
//  Copyright © 2017年 GCY. All rights reserved.
//

#import "IncomeRankViewController.h"

@interface IncomeRankViewController ()

@end

@implementation IncomeRankViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor] frame:self.navigationController.navigationBar.bounds] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
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
    title.text = @"收入排行";
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
    
    NSArray *rankImages = @[@"",@"",@""];
    
    for (int i=0; i<3; i++) {
        //图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(25*SProportion_Width + 105*SProportion_Width*i, 30*SProportion_Height, 60*SProportion_Width, 60*SProportion_Width)];
        imageView.image = image(rankImages[i]);
        imageView.backgroundColor = [UIColor blueColor];
        if (i==1) {
            imageView.frame = CGRectMake(120*SProportion_Width, 10*SProportion_Height, 80*SProportion_Width, 80*SProportion_Width);
        }
        [weakSelf.view addSubview:imageView];
        
        //姓名
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = @"王思聪";
        nameLabel.tag = 10+i;
        nameLabel.font = font(14);
        nameLabel.textColor = Dark_TextColor;
        nameLabel.adjustsFontSizeToFitWidth = YES;
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [weakSelf.view addSubview:nameLabel];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view).mas_offset(Screen_Width/3*i);
            make.top.mas_offset(90*SProportion_Height);
            make.size.mas_equalTo(CGSizeMake(Screen_Width/3, 20*SProportion_Height));
        }];
        
        //手机号
        UILabel *phoneNumLabel = [[UILabel alloc] init];
        phoneNumLabel.text = @"183****5099";
        phoneNumLabel.tag = 20+i;
        phoneNumLabel.font = font(14);
        phoneNumLabel.textColor = Dark_TextColor;
        phoneNumLabel.adjustsFontSizeToFitWidth = YES;
        phoneNumLabel.textAlignment = NSTextAlignmentCenter;
        [weakSelf.view addSubview:phoneNumLabel];
        
        [phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view).mas_offset(Screen_Width/3*i);
            make.top.equalTo(nameLabel.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(Screen_Width/3, 20*SProportion_Height));
        }];
        
        //金额
        UILabel *amountLabel = [[UILabel alloc] init];
        amountLabel.text = @"￥2169.65";
        amountLabel.tag = 30+i;
        amountLabel.font = font(14);
        amountLabel.textColor = Red_Color;
        amountLabel.adjustsFontSizeToFitWidth = YES;
        amountLabel.textAlignment = NSTextAlignmentCenter;
        [weakSelf.view addSubview:amountLabel];
        
        [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view).mas_offset(Screen_Width/3*i);
            make.top.equalTo(phoneNumLabel.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(Screen_Width/3, 20*SProportion_Height));
        }];
    }
}

- (void)buttonClick:(UIButton *)button{
    if (button.tag == 100) {
        //返回
        [self.navigationController popViewControllerAnimated:YES];
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
