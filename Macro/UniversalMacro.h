//
//  UniversalMacro.h
//  niuniu
//
//  Created by 谷朝阳 on 2017/4/19.
//  Copyright © 2017年 谷朝阳. All rights reserved.
//

#ifndef UniversalMacro_h
#define UniversalMacro_h

#define CURRENT_VERSION @"1.0.2"

//弱引用
#define WeakSelf(type)  __weak typeof(type) weak##type = type;

//判断token是否为空
#define TOKEN_ISEMPTY [[UserDefaultUtil valueForKey:@"token"] isEqual:@""] || [UserDefaultUtil valueForKey:@"token"] == nil

//当前设备的ios版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//通知中心
#define KNotificationCenter [NSNotificationCenter defaultCenter]

//Appdelegate
#define APPDELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]

#define SProportion_Width ([UIScreen mainScreen].bounds.size.width/320.0f)

#define SProportion_Height ([UIScreen mainScreen].bounds.size.height/568.0f)

#define Screen_Width [UIScreen mainScreen].bounds.size.width

#define Screen_Height [UIScreen mainScreen].bounds.size.height

#define BackgroundColor [UIColor colorWithHexString:@"f0f0f0"] //背景色值

#define Green_Color [UIColor colorWithHexString:@"44B549"] //绿色

#define Blue_TextColor [UIColor colorWithHexString:@"5e8bf7"] //蓝色字体

#define Red_TextColor [UIColor colorWithHexString:@"ff6a57"] //红色字体

#define Dark_TextColor [UIColor colorWithHexString:@"484848"] //深色字体颜色

#define Light_TextColor [UIColor colorWithHexString:@"999999"] //浅色字体颜色

/**<
 字体大小
 */
#define font(num) [UIFont systemFontOfSize:num]

/**<
 颜色
 */
#define customColor(string) [UIColor colorWithHexString:string]

/**<
 设置本地图片
 */
#define image(name) [UIImage imageNamed:name]

/**<
 SD加载图片 传入自己、图片地址、本地图片名称
 */
#define setNetImage(self,urlStr,imgName) [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:imgName]];

/**<
 裁剪圆角
 */
#define cut(self,size) self.layer.masksToBounds = YES; self.layer.cornerRadius = size;

/**<
 设置边框颜色和宽度
 */
#define cutBorder(self,size,color) self.layer.borderWidth = size; self.layer.borderColor = [Helper colorWithHexString:color].CGColor;

/**<
 打客服电话
 */
#define CALL_PHONE [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",@"4008116717"]]];
/**<
 自定义号码打电话
 */
#define CUSTOM_CALL_PHONE(number) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",number]]];
/**<
 设置IQKeyboardManager
 */
#define KEYBOARDMANAGER IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];   keyboardManager.enable = YES;  keyboardManager.shouldResignOnTouchOutside = YES;  keyboardManager.shouldToolbarUsesTextFieldTintColor = YES;  keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews;  keyboardManager.enableAutoToolbar = YES;  keyboardManager.shouldShowTextFieldPlaceholder = NO;

#endif /* UniversalMacro_h */
