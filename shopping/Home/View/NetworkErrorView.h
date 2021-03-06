//
//  NetworkErrorView.h
//  shopping
//
//  Created by 成都牛牛优选信息科技有限公司 on 2018/1/23.
//  Copyright © 2018年 成都牛牛优选信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReloadNetworkDelegate <NSObject>

- (void)reloadNetwork;//重新加载

@end

@interface NetworkErrorView : UIView

@property (nonatomic, weak) id <ReloadNetworkDelegate> delegate;

+ (NetworkErrorView *)shared;//单例创建

@end
