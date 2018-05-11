//
//  Helper.h
//  niuniu
//
//  Created by 谷朝阳 on 2017/4/21.
//  Copyright © 2017年 谷朝阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

/**
 * 单例初始化方法
 * @param
 * @param
 * @return 返回Helper对象
 */
+ (Helper *)sharedHelper;


/**
 适用于一个字符串中有两种颜色的 并且字体大小不一样的
 @param lable Lable
 @param titleString 内容
 @param textFont 设置需要的字体大小
 @param fontRang 字体大小的位置
 @param textColor 字体颜色
 @param range 字体颜色的位置
 */
+ (void)setRichText:(UILabel *)lable titleString:(NSString *)titleString textFont:(UIFont *)textFont fontRang:(NSRange)fontRang textColor:(UIColor *)textColor colorRang:(NSRange)range;

/**
 * 动态计算文字的大小
 *
 */
+ (CGSize)calculateTheSizeOfTheText:(NSString *)text :(CGFloat)fontSize;

/**
 * MD5加密32位小写
 *
 */
+ (NSString *)md532BitLower:(NSString *)str;

/**
 * 3DES加密
 *
 */
+(NSString *)DES3StringFromText:(NSString *)text;


/**
 * 获取当前的时间戳
 *
 */
+ (NSString*) timeStamp;

/**
 * 获取14位时间戳（20170515111150）
 *
 */
+ (NSString *)fourteenBitsTimeStamp;

/**
 * 获取当前日期（2017-05-15）
 *
 */
+ (NSString *)currentDate;

/**
 * 转换成天时分秒
 *
 */
+ (NSString *)timeFormatted:(int)totalSeconds;

/**清除缓存和cookie*/
+ (void)cleanCacheAndCookie;

/**
 * JSON字符串转化为字典
 *
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 * 获取用户ip地址
 *
 */
+ (NSString *)getDeviceIPIpAddresses;

#pragma 正则匹配手机号
+(BOOL)checkTelNumber:(NSString *) mobile;
#pragma 正则匹配用户密码6-18位数字和字母组合
+(BOOL)checkPassword:(NSString *) password;
#pragma 正则匹配用户姓名,20位的中文或英文
+(BOOL)checkUserName : (NSString *) userName;
#pragma 正则匹配用户身份证号
+(BOOL)checkUserIdCard: (NSString *) idCard;
+ (BOOL) validateIdentityCard: (NSString *)value;
#pragma 正则匹配邮箱
+ (BOOL)checkUserEmail:(NSString *)email;
#pragma 正则匹配银行卡号
+ (BOOL)checkUserBankNumber:(NSString *)BankNumber;

@end