//
//  ClassifyGoodsScrollViewController.h
//  shopping
//
//  Created by 谷朝阳 on 2017/12/25.
//  Copyright © 2017年 GCY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassifyGoodsScrollViewController : UIViewController

@property(nonatomic, strong)NSMutableArray  *dataArray;//标题数据源

@property(nonatomic, strong)NSMutableArray  *codeArray;//商品编码数据源

@property(nonatomic,   copy)NSString *navTitle;//导航标题

@property(nonatomic,   copy)NSString *mainCategoryCode;//大分类编码

@property(nonatomic, assign)NSInteger index;//选中的分类

@end
