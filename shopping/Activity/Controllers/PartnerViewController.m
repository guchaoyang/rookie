//
//  PartnerViewController.m
//  shopping
//
//  Created by 谷朝阳 on 2017/12/22.
//  Copyright © 2017年 GCY. All rights reserved.
//

#import "PartnerViewController.h"

#import "EarningsReportViewController.h"//收益报表

#import "OrderDetailViewController.h"

#import "FansViewController.h"

#import "WithdrawalRecordViewController.h"//提现记录

#import "ShareViewController.h"

#import "IncomeRankViewController.h"

#define YELLOW_COLOR customColor(@"#FFAE00")

@interface PartnerViewController ()
{
    UIImageView *_backImageView;
}
@property(nonatomic, strong)UILabel *withdrawalAmountLabel;

@end

@implementation PartnerViewController

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
    // YES:从屏幕最上边开始 NO:从导航下边开始（默认）
//    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = BackgroundColor;
    
    [self createNavigationItem];
    
    [self layoutView];
}

- (void)createNavigationItem{
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = @"合伙人中心";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = Dark_TextColor;
    self.navigationItem.titleView = title;
    
    //导航返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.tag = 100;
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    [backBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    [backBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:image(NAV_BACKBTN_NAME) forState:UIControlStateNormal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = left;
    
    //分享
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.tag = 150;
    shareBtn.frame = CGRectMake(0, 0, 30, 30);
    //图片左移
    [shareBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
    [shareBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setImage:[UIImage imageNamed:@"activity_btn_share"] forState:UIControlStateNormal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:shareBtn];
    self.navigationItem.rightBarButtonItem = right;
    
}

- (void)layoutView{
    
    __weak typeof(self) weakSelf = self;//防止循环引用
    
    _backImageView = [[UIImageView alloc] init];
//    _backImageView.backgroundColor = YELLOW_COLOR;
    _backImageView.image = image(@"activity_img_partCent_topBagound");
//    _backImageView.userInteractionEnabled = YES;
    [weakSelf.view addSubview:_backImageView];
    
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.view);
//        make.top.equalTo(weakSelf.view).mas_offset(UI_IS_IPHONE_X?88:64);
        make.height.mas_equalTo(80*SProportion_Height);
    }];
    
    UILabel *withdrawalText = [[UILabel alloc] init];
    withdrawalText.text = @"可提现金额";
    withdrawalText.font = font(14);
    withdrawalText.textColor = [UIColor whiteColor];
    withdrawalText.textAlignment = NSTextAlignmentCenter;
    withdrawalText.adjustsFontSizeToFitWidth = YES;
    [_backImageView addSubview:withdrawalText];
    
    [withdrawalText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(_backImageView).mas_offset(10*SProportion_Height);
        make.height.mas_equalTo(15*SProportion_Height);
    }];
    
    //可提现的金额
    [self.withdrawalAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(withdrawalText.mas_bottom);
        make.height.mas_equalTo(40*SProportion_Height);
    }];
    
    //提现Button
    UIButton *withdrawalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    withdrawalButton.tag = 200;
    cut(withdrawalButton, 15*SProportion_Height);
    [withdrawalButton setTitle:@"立即提现" forState:UIControlStateNormal];
    [withdrawalButton setBackgroundColor:customColor(@"#FFE400")];
    [withdrawalButton setTitleColor:customColor(@"#5D230B") forState:UIControlStateNormal];
    withdrawalButton.titleLabel.font = font(18);
    [withdrawalButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [weakSelf.view addSubview:withdrawalButton];
    
    [withdrawalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).mas_offset(30*SProportion_Width);
        make.top.equalTo(_backImageView.mas_bottom).mas_offset(-15*SProportion_Height);
        make.size.mas_equalTo(CGSizeMake(260*SProportion_Width, 30*SProportion_Height));
    }];
    
    //收入信息底层view
    UIView *forecastView = [[UIView alloc] init];
    cut(forecastView, 10);
    forecastView.backgroundColor = [UIColor whiteColor];
    [weakSelf.view addSubview:forecastView];
    
    [forecastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).mas_offset(5*SProportion_Width);
        make.right.equalTo(weakSelf.view).mas_offset(-5*SProportion_Width);
        make.top.equalTo(withdrawalButton.mas_bottom).mas_offset(5*SProportion_Height);
        make.height.mas_equalTo(70*SProportion_Height);
    }];
    
    UIView *verLine = [[UIView alloc] init];
    verLine.backgroundColor = BackgroundColor;
    [forecastView addSubview:verLine];
    
    [verLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(Screen_Width/2);
        make.top.mas_offset(20*SProportion_Height);
        make.size.mas_offset(CGSizeMake(1, 30*SProportion_Height));
    }];
    
    //收入文字信息
    NSArray *textArr = @[@"本月预估收入" ,@"上月实际收入"];
    NSArray *textArr2 = @[@"待结算" ,@"已结算"];

    for (int i=0; i<2; i++) {
        UILabel *text = [[UILabel alloc] init];
        text.text = textArr[i];
        text.font = font(14);
        text.textColor = Light_TextColor;
        text.textAlignment = NSTextAlignmentCenter;
        text.adjustsFontSizeToFitWidth = YES;
        [forecastView addSubview:text];
        
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(forecastView).mas_offset(155*SProportion_Width*i);
            make.top.equalTo(forecastView).mas_offset(10*SProportion_Height);
            make.size.mas_offset(CGSizeMake(155*SProportion_Width, 15*SProportion_Height));
        }];
        
        //金额
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.tag = 300 + i;
        priceLabel.text = @"￥2000.80元";
        priceLabel.font = font(18);
        priceLabel.textColor = Dark_TextColor;
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.adjustsFontSizeToFitWidth = YES;
        [forecastView addSubview:priceLabel];
        
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(forecastView).mas_offset(155*SProportion_Width*i);
            make.top.equalTo(text.mas_bottom);
            make.size.mas_offset(CGSizeMake(155*SProportion_Width, 25*SProportion_Height));
        }];
        
        //待结算、已结算文字 settlement
        UILabel *settlementText = [[UILabel alloc] init];
        settlementText.text = textArr2[i];
        settlementText.font = font(14);
        settlementText.textColor = [UIColor redColor];
        settlementText.textAlignment = NSTextAlignmentCenter;
        settlementText.adjustsFontSizeToFitWidth = YES;
        if (i == 1) {
            settlementText.textColor = YELLOW_COLOR;
        }
        [forecastView addSubview:settlementText];
        
        [settlementText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(forecastView).mas_offset(155*SProportion_Width*i);
            make.top.equalTo(priceLabel.mas_bottom);
            make.size.mas_offset(CGSizeMake(155*SProportion_Width, 15*SProportion_Height));
        }];
    }
    
    //提现提示信息
    UILabel *infoMesLabel = [[UILabel alloc] init];
    infoMesLabel.text = @"每25日结算上月预估收入，本月预估收入则在下月25日结算";
    infoMesLabel.font = font(13);
    infoMesLabel.backgroundColor = [UIColor whiteColor];
    infoMesLabel.textColor = Dark_TextColor;
    infoMesLabel.textAlignment = NSTextAlignmentCenter;
    infoMesLabel.adjustsFontSizeToFitWidth = YES;
    [weakSelf.view addSubview:infoMesLabel];
    
    [infoMesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(forecastView.mas_bottom).mas_offset(5*SProportion_Height);
        make.height.mas_offset(20*SProportion_Height);
    }];
    
    //收益报表、订单明细、我的粉丝、提现记录、分享APP、收入排行、公告通知、攻略教程、常见问题button
    NSArray *bottomBtnArray = @[@"收益报表",@"订单明细",@"我的粉丝",@"提现记录",@"分享APP",@"收入排行",@"公告通知",@"攻略教程",@"常见问题"];
    NSArray *bottomBtnImageArray = @[@"activity_btn_earReport",@"activity_btn_orderDetail",@"activity_btn_myFans",@"activity_btn_withRecord",@"activity_btn_shareApp",@"activity_btn_incomeRank",@"activity_btn_notifiection",@"activity_btn_guides",@"activity_btn_question"];
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [weakSelf.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(infoMesLabel.mas_bottom).mas_offset(5*SProportion_Height);
    }];
    
    for (int i=0; i<bottomBtnArray.count; i++){
        
        int x = i%3;
        int y = i/3;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 500+i;
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitle:bottomBtnArray[i] forState:UIControlStateNormal];
        [button setImage:image(bottomBtnImageArray[i]) forState:UIControlStateNormal];
        [button setTitleColor:Dark_TextColor forState:UIControlStateNormal];
        button.titleLabel.font = font(15);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Screen_Width/3 * x);
            make.top.mas_offset(80*SProportion_Height*y);
            make.size.mas_equalTo(CGSizeMake(Screen_Width/3, 80*SProportion_Height));
        }];
        
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10*SProportion_Height];
    
    }
    
    //6条竖线
    for (int i=0; i<6; i++){
        
        int x = i%2;
        int y = i/2;
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = BackgroundColor;
        [bottomView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(Screen_Width/3*(x+1));
            make.top.mas_offset(60*SProportion_Height*y + 20*SProportion_Height*(y+1));
            make.size.mas_offset(CGSizeMake(1, 40*SProportion_Height));
        }];
    }
    
    //两条横线
    for (int i=0; i<2; i++){
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = BackgroundColor;
        [bottomView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(30*SProportion_Width);
            make.top.mas_offset(80*SProportion_Height*(i+1));
            make.size.mas_offset(CGSizeMake(260*SProportion_Width, 1));
        }];
    }
}

- (void)buttonClick:(UIButton *)button{
    if (button.tag == 100) {
        //返回
        [self.navigationController popViewControllerAnimated:YES];
    }else if (button.tag == 150){
        //分享
    }else if (button.tag == 200){
        //发起提现
        NSLog(@"tixian");
    }else if (button.tag == 500){
        //收益报表
        EarningsReportViewController *ervc = [[EarningsReportViewController alloc] init];
        [self.navigationController pushViewController:ervc animated:YES];
    }else if (button.tag == 501){
        //订单明细
        OrderDetailViewController *odvc = [[OrderDetailViewController alloc] init];
        [self.navigationController pushViewController:odvc animated:YES];
    }else if (button.tag == 502){
        //我的粉丝
        FansViewController *fvc = [[FansViewController alloc] init];
        [self.navigationController pushViewController:fvc animated:YES];
    }else if (button.tag == 503){
        //提现记录
        WithdrawalRecordViewController *wrvc = [[WithdrawalRecordViewController alloc] init];
        [self.navigationController pushViewController:wrvc animated:YES];
    }else if (button.tag == 504){
        //分享
        ShareViewController *svc = [[ShareViewController alloc] init];
        [self.navigationController pushViewController:svc animated:YES];
    }else if (button.tag == 505){
        //收入排行
        IncomeRankViewController *irvc = [[IncomeRankViewController alloc] init];
        [self.navigationController pushViewController:irvc animated:YES];
    }else if (button.tag == 506){
        //公告通知
    }else if (button.tag == 507){
        //攻略教程
    }else if (button.tag == 508){
        //常见问题
    }
}

#pragma mark -
- (UILabel *)withdrawalAmountLabel{
    if (!_withdrawalAmountLabel) {
        _withdrawalAmountLabel = [[UILabel alloc] init];
        _withdrawalAmountLabel.text = @"150.68";
        _withdrawalAmountLabel.font = font(25);
        _withdrawalAmountLabel.textColor = [UIColor whiteColor];
        _withdrawalAmountLabel.textAlignment = NSTextAlignmentCenter;
        _withdrawalAmountLabel.adjustsFontSizeToFitWidth = YES;
        [_backImageView addSubview:_withdrawalAmountLabel];
    }
    return _withdrawalAmountLabel;
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
