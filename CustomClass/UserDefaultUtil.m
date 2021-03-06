//
//  UserDefaultUtil.m
//  xiaowei
//
//  Created by 成都牛牛优选信息科技有限公司 on 2017/4/14.
//  Copyright © 2017年 成都牛牛优选信息科技有限公司. All rights reserved.
//

#import "UserDefaultUtil.h"

@implementation UserDefaultUtil

+(void)saveValue:(id) value forKey:(NSString *)key{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}

+(id)valueForKey:(NSString *)key{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

+(id)StringForKey:(NSString *)key{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:key];
}


+(BOOL)boolValueForKey:(NSString *)key{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:key];
}

+(void)saveBoolValue:(BOOL)value forKey:(NSString *)key{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:key];
    [userDefaults synchronize];
}

+(void)printAllUserDefault{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    NSLog(@"%@",dic);
}

@end
