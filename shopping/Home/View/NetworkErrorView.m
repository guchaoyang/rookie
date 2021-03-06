//
//  NetworkErrorView.m
//  shopping
//
//  Created by 成都牛牛优选信息科技有限公司 on 2018/1/23.
//  Copyright © 2018年 成都牛牛优选信息科技有限公司. All rights reserved.
//

#import "NetworkErrorView.h"

@interface NetworkErrorView ()

@property (nonatomic, weak) UIImageView *iconImageView;

@property (nonatomic, weak) UILabel *nameLabel;

@end

@implementation NetworkErrorView

+ (NetworkErrorView *)shared{
    
    static dispatch_once_t predicate;
    
    static NetworkErrorView *objc;
    
    dispatch_once(&predicate, ^{
        
        objc = [[NetworkErrorView alloc] init];
        
    });
    
    return objc;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        NSLog(@"网络错误视图创建");
        
        self.backgroundColor = [UIColor whiteColor];
        //上面底层底层黑色背景
        UIButton *blackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [blackBtn setBackgroundColor:Light_TextColor];
//        blackBtn.alpha = 0.4f;
        blackBtn.frame = CGRectMake(0, 0, Screen_Width, 30*SProportion_Height);
        [blackBtn addTarget:self action:@selector(goSystemSet) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:blackBtn];
        
        //上面小的wifi图标
        UIImageView *topWifiLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10*SProportion_Width, 8.5f*SProportion_Height, 13*SProportion_Height, 13*SProportion_Height)];
        topWifiLogo.image = image(@"home_img_topWifiLogo");
        [self addSubview:topWifiLogo];
        
        UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(35*SProportion_Width, 5*SProportion_Height, 300, 20*SProportion_Height)];
        topLabel.textColor = [UIColor whiteColor];
        topLabel.text = @"网络请求失败，请检查您的网络设置";
        topLabel.font = font(13);
        [self addSubview:topLabel];
        
        //上右侧箭头
        UIImageView *rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(295*SProportion_Width, 8*SProportion_Height, 7*SProportion_Width, 14*SProportion_Height)];
        rightArrow.image = image(@"home_img_netwk_rArow");
        [self addSubview:rightArrow];
        
        //下面小的wifi图标
        UIImageView *bottomWifiLogo = [[UIImageView alloc] initWithFrame:CGRectMake(120*SProportion_Width, 130*SProportion_Height, 80*SProportion_Width, 63*SProportion_Height)];
        bottomWifiLogo.image = image(@"home_img_bottomWifiLogo");
        [self addSubview:bottomWifiLogo];
        
        //请求失败text
        UILabel *failureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 220*SProportion_Height, Screen_Width, 20*SProportion_Height)];
        failureLabel.textColor = customColor(@"666666");
        failureLabel.text = @"网络请求失败";
        failureLabel.textAlignment = NSTextAlignmentCenter;
        failureLabel.font = font(17);
        [self addSubview:failureLabel];
        
        //重新加载text
        UILabel *reloadLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 245*SProportion_Height, Screen_Width, 30*SProportion_Height)];
        reloadLabel.textColor = Light_TextColor;
        reloadLabel.text = @"请检查您的网络\n重新加载吧";
        reloadLabel.textAlignment = NSTextAlignmentCenter;
        reloadLabel.font = font(14);
        reloadLabel.numberOfLines = 0;
        reloadLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:reloadLabel];
        
        //重新加载按钮
        UIButton *relosdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cut(relosdBtn, 5);
        cutBorder(relosdBtn, 0.5f, @"999999");
        [relosdBtn setBackgroundColor:[UIColor whiteColor]];
        relosdBtn.frame = CGRectMake(125*SProportion_Width, 285*SProportion_Height, 70*SProportion_Width, 25*SProportion_Height);
        [relosdBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        relosdBtn.titleLabel.font = font(15);
        [relosdBtn setTitleColor:Dark_TextColor forState:UIControlStateNormal];
        [relosdBtn addTarget:self action:@selector(relosdBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:relosdBtn];
    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];

    self.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
}

- (void)relosdBtnClick{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(reloadNetwork)]) {
        [self.delegate reloadNetwork];
    }else{
        NSLog(@"无网络界面设置代理失败");
    }
}

- (void)goSystemSet{
    
//    NSString *urlString = @"App-Prefs:root=MOBILE_DATA_SETTINGS_ID";
//    if (@available(iOS 10.0, *)) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
//    } else {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
//    }
    [XSInfoView showInfo:@"请打开->设置->蜂窝移动网络 或者 ->无线局域网 检查您的网络" onView:self.window];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
