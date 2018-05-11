//
//  UserDefaultUtil.h
//  xiaowei
//
//  Created by 谷朝阳 on 2017/4/14.
//  Copyright © 2017年 echepei. All rights reserved.
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
