//
//  ActivityModel.m
//  shopping
//
//  Created by 谷朝阳 on 2018/1/19.
//  Copyright © 2018年 GCY. All rights reserved.
//

#import "ActivityModel.h"


@implementation ActivityModel

- (id)initWithDataDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.activity_id = StringFormat(dic[@"id"]);
        self.thumb = StringFormat(dic[@"thumb"]);
        self.url = StringFormat(dic[@"url"]);
        self.goodCount = StringFormat(dic[@"goodCount"]);
        self.footCount = StringFormat(dic[@"footCount"]);
        self.type = StringFormat(dic[@"view"]);
        self.title = StringFormat(dic[@"title"]);
        self.favor = [dic[@"favor"] boolValue];
    }
    return self;
}

@end
