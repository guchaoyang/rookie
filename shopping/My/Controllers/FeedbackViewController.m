//
//  FeedbackViewController.m
//  shopping
//
//  Created by 谷朝阳 on 2018/1/10.
//  Copyright © 2018年 GCY. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()<UITextViewDelegate>

@property(nonatomic, strong)UITextView *textView;

@end

@implementation FeedbackViewController

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
    title.text = @"意见反馈";
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

    //输入框
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20*SProportion_Width);
        make.top.mas_equalTo(20*SProportion_Height);
        make.size.mas_equalTo(CGSizeMake(280*SProportion_Width, 130*SProportion_Height));
    }];
    
    //提交button
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cut(submitButton, 5);
    submitButton.tag = 200;
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    submitButton.titleLabel.font = font(17);
    [submitButton setBackgroundColor:Red_Color];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [weakSelf.view addSubview:submitButton];
    
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.textView);
        make.top.equalTo(self.textView.mas_bottom).mas_offset(10*SProportion_Height);
        make.height.mas_equalTo(30*SProportion_Height);
    }];
    
    //提示文字
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    cut(button, 5);
    cutBorder(button, 0.5f, @"#CCCCCC");
    [button setTitle:@"如您在使用过程中遇到的bug或问题以及好的建议可以反馈给我们" forState: UIControlStateNormal];
    [button setTitleColor:customColor(@"#666666") forState:UIControlStateNormal];
    [button setBackgroundColor:customColor(@"#FAFAFA")];
    button.titleLabel.font = font(15);
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    [button setContentEdgeInsets:UIEdgeInsetsMake(15, 15, 20, 15)];
    [weakSelf.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.textView);
        make.top.equalTo(submitButton.mas_bottom).mas_offset(10*SProportion_Height);
        make.height.mas_equalTo(60*SProportion_Height);
    }];
    
#pragma mark - 自定义提示文字请求
    [HTTPManager getFeedbackCusText:^(NSString *code, NSString *msg, id result) {
        if (code.intValue == 200) {
            [button setTitle:result forState: UIControlStateNormal];
            
            CGSize size = [Helper calculateTheSizeOfTheText:result :15 :280*SProportion_Width];
            
            [button mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.textView);
                make.top.equalTo(submitButton.mas_bottom).mas_offset(10*SProportion_Height);
                make.height.mas_equalTo(size.height + 20*SProportion_Height);
            }];
        }else{
            
            [XSInfoView showInfo:msg onView:self.view];
        }
        
    }];
}

- (void)buttonClick:(UIButton *)button{
    if (button.tag == 100) {
        //返回
        [self.navigationController popViewControllerAnimated:YES];
    }else if (button.tag == 200){
        //提交
        if (![_textView.text isEqualToString:@"输入反馈或建议内容"] && [Helper isNotBlankString:_textView.text]) {
            //限制200个字符
            if (_textView.text.length <= 200) {
                [HTTPManager postFeedbackInfo:^(NSString *code, NSString *msg, id result) {
                    if (code.intValue == 200) {
                        
                        _textView.text = @"输入反馈或建议内容";
                        
                        [_textView resignFirstResponder];
                        
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"提交成功" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            [self.navigationController popViewControllerAnimated:YES];
                        }];
                        [alertController addAction:okAction];
                        [self presentViewController:alertController animated:YES completion:nil];
                        
                    }else{
                        
                        [XSInfoView showInfo:msg onView:self.view];
                    }
                } content:_textView.text];
            }else{
                [XSInfoView showInfo:@"内容不能超过200个字符" onView:self.view];
            }
            
        }else{
            [XSInfoView showInfo:@"反馈不能为空" onView:self.view];
        }
    }
}


#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"输入反馈或建议内容";
        textView.textColor = Light_TextColor;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"输入反馈或建议内容"]){
        textView.text = @"";
        textView.textColor = Light_TextColor;
    }
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        cut(_textView, 6);
        cutBorder(_textView, 0.5f, @"#CCCCCC");
        _textView.textColor = Light_TextColor;
        _textView.backgroundColor = customColor(@"#FAFAFA");
        _textView.font = font(16);
        _textView.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15);
        _textView.text = @"输入反馈或建议内容";
        _textView.delegate = self;
        [self.view addSubview:_textView];
    }
    return _textView;
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
