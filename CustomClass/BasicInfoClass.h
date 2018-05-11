//
//  BasicInfoClass.h
//  zheyangche
//
//  Created by 谷朝阳 on 2016/12/9.
//  Copyright © 2016年 echepei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicInfoClass : NSObject

/**
 用户基础信息单例类
 */

+ (BasicInfoClass *)shared;

@property (nonatomic, copy) NSString *realName;

@property (nonatomic, copy) NSString *IdNumber;

@property (nonatomic, copy) NSString *phoneNumber;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *base_url;    //基础url前缀

@property (nonatomic, copy) NSString *withalsPrice;//存储提现金额 用作统计

@property (nonatomic, copy) NSString *invesPrice;  //存储投资金额 用作统计

@property (nonatomic, copy) NSString *invesName;   //存储标的名称 用作统计

@property (nonatomic, copy) NSString *invesId;     //存储标的号   用作统计

@end
