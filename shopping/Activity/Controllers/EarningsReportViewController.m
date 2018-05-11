//
//  EarningsReportViewController.m
//  shopping
//
//  Created by 谷朝阳 on 2017/12/26.
//  Copyright © 2017年 GCY. All rights reserved.

//收益报表

#import "EarningsReportViewController.h"

#import "OrderDetailViewController.h"

@interface EarningsReportViewController ()

@property(nonatomic, strong)UILabel *timeLabel;

@property(nonatomic, strong)UILabel *incomeLabel;

@property(nonatomic, strong)UILabel *incomeDetailLabel;


@end

@implementation EarningsReportViewController

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
    
//    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = BackgroundColor;
    
    [self createNavigationItem];
    
    [self layoutView];
}

- (void)createNavigationItem{
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = @"收益报表";
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
    
    //同步时间
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).mas_offset(5*SProportion_Height);
        make.height.mas_equalTo(20*SProportion_Height);
    }];
    
    for (int i=0; i<2; i++) {
        
        //预估收入底层
        UIView *revenueView = [[UIView alloc] init];
        revenueView.backgroundColor = [UIColor whiteColor];
        [weakSelf.view addSubview:revenueView];
        
        [revenueView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.view);
            make.top.equalTo(_timeLabel.mas_bottom).mas_offset(5*SProportion_Height + 95*SProportion_Height*i);
            make.height.mas_offset(90*SProportion_Height);
        }];
        //红色标识
        UIView *redLine = [[UIView alloc] initWithFrame:CGRectMake(10*SProportion_Width, 7.5f*SProportion_Height, 3*SProportion_Width, 15*SProportion_Height)];
        redLine.backgroundColor = [UIColor redColor];
        [revenueView addSubview:redLine];
        //文字
        UILabel *revenueText = [[UILabel alloc] initWithFrame:CGRectMake(20*SProportion_Width, 5*SProportion_Height, 100*SProportion_Width, 20*SProportion_Height)];
        revenueText.text = @"预估收入";
        if (i==1) {
            revenueText.text = @"结算收入";
        }
        revenueText.font = font(15);
        revenueText.textColor = Dark_TextColor;
        revenueText.adjustsFontSizeToFitWidth = YES;
        [revenueView addSubview:revenueText];
        //横线
        UIView *horLine = [[UIView alloc] initWithFrame:CGRectMake(10*SProportion_Width, 30*SProportion_Height, 300*SProportion_Width, 1)];
        horLine.backgroundColor = BackgroundColor;
        [revenueView addSubview:horLine];
        //竖线
        UIView *verLine = [[UIView alloc] initWithFrame:CGRectMake(Screen_Width/2, 40*SProportion_Height, 1, 40*SProportion_Height)];
        verLine.backgroundColor = BackgroundColor;
        [revenueView addSubview:verLine];
        //本月预估、本月结算
        UILabel *thisMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40*SProportion_Height, Screen_Width/2, 30*SProportion_Height)];
        thisMonthLabel.tag = 10+i;
        thisMonthLabel.text = @"￥66.88";
        thisMonthLabel.font = font(18);
        thisMonthLabel.textColor = Dark_TextColor;
        thisMonthLabel.textAlignment = NSTextAlignmentCenter;
        thisMonthLabel.adjustsFontSizeToFitWidth = YES;
        [revenueView addSubview:thisMonthLabel];
        
        UILabel *thisMonthText = [[UILabel alloc] initWithFrame:CGRectMake(0, 65*SProportion_Height, Screen_Width/2, 20*SProportion_Height)];
        thisMonthText.text = @"本月预估";
        if (i==1) {
            thisMonthText.text = @"本月结算";
        }
        thisMonthText.font = font(15);
        thisMonthText.textColor = Light_TextColor;
        thisMonthText.textAlignment = NSTextAlignmentCenter;
        thisMonthText.adjustsFontSizeToFitWidth = YES;
        [revenueView addSubview:thisMonthText];
        
        //上月预估、本月结算
        UILabel *lastMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width/2, 40*SProportion_Height, Screen_Width/2, 30*SProportion_Height)];
        lastMonthLabel.tag = 20+i;
        lastMonthLabel.text = @"￥88.88";
        lastMonthLabel.font = font(18);
        lastMonthLabel.textColor = Dark_TextColor;
        lastMonthLabel.textAlignment = NSTextAlignmentCenter;
        lastMonthLabel.adjustsFontSizeToFitWidth = YES;
        [revenueView addSubview:lastMonthLabel];
        
        UILabel *lastMonthText = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width/2, 65*SProportion_Height, Screen_Width/2, 20*SProportion_Height)];
        lastMonthText.text = @"上月预估";
        if (i==1) {
            lastMonthText.text = @"上月结算";
        }
        lastMonthText.font = font(15);
        lastMonthText.textColor = Light_TextColor;
        lastMonthText.textAlignment = NSTextAlignmentCenter;
        lastMonthText.adjustsFontSizeToFitWidth = YES;
        [revenueView addSubview:lastMonthText];
    }
    
    //今日、昨日button
    NSArray *btnTitles = @[@"今日",@"昨日"];
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 200+i;
        button.frame = CGRectMake(Screen_Width/2*i, 220*SProportion_Height, Screen_Width/2, 30*SProportion_Height);
        [button setTitleColor:Dark_TextColor forState:UIControlStateNormal];
        if (i==0) {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        [button setBackgroundColor:[UIColor whiteColor]];
        button.titleLabel.font = font(15);
        [button setTitle:btnTitles[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [weakSelf.view addSubview:button];
    }
    
    //今日、昨日信息底层VIEW
    UIView *todayBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 251*SProportion_Height, Screen_Width, 70*SProportion_Height)];
    todayBaseView.backgroundColor = [UIColor whiteColor];
    [weakSelf.view addSubview:todayBaseView];
    
    _incomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*SProportion_Width, 10*SProportion_Height, Screen_Width, 20*SProportion_Height)];
    _incomeLabel.text = @"预估收入：120.55";
    _incomeLabel.font = font(18);
    _incomeLabel.textColor = Dark_TextColor;
    _incomeLabel.adjustsFontSizeToFitWidth = YES;
    [todayBaseView addSubview:_incomeLabel];
    
    _incomeDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*SProportion_Width,35*SProportion_Height, Screen_Width, 30*SProportion_Height)];
    _incomeDetailLabel.text = @"1 级：20.01 (3单)   2 级：12.01 (5单)   3 级：30.12 (2单)";
    _incomeDetailLabel.numberOfLines = 0;
    _incomeDetailLabel.font = font(14);
    _incomeDetailLabel.textColor = Dark_TextColor;
    _incomeDetailLabel.adjustsFontSizeToFitWidth = YES;
    [todayBaseView addSubview:_incomeDetailLabel];
    
    //查看订单明细
    UIButton *orderDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    orderDetailButton.frame = CGRectMake(0, 325*SProportion_Height, Screen_Width, 30*SProportion_Height);
    orderDetailButton.tag = 300;
    [orderDetailButton setBackgroundColor:[UIColor whiteColor]];
    [orderDetailButton setTitle:@"查看订单明细" forState:UIControlStateNormal];
    [orderDetailButton setTitleColor:Dark_TextColor forState:UIControlStateNormal];
    orderDetailButton.titleLabel.font = font(15);
    orderDetailButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [orderDetailButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [weakSelf.view addSubview:orderDetailButton];
}

- (void)buttonClick:(UIButton *)button{
    if (button.tag == 100) {
        //返回
        [self.navigationController popViewControllerAnimated:YES];
    }else if (button.tag == 200){
        //今日
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        UIButton *btn = [self.view viewWithTag:201];
        [btn setTitleColor:Dark_TextColor forState:UIControlStateNormal];

    }else if (button.tag == 201){
        //昨日
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        UIButton *btn = [self.view viewWithTag:200];
        [btn setTitleColor:Dark_TextColor forState:UIControlStateNormal];
    }else if (button.tag == 300){
        //查看订单明细
        OrderDetailViewController *odvc = [[OrderDetailViewController alloc] init];
        [self.navigationController pushViewController:odvc animated:YES];
    }
}

#pragma mark -
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"订单最后同步时间：2017.12.26 15:20";
        _timeLabel.font = font(14);
        _timeLabel.textColor = Dark_TextColor;
        _timeLabel.backgroundColor = [UIColor whiteColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:_timeLabel];
    }
    return _timeLabel;
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
