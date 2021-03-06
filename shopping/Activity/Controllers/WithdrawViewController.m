//
//  WithdrawViewController.m
//  shopping
//
//  Created by 谷朝阳 on 2018/1/26.
//  Copyright © 2018年 GCY. All rights reserved.
//

#import "WithdrawViewController.h"

@interface WithdrawViewController ()

@property(nonatomic ,strong)UITextField *alipayAccTextField;

@property(nonatomic ,strong)UITextField *amountTextField;

@end

@implementation WithdrawViewController

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
    title.text = @"提现";
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

    //提示
    UILabel *mesLabel = [[UILabel alloc] init];
    mesLabel.text = @"注意：辛辛苦苦赚的钱，提现支付宝千万别输入错了哦~";
    mesLabel.textAlignment = NSTextAlignmentCenter;
    mesLabel.textColor = customColor(@"666666");
    mesLabel.font = font(13);
    mesLabel.adjustsFontSizeToFitWidth = YES;
    [weakSelf.view addSubview:mesLabel];
    
    [mesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakSelf.view);
        make.height.mas_equalTo(25*SProportion_Height);
    }];
    
    //白色底层
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = [UIColor whiteColor];
    [weakSelf.view addSubview:whiteView];
    
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(mesLabel.mas_bottom);
        make.height.mas_equalTo(80*SProportion_Height);
    }];
    
    NSArray *titles = @[@"支付宝账号",@"提现金额"];
    
    for (int i=0; i<2; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.text = titles[i];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = Dark_TextColor;
        label.font = font(15);
        [whiteView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view).mas_offset(20*SProportion_Width);
            make.top.mas_equalTo(40*SProportion_Height*i);
            make.size.mas_equalTo(CGSizeMake(90*SProportion_Width, 40*SProportion_Height));
        }];
    }
    
    //
    [whiteView addSubview:self.alipayAccTextField];
    [self.alipayAccTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(90*SProportion_Width);
        make.right.equalTo(weakSelf.view).mas_offset(-20*SProportion_Width);
        make.top.equalTo(mesLabel.mas_bottom);
        make.height.mas_equalTo(40*SProportion_Height);
    }];
    
    [whiteView addSubview:self.amountTextField];
    [self.amountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.alipayAccTextField);
        make.top.equalTo(self.alipayAccTextField.mas_bottom);
        make.height.mas_equalTo(40*SProportion_Height);
    }];
    
    //可提现金额
    UILabel *amountLabel = [[UILabel alloc] init];
    amountLabel.text = @"可提现金额 120.11 元";
    amountLabel.textAlignment = NSTextAlignmentRight;
    amountLabel.textColor = Light_TextColor;
    amountLabel.font = font(14);
    [weakSelf.view addSubview:amountLabel];
    
    [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(self.amountTextField.mas_bottom).mas_offset(5*SProportion_Height);
        make.right.mas_equalTo(-80*SProportion_Width);
        make.height.mas_equalTo(20*SProportion_Height);
    }];
    
    //全部提现btn
    UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    allButton.tag = 200;
    [allButton setTitle:@"全部提现" forState:UIControlStateNormal];
    allButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    allButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    allButton.titleLabel.font = font(14);
    [allButton setBackgroundColor:[UIColor clearColor]];
    [allButton setTitleColor:Red_Color forState:UIControlStateNormal];
    [allButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [weakSelf.view addSubview:allButton];
    
    [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(amountLabel.mas_right).mas_offset(5*SProportion_Width);
        make.right.equalTo(weakSelf.view).mas_offset(-20*SProportion_Width);
        make.top.equalTo(amountLabel);
        make.height.mas_equalTo(20*SProportion_Height);
    }];
    
    //确认提现btn
    UIButton *conButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cut(conButton, 6);
    conButton.tag = 300;
    [conButton setTitle:@"确认提现" forState:UIControlStateNormal];
    conButton.titleLabel.font = font(17);
    [conButton setBackgroundColor:customColor(@"#CCCCCC")];
    [conButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [conButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    conButton.enabled = NO;//默认不可点击
    [weakSelf.view addSubview:conButton];
    
    [conButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).mas_offset(20*SProportion_Width);
        make.top.equalTo(amountLabel.mas_bottom).mas_offset(20*SProportion_Height);
        make.size.mas_equalTo(CGSizeMake(280*SProportion_Width, 35*SProportion_Height));
    }];
}

- (void)buttonClick:(UIButton *)button{
    if (button.tag == 100) {
        //返回
        [self.navigationController popViewControllerAnimated:YES];
    }else if(button.tag == 200){
        //全部提现
        self.amountTextField.text = @"120.11";
        UIButton *conButton = [self.view viewWithTag:300];
        conButton.enabled = YES;
        [conButton setBackgroundColor:Red_Color];
    }else if(button.tag == 300){
        //确认提现
    }
}

- (void)textFieldChanged:(UITextField *)textField{
    
    if (textField == self.amountTextField) {
        UIButton *conButton = [self.view viewWithTag:300];
        if (![self.amountTextField.text isEqualToString:@""]) {
            conButton.enabled = YES;
            [conButton setBackgroundColor:Red_Color];
        }else{
            conButton.enabled = NO;
            [conButton setBackgroundColor:customColor(@"#CCCCCC")];
        }
    }
    
}

#pragma mark - lazyLoading
- (UITextField *)alipayAccTextField{
    if (!_alipayAccTextField) {
        _alipayAccTextField = [[UITextField alloc] init];
        _alipayAccTextField.backgroundColor = [UIColor whiteColor];
        _alipayAccTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _alipayAccTextField.textAlignment = NSTextAlignmentRight;
        _alipayAccTextField.font = font(15);
        _alipayAccTextField.keyboardType = UIKeyboardTypeDefault;
        _alipayAccTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入支付宝账号" attributes:@{NSForegroundColorAttributeName: Light_TextColor}];
    }
    return _alipayAccTextField;
}

- (UITextField *)amountTextField{
    if (!_amountTextField) {
        _amountTextField = [[UITextField alloc] init];
        _amountTextField.backgroundColor = [UIColor whiteColor];
        _amountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _amountTextField.textAlignment = NSTextAlignmentRight;
        _amountTextField.font = font(15);
        _amountTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _amountTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"0.00" attributes:@{NSForegroundColorAttributeName: Light_TextColor}];
        [_amountTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _amountTextField;
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
