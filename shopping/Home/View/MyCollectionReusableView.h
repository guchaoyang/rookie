//
//  MyCollectionReusableView.h
//  shopping
//
//  Created by 谷朝阳 on 2017/12/11.
//  Copyright © 2017年 GCY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionReusableView : UICollectionReusableView

@property(nonatomic, strong)UIButton *newButton;//最新

@property(nonatomic, strong)UIButton *saleButton;//销量

@property(nonatomic, strong)UIButton *priceButton;//价格

@property(nonatomic, strong)UIButton *hitsButton;//人气

@end
