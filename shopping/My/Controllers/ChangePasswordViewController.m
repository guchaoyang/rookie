//
//  ChangePasswordViewController.m
//  shopping
//
//  Created by 谷朝阳 on 2018/1/16.
//  Copyright © 2018年 GCY. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>

@property(nonatomic ,strong)UITextField *phoneNumTextField;

@property(nonatomic ,strong)UITextField *codeTextField;

@property(nonatomic ,strong)UITextField *passwordTextField;

@property(nonatomic ,strong)UITextField *conpasswordTextField;


@end

@implementation ChangePasswordViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor] frame:self.navigationController.navigationBar.bounds] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

//    [self.navigationController.navigationBar setBackgroundImage:image(@"home_img_navBackground") forBarMetrics:UIBarMetricsDefault];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNavigationItem];
    
    [self layoutView];
}

- (void)createNavigationItem{
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = @"修改密码";
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
    
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*SProportion_Width);
        make.top.mas_equalTo(20*SProportion_Height);
        make.size.mas_equalTo(CGSizeMake(300*SProportion_Width, 40*SProportion_Height));
    }];
    ///验证码
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneNumTextField);
        make.top.mas_equalTo(self.phoneNumTextField.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(210*SProportion_Width, 40*SProportion_Height));
    }];
    ///密码
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneNumTextField);
        make.top.mas_equalTo(self.codeTextField.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(300*SProportion_Width, 40*SProportion_Height));
    }];
    ///重复密码
    [self.conpasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneNumTextField);
        make.top.mas_equalTo(self.passwordTextField.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(300*SProportion_Width, 40*SProportion_Height));
    }];
    
    
    //发送验证码
    UIButton *sendCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cut(sendCodeButton, 3);
    cutBorder(sendCodeButton, 0.5f, @"#FF2400");
    sendCodeButton.tag = 200;
    [sendCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    sendCodeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    sendCodeButton.titleLabel.font = font(15);
    [sendCodeButton setBackgroundColor:[UIColor whiteColor]];
    [sendCodeButton setTitleColor:Red_Color forState:UIControlStateNormal];
    [sendCodeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [weakSelf.view addSubview:sendCodeButton];
    
    [sendCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.codeTextField.mas_right).mas_offset(10*SProportion_Width);
        make.top.equalTo(self.phoneNumTextField.mas_bottom).mas_offset(5*SProportion_Height);
        make.size.mas_equalTo(CGSizeMake(80*SProportion_Width, 35*SProportion_Height));
    }];
    
    //确定
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cut(nextButton, 5);
    nextButton.tag = 300;
    [nextButton setTitle:@"确定" forState:UIControlStateNormal];
    nextButton.titleLabel.font = font(17);
    [nextButton setBackgroundColor:BackgroundColor];
    [nextButton setTitleColor:Light_TextColor forState:UIControlStateNormal];
    nextButton.enabled = NO;
    [nextButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [weakSelf.view addSubview:nextButton];
    
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.conpasswordTextField.mas_bottom).mas_offset(30*SProportion_Height);
        make.left.equalTo(self.phoneNumTextField);
        make.size.mas_equalTo(CGSizeMake(300*SProportion_Width, 35*SProportion_Height));
    }];
    ///横线
    for (int i=0; i<4; i++){
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10*SProportion_Width, 60*SProportion_Height + 40*SProportion_Height*i, 300*SProportion_Width, 0.5f)];
        line.backgroundColor = Light_TextColor;
        if (i==1) {
            line.frame = CGRectMake(10*SProportion_Width, 100*SProportion_Height, 210*SProportion_Width, 0.5f);
        }
        [weakSelf.view addSubview:line];
    }
}

- (void)buttonClick:(UIButton *)button{
    if (button.tag == 100) {
        //返回
        [self.navigationController popViewControllerAnimated:YES];
    }else if (button.tag == 200){
        //发送验证码
        if (![self.phoneNumTextField.text isEqualToString:@""]) {
            [HTTPManager changePasswordSMS:^(NSString *code, NSString *msg, NSString *data) {
                if (code.intValue == 200) {
                    
                    [self theCountdown];
                    
                    [XSInfoView showInfo:data onView:self.view];
                    
                }else{
                    //超过次数限制 代码：40603
                    [XSInfoView showInfo:msg onView:self.view];
                }

            } phoneNum:self.phoneNumTextField.text];
        }else{
            [XSInfoView showInfo:@"手机号不能为空" onView:self.view];
        }
    }else if (button.tag == 300){
        //确定
        if ([Helper isNotBlankString:self.phoneNumTextField.text] && [Helper isNotBlankString:self.codeTextField.text] && [Helper isNotBlankString:self.passwordTextField.text] &&[Helper isNotBlankString:self.conpasswordTextField.text]) {
            if ([self.passwordTextField.text isEqualToString:self.conpasswordTextField.text]) {
                [HTTPManager changePassword:^(NSString *code, NSString *msg, id result) {
                    if (code.intValue == 200) {
                        
                        [UserDefaultUtil saveValue:result forKey:USER_TOKEN];;//重新保存token

                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                        
                        [XSInfoView showInfo:msg onView:self.view];

                    }
                    
                } phoneNum:self.phoneNumTextField.text password:self.conpasswordTextField.text code:self.codeTextField.text];
            }else{
                [XSInfoView showInfo:@"两次输入的密码不一致" onView:self.view];
            }
        }else{
            [XSInfoView showInfo:@"请输入完整的信息" onView:self.view];
        }
    }
}

#pragma mark -
- (void)textFieldChanged:(UITextField *)textField{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    if (textField == _phoneNumTextField) {
        
        if ([Helper checkTelNumber:_phoneNumTextField.text] == NO) {
            alertView.message = @"请输入有效的手机号码~";
            _phoneNumTextField.text = nil;
            [alertView show];
            
        }
    }
    
//    if (textField == _authcodeTextField) {
//
//
//    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == _phoneNumTextField) {
        return NO;

    }
    return YES;
    
}

- (void)theCountdown{
    
    UIButton *button = [self.view viewWithTag:200];
    UIButton *conBtn = [self.view viewWithTag:300];
    [conBtn setBackgroundColor:Red_Color];
    [conBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    conBtn.enabled = YES;
    
    __block int timeout= 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                [button setTitle:@"获取验证码" forState:UIControlStateNormal];
                [button setBackgroundColor:Red_Color];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                cutBorder(button, 0.5f, @"#FF2400");
                button.enabled = YES;
//
//                [conBtn setBackgroundColor:Red_Color];
//                [conBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                conBtn.userInteractionEnabled = YES;
                
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                [UIView beginAnimations:nil context:nil];
                
                [UIView setAnimationDuration:0];
                
                [button setTitle:[NSString stringWithFormat:@"%@s后重新获取",strTime] forState:UIControlStateNormal];
                [button setBackgroundColor:BackgroundColor];
                [button setTitleColor:Light_TextColor forState:UIControlStateNormal];
                cutBorder(button, 0.5f, @"#F0F0F0");

                [UIView commitAnimations];
                
                button.enabled = NO;
                
                
//                [conBtn setBackgroundColor:BackgroundColor];
//                [conBtn setTitleColor:Light_TextColor forState:UIControlStateNormal];
//                conBtn.userInteractionEnabled = NO;

            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}


#pragma mark - lazyLoading
//手机号
- (UITextField *)phoneNumTextField{
    if (!_phoneNumTextField) {
        UIImageView *leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 13*SProportion_Height, 10*SProportion_Width, 14*SProportion_Height)];
        leftImage.image = [UIImage imageNamed:@"my_img_phone"];
        _phoneNumTextField = [[UITextField alloc] init];
        _phoneNumTextField.textColor = Dark_TextColor;
        _phoneNumTextField.backgroundColor = [UIColor whiteColor];
        _phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneNumTextField.font = font(15);
        _phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneNumTextField.text = [UserDefaultUtil valueForKey:USER_MOBILE];
//        _phoneNumTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入注册手机号" attributes:@{NSForegroundColorAttributeName: Light_TextColor}];
        [_phoneNumTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingDidEnd];
        _phoneNumTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 20)];
        _phoneNumTextField.leftViewMode = UITextFieldViewModeAlways;
        [_phoneNumTextField addSubview:leftImage];
        _phoneNumTextField.delegate = self;
        [self.view addSubview:_phoneNumTextField];
    }
    return _phoneNumTextField;
}
///验证码
- (UITextField *)codeTextField{
    if (!_codeTextField) {
        UIImageView *leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 13*SProportion_Height, 14*SProportion_Height, 14*SProportion_Height)];
        leftImage.image = [UIImage imageNamed:@"my_img_vercode"];
        _codeTextField = [[UITextField alloc] init];
        _codeTextField.textColor = Dark_TextColor;
        _codeTextField.backgroundColor = [UIColor whiteColor];
        _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTextField.font = font(15);
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName: Light_TextColor}];
        [_codeTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingDidEnd];
        _codeTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 20)];
        _codeTextField.leftViewMode = UITextFieldViewModeAlways;
        [_codeTextField addSubview:leftImage];
        [self.view addSubview:_codeTextField];
    }
    return _codeTextField;
}
///新密码
- (UITextField *)passwordTextField{
    if (!_passwordTextField) {
        UIImageView *leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 13*SProportion_Height, 12*SProportion_Width, 14*SProportion_Height)];
        leftImage.image = [UIImage imageNamed:@"my_img_locks"];
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.textColor = Dark_TextColor;
        _passwordTextField.backgroundColor = [UIColor whiteColor];
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextField.font = font(15);
        _passwordTextField.keyboardType = UIKeyboardTypeDefault;
        _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"新密码（6-16 位字符）" attributes:@{NSForegroundColorAttributeName: Light_TextColor}];
        [_passwordTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingDidEnd];
        _passwordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 20)];
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        [_passwordTextField addSubview:leftImage];
        [self.view addSubview:_passwordTextField];
    }
    return _passwordTextField;
}
///重复新密码
- (UITextField *)conpasswordTextField{
    if (!_conpasswordTextField) {
        UIImageView *leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 13*SProportion_Height, 12*SProportion_Width, 14*SProportion_Height)];
        leftImage.image = [UIImage imageNamed:@"my_img_locks"];
        _conpasswordTextField = [[UITextField alloc] init];
        _conpasswordTextField.textColor = Dark_TextColor;
        _conpasswordTextField.backgroundColor = [UIColor whiteColor];
        _conpasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _conpasswordTextField.font = font(15);
        _conpasswordTextField.keyboardType = UIKeyboardTypeDefault;
        _conpasswordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"确认新密码（6-16 位字符）" attributes:@{NSForegroundColorAttributeName: Light_TextColor}];
        [_conpasswordTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingDidEnd];
        _conpasswordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 20)];
        _conpasswordTextField.leftViewMode = UITextFieldViewModeAlways;
        [_conpasswordTextField addSubview:leftImage];
        [self.view addSubview:_conpasswordTextField];
    }
    return _conpasswordTextField;
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
