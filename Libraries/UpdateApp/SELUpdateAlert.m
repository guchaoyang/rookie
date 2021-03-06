//
//  SELUpdateAlert.m
//  SelUpdateAlert
//
//  Created by zhuku on 2018/2/7.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SELUpdateAlert.h"

#define DEFAULT_MAX_HEIGHT SCREEN_HEIGHT/3*2

/** RGB */
#define SELColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/** 屏幕高度 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//屏幕适配
/**当前设备对应375的比例*/
#define Ratio_375 (SCREEN_WIDTH/375.0)
/**转换成当前比例的数*/
#define Ratio(x) ((int)((x) * Ratio_375))

@interface SELUpdateAlert()

/** 版本号 */
@property (nonatomic, copy) NSString *version;
/** 版本更新内容 */
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *updateUrlStr;

@end

@implementation SELUpdateAlert

/**
 添加版本更新提示

 @param version 版本号
 @param descriptions 版本更新内容（数组）
 
 descriptions 格式如 @[@"1.xxxxxx",@"2.xxxxxx"]
 */
+ (void)showUpdateAlertWithVersion:(NSString *)version Descriptions:(NSArray *)descriptions update:(NSString *)updateUrl
{
    if (!descriptions || descriptions.count == 0) {
        return;
    }
    
    //数组转换字符串，动态添加换行符\n
    NSString *description = @"";
    for (NSInteger i = 0;  i < descriptions.count; ++i) {
        id desc = descriptions[i];
        if (![desc isKindOfClass:[NSString class]]) {
            return;
        }
        description = [description stringByAppendingString:desc];
        if (i != descriptions.count-1) {
            description = [description stringByAppendingString:@"\n"];
        }
    }
    NSLog(@"====%@",description);
    SELUpdateAlert *updateAlert = [[SELUpdateAlert alloc]initVersion:version description:description update:updateUrl];
    [[UIApplication sharedApplication].delegate.window addSubview:updateAlert];
}

/**
 添加版本更新提示

 @param version 版本号
 @param description 版本更新内容（字符串）
 
description 格式如 @"1.xxxxxx\n2.xxxxxx"
 */
+ (void)showUpdateAlertWithVersion:(NSString *)version Description:(NSString *)description update:(NSString *)updateUrl
{
    SELUpdateAlert *updateAlert = [[SELUpdateAlert alloc]initVersion:version description:description update:updateUrl];
    [[UIApplication sharedApplication].delegate.window addSubview:updateAlert];
}

- (instancetype)initVersion:(NSString *)version description:(NSString *)description update:(NSString *)updateUrl
{
    self = [super init];
    if (self) {
        self.version = version;
        self.desc = description;
        self.updateUrlStr = updateUrl;
        [self _setupUI];
    }
    return self;
}

- (void)_setupUI
{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3/1.0];
    
    //获取更新内容高度
    CGFloat descHeight = [self _sizeofString:self.desc font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(self.frame.size.width - Ratio(80) - Ratio(56), 1000)].height;
    
    //bgView实际高度
    CGFloat realHeight = descHeight + Ratio(260);
    
    //bgView最大高度
    CGFloat maxHeight = DEFAULT_MAX_HEIGHT;
    //更新内容可否滑动显示
    BOOL scrollEnabled = NO;
    
    //重置bgView最大高度 设置更新内容可否滑动显示
    if (realHeight > DEFAULT_MAX_HEIGHT) {
        scrollEnabled = YES;
        descHeight = DEFAULT_MAX_HEIGHT - Ratio(260);
    }else
    {
        maxHeight = realHeight;
    }
    
    //backgroundView
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.userInteractionEnabled = YES;
    bgView.image = image(@"img_v_update_bg");
    bgView.center = self.center;
    bgView.bounds = CGRectMake(0, 0, self.frame.size.width - Ratio(70), maxHeight+Ratio(10));
    [self addSubview:bgView];
    
    //字图片
    UIImageView *titleView = [[UIImageView alloc]init];
    titleView.image = image(@"img_v_update_title");
//    titleView.center = self.center;
    titleView.frame = CGRectMake(Ratio(85), Ratio(40), Ratio(140), Ratio(22));
    [bgView addSubview:titleView];
    
    //添加更新提示
//    UIView *updateView = [[UIView alloc]initWithFrame:CGRectMake(Ratio(20), Ratio(18), bgView.frame.size.width - Ratio(40), maxHeight)];
//    updateView.backgroundColor = [UIColor yellowColor];
//    updateView.layer.masksToBounds = YES;
//    updateView.layer.cornerRadius = 4.0f;
//    [bgView addSubview:updateView];
    
    //20+166+10+28+10+descHeight+20+40+20 = 314+descHeight 内部元素高度计算bgView高度
//    UIImageView *updateIcon = [[UIImageView alloc]initWithFrame:CGRectMake((updateView.frame.size.width - Ratio(178))/2, Ratio(20), Ratio(178), Ratio(166))];
//    updateIcon.image = [UIImage imageNamed:@"VersionUpdate_Icon"];
//    [updateView addSubview:updateIcon];
    
    //版本号
    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(Ratio(25), Ratio(145), bgView.frame.size.width, Ratio(28))];
    versionLabel.textColor = customColor(@"#333333");
    versionLabel.font = [UIFont systemFontOfSize:16];
//    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.text = [NSString stringWithFormat:@"V%@ 更新说明：",self.version];
    [bgView addSubview:versionLabel];
    
    //更新内容
    UITextView *descTextView = [[UITextView alloc]initWithFrame:CGRectMake(Ratio(28), Ratio(10) + CGRectGetMaxY(versionLabel.frame), bgView.frame.size.width - Ratio(56), descHeight)];
    descTextView.font = [UIFont systemFontOfSize:14];
    descTextView.textColor = customColor(@"#666666");
    descTextView.textContainer.lineFragmentPadding = 0;
    descTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    descTextView.text = self.desc;
    descTextView.editable = NO;
    descTextView.selectable = NO;
    descTextView.scrollEnabled = scrollEnabled;
    descTextView.showsVerticalScrollIndicator = scrollEnabled;
    descTextView.showsHorizontalScrollIndicator = NO;
    [bgView addSubview:descTextView];
    
    if (scrollEnabled) {
        //若显示滑动条，提示可以有滑动条
        [descTextView flashScrollIndicators];
    }
    
    //更新按钮
    UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    updateButton.backgroundColor = customColor(@"#ff5f3a");
    updateButton.frame = CGRectMake(Ratio(180), CGRectGetMaxY(descTextView.frame) + Ratio(40), Ratio(90), Ratio(35));
    updateButton.titleLabel.font = font(15);
    updateButton.clipsToBounds = YES;
    updateButton.layer.cornerRadius = Ratio(17.5f);
    [updateButton addTarget:self action:@selector(updateVersion) forControlEvents:UIControlEventTouchUpInside];
    [updateButton setTitle:@"立即更新" forState:UIControlStateNormal];
    [updateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bgView addSubview:updateButton];
    
    //取消按钮
//    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    cancelButton.center = CGPointMake(CGRectGetMaxX(updateView.frame), CGRectGetMinY(updateView.frame));
//    cancelButton.bounds = CGRectMake(0, 0, Ratio(36), Ratio(36));
//    [cancelButton setImage:[[UIImage imageNamed:@"VersionUpdate_Cancel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:cancelButton];
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.backgroundColor = customColor(@"#e5e5e5");
    [cancelButton setTitleColor:customColor(@"#999999") forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(Ratio(30), CGRectGetMaxY(descTextView.frame) + Ratio(40), Ratio(90), Ratio(35));
    cancelButton.titleLabel.font = font(15);
    cancelButton.clipsToBounds = YES;
    cancelButton.layer.cornerRadius = Ratio(17.5f);
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitle:@"残忍拒绝" forState:UIControlStateNormal];
    [bgView addSubview:cancelButton];
    
    //横线
    UIView *horLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(descTextView.frame) + Ratio(25), bgView.frame.size.width, 1)];
    horLine.backgroundColor = BackgroundColor;
    [bgView addSubview:horLine];
    
    //竖线
    UIView *verLine = [[UIView alloc]initWithFrame:CGRectMake(bgView.frame.size.width/2, CGRectGetMaxY(descTextView.frame) + Ratio(25), 1, Ratio(60))];
    verLine.backgroundColor = BackgroundColor;
    [bgView addSubview:verLine];
    
    //显示更新
    [self showWithAlert:bgView];
}

/** 更新按钮点击事件 跳转AppStore更新 */
- (void)updateVersion
{
    NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@", _updateUrlStr];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

/** 取消按钮点击事件 */
- (void)cancelAction
{
    BOOL isMandatory = [UserDefaultUtil boolValueForKey:IS_MANDATORY];
    if (isMandatory == false) {
        //非强制更新
        [self dismissAlert];
    }else{
        //强制更新
        [XSInfoView showInfo:@"当前版本如果不更新会影响您的正常使用~\n请务必到应用商店更新后使用" onView:self.window];
    }
    
}

/**
 添加Alert入场动画
 @param alert 添加动画的View
 */
- (void)showWithAlert:(UIView*)alert{
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.6;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [alert.layer addAnimation:animation forKey:nil];
}


/** 添加Alert出场动画 */
- (void)dismissAlert{
    
    [UIView animateWithDuration:0.6 animations:^{
        self.transform = (CGAffineTransformMakeScale(1.5, 1.5));
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
    
}

/**
 计算字符串高度
 @param string 字符串
 @param font 字体大小
 @param maxSize 最大Size
 @return 计算得到的Size
 */
- (CGSize)_sizeofString:(NSString *)string font:(UIFont *)font maxSize:(CGSize)maxSize
{
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
}




@end
