//
//  UserDefaultUtil.h
//  xiaowei
//
//  Created by 成都牛牛优选信息科技有限公司 on 2017/4/14.
//  Copyright © 2017年 成都牛牛优选信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultUtil : NSObject


/**
 赋值
 
 */
+(void)saveValue:(id) value forKey:(NSString *)key;


/**
 取值
 
 */
+(id)valueForKey:(NSString *)key;


+(id)StringForKey:(NSString *)key;

+(void)saveBoolValue:(BOOL)value forKey:(NSString *)key;

+(BOOL)boolValueForKey:(NSString *)key;


+(void)printAllUserDefault;

@end
