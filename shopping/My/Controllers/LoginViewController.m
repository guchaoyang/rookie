//
//  LoginViewController.m
//  shopping
//
//  Created by 谷朝阳 on 2018/1/2.
//  Copyright © 2018年 GCY. All rights reserved.
//

#import "LoginViewController.h"

#import "RegisterViewController.h"

#import "TTTAttributedLabel.h"

@interface LoginViewController ()<TTTAttributedLabelDelegate>

@property(nonatomic ,strong)TTTAttributedLabel *aLable;

@property(nonatomic ,strong)UITextField *phoneNumTextField;

@property(nonatomic ,strong)UITextField *passwordTextField;

@end

@implementation LoginViewController

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
    title.text = @"使用密码登录";
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
    [backBtn setImage:image(NAV_CANCELBTN_NAME) forState:UIControlStateNormal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = left;
    
}

- (void)layoutView{
    
    __weak typeof(self) weakSelf = self;//防止循环引用
    
    //输入框
    NSArray *textArr = @[@"账号",@"密码"];
    for (int i=0; i<2; i++) {
        //文字
        UILabel *label = [[UILabel alloc] init];
        label.text = textArr[i];
        label.textColor = Dark_TextColor;
        label.font = font(15);
        label.adjustsFontSizeToFitWidth = YES;
        [weakSelf.view addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view).mas_offset(15*SProportion_Width);
            make.top.equalTo(weakSelf.view).mas_offset(30*SProportion_Height + 45*SProportion_Height*i);
            make.size.mas_equalTo(CGSizeMake(40*SProportion_Width, 20*SProportion_Height));
        }];
        
        //分割线
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = BackgroundColor;
        [weakSelf.view addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label);
            make.top.equalTo(weakSelf.view).mas_offset(55*SProportion_Height +45*SProportion_Height*i);
            make.size.mas_equalTo(CGSizeMake(290*SProportion_Width, SProportion_Height));
        }];
    }
    
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).mas_offset(50*SProportion_Width);
        make.top.equalTo(weakSelf.view).mas_offset(30*SProportion_Height);
        make.size.mas_equalTo(CGSizeMake(235*SProportion_Width, 20*SProportion_Height));
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).mas_offset(50*SProportion_Width);
        make.top.equalTo(weakSelf.view).mas_offset(75*SProportion_Height);
        make.size.mas_equalTo(CGSizeMake(235*SProportion_Width, 20*SProportion_Height));
    }];

    //登录button
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cut(loginButton, 5);
    loginButton.tag = 200;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = font(17);
    [loginButton setBackgroundColor:BackgroundColor];
    [loginButton setTitleColor:Light_TextColor forState:UIControlStateNormal];
    loginButton.enabled = NO;
    [loginButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [weakSelf.view addSubview:loginButton];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).mas_offset(15*SProportion_Width);
        make.top.equalTo(self.passwordTextField.mas_bottom).mas_offset(30*SProportion_Height);
        make.size.mas_equalTo(CGSizeMake(290*SProportion_Width, 35*SProportion_Height));
    }];
    
    //手机快速登录 、忘记密码
//    NSArray *btnArr = @[@"手机快速登录",@"忘记密码"];
//    for (int i=0; i<btnArr.count; i++) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.tag = 300+i;
//        [button setBackgroundColor:[UIColor whiteColor]];
//        [button setTitle:btnArr[i] forState:UIControlStateNormal];
//        [button setTitleColor:customColor(@"#666666") forState:UIControlStateNormal];
//        button.titleLabel.font = font(14);
//        button.titleLabel.adjustsFontSizeToFitWidth = YES;
//        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [weakSelf.view addSubview:button];
//
//        if (i==0) {
//            [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(loginButton);
//                make.top.equalTo(loginButton.mas_bottom).mas_offset(20*SProportion_Height);
//                make.size.mas_equalTo(CGSizeMake(100*SProportion_Width, 15*SProportion_Height));
//                [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft] ;
//            }];
//        }else{
//            [button mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(weakSelf.view).mas_offset(-15*SProportion_Width);
//                make.top.equalTo(loginButton.mas_bottom).mas_offset(20*SProportion_Height);
//                make.size.mas_equalTo(CGSizeMake(70*SProportion_Width, 15*SProportion_Height));
//            }];
//            [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight] ;
//        }
//    }
    
    //富文本信息
//    NSString *text = @"登录即代表您已经同意云豆街隐私政策";
//    [self.aLable setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
//
//        NSRange allRange = [[mutableAttributedString string] rangeOfString:text options:NSCaseInsensitiveSearch];
//
//        //字体
//        [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:font(14) range:allRange];
//
//        return mutableAttributedString;
//
//    }];
//
//    NSRange linkTextRange = [text rangeOfString:@"云豆街隐私政策" options:NSCaseInsensitiveSearch];
//    [self.aLable addLinkToURL:[NSURL URLWithString:@"http://y.qq.com/portal/song/003aAYrm3GE0Ac.html"]
//                    withRange:linkTextRange];
    
    NSString *text = @"遇到问题？您可以联系客服";
    [self.aLable setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        //        NSRange linkRange = [[mutableAttributedString string] rangeOfString:@"联系客服" options:NSCaseInsensitiveSearch];
        NSRange allRange = [[mutableAttributedString string] rangeOfString:text options:NSCaseInsensitiveSearch];
        
        //字体
        [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:font(14) range:allRange];
        //颜色
        //        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:BackgroundColor range:linkRange];
        //下划线
        //        [mutableAttributedString addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:kCTUnderlineStyleSingle]  range:linkRange];
        
        return mutableAttributedString;
        
    }];
    
    NSRange linkTextRange = [text rangeOfString:@"联系客服" options:NSCaseInsensitiveSearch];
    [self.aLable addLinkToURL:[NSURL URLWithString:@"http://y.qq.com/portal/song/003aAYrm3GE0Ac.html"]
                    withRange:linkTextRange];
}


- (void)buttonClick:(UIButton *)button{
    if (button.tag == 100) {
        //返回
        [self.navigationController popViewControllerAnimated:YES];
    }else if (button.tag == 200){
        //登录
        if ([Helper checkTelNumber:_phoneNumTextField.text] == NO) {
            
            [XSInfoView showInfo:@"请输入有效的手机号码~" onView:self.view];

        }else{
            [HTTPManager accountPasswordLoginRequest:^(NSString *code, NSString *msg, id result) {
                if (code.intValue == 200 || code.intValue == 201) {
                    
                    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                          self.phoneNumTextField.text, @"mobile", nil];
                    [MobClick event:@"password_Login" attributes:dict];//账号统计
                    
                    [UserDefaultUtil saveValue:result[@"token"] forKey:USER_TOKEN];//储存token
                    NSDictionary *userDic = [result objectForKey:@"user"];//用户信息
                    
                    [UserDefaultUtil saveValue:userDic[@"mobile"] forKey:USER_MOBILE];//手机号
                    [UserDefaultUtil saveBoolValue:[userDic[@"proxy"] boolValue] forKey:IS_PARTNER];//用户是否是合伙人
                    [UserDefaultUtil saveValue:userDic[@"userId"] forKey:USER_ID];//用户ID
                    [UserDefaultUtil saveValue:userDic[@"cost"] forKey:USER_COST];//现金
                    [UserDefaultUtil saveValue:userDic[@"integral"] forKey:USER_INTERGRAL];//金币
                    [UserDefaultUtil saveValue:userDic[@"nickName"] forKey:USER_NICKNAME];//昵称
                    [UserDefaultUtil saveValue:userDic[@"photo"] forKey:USER_HEADER];//头像地址
                    [UserDefaultUtil saveValue:userDic[@"sex"] forKey:USER_SEX];//性别
                    [UserDefaultUtil saveValue:userDic[@"qq"] forKey:USER_QQ];//QQ
                    
                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                    
                    //发送友盟推送设备号
                    NSString *deviceToken = [UserDefaultUtil valueForKey:UMENGPUSH_DIVICETOKEN];
                    if (deviceToken != nil) {
                        [HTTPManager postUMengPushDeviceToken:^(NSString *code, NSString *msg, id result) {
                            
                        } deviceToken:deviceToken];
                    }
                    
                }else{
                    [XSInfoView showInfo:msg onView:self.view];
                }
            } phoneNum:self.phoneNumTextField.text password:self.passwordTextField.text];
        }
        
    }else if (button.tag == 300){
        //手机快速登录
//        RegisterViewController *rvc = [[RegisterViewController alloc] init];
//        [self.navigationController pushViewController:rvc animated:YES];
    }else if (button.tag == 301){
        //忘记密码
        
    }
}

#pragma mark - TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    NSLog(@"这里是联系客服");
    //    [[UIApplication sharedApplication] openURL:url];
    CUSTOM_CALL_PHONE(@"4006860998");
}

- (void)textFieldChanged:(UITextField *)textField{
    
    if (textField == _passwordTextField) {
        UIButton *loginBtn = [self.view viewWithTag:200];
        if (![_phoneNumTextField.text isEqual:@""] && ![_passwordTextField.text isEqual:@""]) {
            loginBtn.enabled = YES;
            [loginBtn setBackgroundColor:Red_Color];
            [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            loginBtn.enabled = NO;
            [loginBtn setBackgroundColor:BackgroundColor];
            [loginBtn setTitleColor:Light_TextColor forState:UIControlStateNormal];
        }
        
    }
}

#pragma mark - lazyLoading
- (UITextField *)phoneNumTextField{
    if (!_phoneNumTextField) {
        _phoneNumTextField = [[UITextField alloc] init];
        _phoneNumTextField.backgroundColor = [UIColor whiteColor];
        _phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneNumTextField.font = font(15);
        _phoneNumTextField.keyboardType = UIKeyboardTypeDefault;
        _phoneNumTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"用户名/邮箱/手机号" attributes:@{NSForegroundColorAttributeName: Light_TextColor}];
        [_phoneNumTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingDidEnd];
        _phoneNumTextField.leftViewMode = UITextFieldViewModeAlways;
        [self.view addSubview:_phoneNumTextField];
    }
    return _phoneNumTextField;
}

- (UITextField *)passwordTextField{
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.backgroundColor = [UIColor whiteColor];
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextField.font = font(15);
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.keyboardType = UIKeyboardTypeDefault;
        _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: Light_TextColor}];
        [_passwordTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        [self.view addSubview:_passwordTextField];
    }
    return _passwordTextField;
}

- (TTTAttributedLabel *)aLable
{
    if (!_aLable)
    {
//        _aLable = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, 480*SProportion_Height, Screen_Width, 15*SProportion_Height)];
        _aLable = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(20*SProportion_Width, 185*SProportion_Height, 200*SProportion_Width, 15*SProportion_Height)];
        _aLable.textColor = Light_TextColor;
        _aLable.lineBreakMode = NSLineBreakByWordWrapping;
        _aLable.adjustsFontSizeToFitWidth = YES;
//        _aLable.numberOfLines = 0;
        _aLable.delegate = self;
        //要放在`text`, with either `setText:` or `setText:afterInheritingLabelAttributesAndConfiguringWithBlock:前面才有效
        _aLable.enabledTextCheckingTypes = NSTextCheckingTypePhoneNumber|NSTextCheckingTypeAddress|NSTextCheckingTypeLink;
        //链接正常状态文本属性
        _aLable.linkAttributes = @{NSForegroundColorAttributeName:Dark_TextColor,NSUnderlineStyleAttributeName:@(1)};
        //链接高亮状态文本属性
        _aLable.activeLinkAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSUnderlineStyleAttributeName:@(1)};
        _aLable.hidden = YES;
        [self.view addSubview:_aLable];
    }
    return _aLable;
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
