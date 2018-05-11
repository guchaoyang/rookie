//
//  BasicInfoClass.m
//  zheyangche
//
//  Created by 谷朝阳 on 2016/12/9.
//  Copyright © 2016年 echepei. All rights reserved.
//

#import "BasicInfoClass.h"

//static BasicInfoClass *_manager;

@implementation BasicInfoClass

//使用GCD
+ (BasicInfoClass *)shared{
    
    static dispatch_once_t predicate;
    
    static BasicInfoClass *sharedManager;
    
    dispatch_once(&predicate, ^{
        
        sharedManager = [[BasicInfoClass alloc] init];
        
    });
    
    return sharedManager;
}

//不使用GCD
//+ (BasicInfoClass *)shared{
//    
//    if(!_manager)
//        
//        _manager = [[self allocWithZone:NULL] init];
//    
//    return _manager;
//}

@end
