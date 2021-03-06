//
//  ShareEarnViewController.m
//  shopping
//
//  Created by 谷朝阳 on 2018/2/8.
//  Copyright © 2018年 GCY. All rights reserved.
//

#import "ShareEarnViewController.h"
#import <UShareUI/UShareUI.h>

@interface ShareEarnViewController ()

@property(nonatomic, strong)UITextView *textView;

@property (nonatomic, assign) UMSocialPlatformType platform;

@end

@implementation ShareEarnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self createNavigationItem];
    
    [self layoutView];
}

- (void)createNavigationItem{
    
    self.navigationItem.title = @"瓦萨迪卡家用电动拖把全自动智能擦地机UTF8-999";
    
    //导航返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    //图片左移
    [backBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:image(NAV_WHITE_BACKBTN_NAME) forState:UIControlStateNormal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = left;
    
}

- (void)layoutView{
    
    __weak typeof(self) weakSelf = self;//防止循环引用
    //图片
    UIImageView *goodsPic = [[UIImageView alloc] init];
    setNetImage(goodsPic, @"https://gd3.alicdn.com/imgextra/i3/840822831/TB23MCiao3iyKJjy1zeXXbxZFXa_!!840822831.jpg_300x300.jpg", @"");
    [weakSelf.view addSubview:goodsPic];
    
    [goodsPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(85*SProportion_Width);
        make.top.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(150*SProportion_Width, 150*SProportion_Width));
    }];
    //
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.text = @"编辑分享文案";
    textLabel.textColor = customColor(@"#333333");
    textLabel.font = font(14);
    [weakSelf.view addSubview:textLabel];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20*SProportion_Width);
        make.top.equalTo(goodsPic.mas_bottom).mas_offset(20*SProportion_Height);
        make.size.mas_equalTo(CGSizeMake(150*SProportion_Width, 20*SProportion_Height));
    }];
    
    //分享文字文本框
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textLabel);
        make.top.equalTo(textLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(280*SProportion_Width, 130*SProportion_Height));
    }];
    
    //复制文案button
    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cut(copyButton, 12.5f*SProportion_Height);
    copyButton.tag = 200;
    [copyButton setTitle:@"复制分享文案" forState:UIControlStateNormal];
    copyButton.titleLabel.font = font(13);
    [copyButton setBackgroundColor:Red_Color];
    [copyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [copyButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [weakSelf.view addSubview:copyButton];
    
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).mas_offset(115*SProportion_Width);
        make.top.equalTo(self.textView.mas_bottom).mas_offset(5*SProportion_Height);
        make.size.mas_equalTo(CGSizeMake(90*SProportion_Width, 25*SProportion_Height));
    }];
    
    //
    UILabel *bottomTextLabel = [[UILabel alloc] init];
    bottomTextLabel.text = @"注意：编辑分享文案后，点击复制分享文案按钮，然后粘贴到分享平台，请不要更改淘口令！";
    bottomTextLabel.textColor = customColor(@"#333333");
    bottomTextLabel.font = font(13);
    bottomTextLabel.numberOfLines = 0;
    bottomTextLabel.adjustsFontSizeToFitWidth = YES;
    bottomTextLabel.textAlignment = NSTextAlignmentCenter;
    [weakSelf.view addSubview:bottomTextLabel];
    
    [bottomTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textLabel);
        make.top.equalTo(copyButton.mas_bottom).mas_offset(5*SProportion_Height);
        make.size.mas_equalTo(CGSizeMake(280*SProportion_Width, 30*SProportion_Height));
    }];
    
    //图文分享到
    UIButton *recommendLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    [recommendLabel setTitle:@"图文分享到" forState:UIControlStateNormal];
    [recommendLabel setTitleColor:customColor(@"#333333") forState:UIControlStateNormal];
    recommendLabel.titleLabel.font = font(13);
    [weakSelf.view addSubview:recommendLabel];
    
    [recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(bottomTextLabel.mas_bottom).mas_offset(5*SProportion_Height);
        make.height.mas_equalTo(20*SProportion_Height);
    }];
    //渐变横条图片
    NSArray *sipesArr = @[@"home_img_gadtSipes_lft", @"home_img_gadtSipes_riht"];
    for (int i = 0 ; i < 2; i ++){
        UIImageView *leftHorImage = [[UIImageView alloc] initWithFrame:CGRectMake(25*SProportion_Width + 180*SProportion_Width*i, 10*SProportion_Height, 90*SProportion_Width, 1)];
        leftHorImage.image = image(sipesArr[i]);
        [recommendLabel addSubview:leftHorImage];
    }
    
    //创建分享项
    NSArray *btnTitles = @[@"微信",@"朋友圈",@"QQ",@"空间"];
    NSArray *btnImages = @[@"img_share_wechat",@"img_share_moments",@"img_share_qqFriends",@"img_share_Qzone"];
    for (int i=0; i<btnTitles.count; i++) {
        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        shareButton.tag = 300+i;
        [shareButton setTitle:btnTitles[i] forState:UIControlStateNormal];
        [shareButton setImage:image(btnImages[i]) forState:UIControlStateNormal];
//        allButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        shareButton.titleLabel.font = font(13);
        [shareButton setBackgroundColor:[UIColor clearColor]];
        [shareButton setTitleColor:customColor(@"#666666") forState:UIControlStateNormal];
        [shareButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [weakSelf.view addSubview:shareButton];
        
        [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Screen_Width/4*i);
            make.top.equalTo(recommendLabel.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(Screen_Width/4, 60*SProportion_Height));
        }];
        
        [shareButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:15];
    }
}

- (void)buttonClick:(UIButton *)button{
    if (button.tag == 200) {
        //复制文案
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = _textView.text;
        [XSInfoView showInfo:@"分享文案已复制到粘贴板" onView:self.view];
        return;
    }else if (button.tag == 300){
        //微信
        self.platform = UMSocialPlatformType_WechatSession;
    }else if (button.tag == 301){
        //朋友圈
        self.platform = UMSocialPlatformType_WechatTimeLine;
    }else if (button.tag == 302){
        //QQ
        self.platform = UMSocialPlatformType_QQ;
    }else if (button.tag == 303){
        //空间
        self.platform = UMSocialPlatformType_Qzone;
    }
    
    //只分享网络图片（暂定）
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = @"https://img.alicdn.com/imgextra/i1/864731581/TB2eFAXpbsTMeJjSsziXXcdwXXa_!!864731581.jpg_300x300.jpg";
    [shareObject setShareImage:@"https://img.alicdn.com/imgextra/i1/864731581/TB2eFAXpbsTMeJjSsziXXcdwXXa_!!864731581.jpg_300x300.jpg"];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:self.platform messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"Share succeed"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"Share fail"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)backClick{
    //返回
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        cut(_textView, 6);
        cutBorder(_textView, 0.5f, @"#CCCCCC");
        _textView.backgroundColor = customColor(@"#FFFFFF");
        _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 17.5f, 10);
        _textView.text = @"【我剁手都要买的宝贝（Joyoung/九阳 F-40T9预约铁釜电饭煲4L智能家用电饭锅IH电磁加热），快来和我一起瓜分红I包】\n【原价】1599.00\n【券后价】1299\n【下单链接】 http://www.dwntme.com/h.ZYpUIht \n【淘口令】￥Lbce0NGGNqk￥\n复制这条消息打开【手机淘宝】即可查看";
//        _textView.adjustsFontForContentSizeCategory = YES;
//        _textView.delegate = self;
        //设置行距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 4;
        NSDictionary *attributes = @{
                                     NSFontAttributeName:font(13),
                                     NSParagraphStyleAttributeName:paragraphStyle,
                                     NSForegroundColorAttributeName:customColor(@"#333333")
                                     };
        _textView.attributedText = [[NSAttributedString alloc] initWithString:_textView.text attributes:attributes];
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
