//
//  OtherViewController.m
//  shopping
//
//  Created by 成都牛牛优选信息科技有限公司 on 2017/12/7.
//  Copyright © 2017年 成都牛牛优选信息科技有限公司. All rights reserved.
//

#import "OtherViewController.h"

#import "GoodsDetailViewController.h"

#import "ClassifyGoodsScrollViewController.h"

#import "MyCollectionViewCell.h"

#import "MyCollectionReusableView.h"

#import "HomeViewController.h"

#import "MyGoodsClassCell.h"

#import "JKFlowLayout.h"

#import "HomeListModel.h"

#define CELL_ID_ONE @"cellId_1"
#define CELL_ID_TWO @"cellId_2"
#define HEAD_ID_ONE @"headId_1"
#define HEAD_ID_TWO @"headId_2"
#define FOOT_ID_ONE @"footId_1"
#define FOOT_ID_TWO @"footId_2"

@interface OtherViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, ReloadNetworkDelegate>
{
    NSArray *_goodsRankArray;
    JKFlowLayout *layout;
    NSInteger _pageNum;//页数
    NSInteger _sort;//排序 销量、价格、人气等
}
@property(nonatomic, strong)UICollectionView *collectionView;
///商品上面小分类名称数组
@property(nonatomic, strong)NSMutableArray   *goodsNameArray;
///商品上面小分类图片数组
@property(nonatomic, strong)NSMutableArray   *goodsImageArray;
///商品主分类编码数组
@property(nonatomic, strong)NSMutableArray   *goodsMainCodeArray;
///商品次级分类编码数组
@property(nonatomic, strong)NSMutableArray   *goodsCodeArray;
///商品列表数组
@property(nonatomic, strong)NSMutableArray   *goodsListArray;

@end

@implementation OtherViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    _pageNum = 1;
    _sort = 1;
    _goodsRankArray = @[@"最新",@"销量",@"价格",@"人气"];
//    _goodsNameArray = [[NSMutableArray alloc] initWithObjects:@[@"风衣女",@"女裤",@"女羽绒服",@"裙子",@"卫衣女",@"休闲女",@"针织衫女"],@[@"POLO衫",@"夹克",@"马甲男",@"牛仔裤男",@"外套男",@"卫衣男",@"西裤"],@[@"低帮鞋",@"帆布鞋",@"高帮鞋",@"凉鞋",@"男鞋",@"女鞋",@"皮鞋",@"拖鞋",@"运动鞋"],@[@"单肩包",@"拉杆箱",@"旅行袋",@"男包",@"女包",@"钱包",@"手机包",@"手提包",@"双肩包"],@[@"唇膏",@"防晒霜",@"粉底",@"精华",@"口红",@"面膜",@"乳液",@"洗发",@"香水"],@[@"水杯",@"玻璃杯",@"水壶",@"衣架"],@[@"被套",@"床被",@"脚垫",@"毛巾",@"湿巾",@"收纳",@"蚊帐",@"牙刷",@"枕头"],@[@"茶",@"冲饮",@"糕点",@"酒水",@"咖啡",@"零食",@"牛奶",@"乳制品",@"营养保健"],@[@"背心",@"家居服",@"内裤男",@"内衣女",@"睡衣",@"袜子",@"文胸"],@[@"登山",@"钢笔",@"户外",@"旅行",@"野营",@"游泳",@"瑜伽"],@[@"电脑",@"耳机",@"键鼠",@"手机",@"手机壳",@"数据线",@"移动电源"],@[@"奶粉",@"奶瓶",@"童车",@"童床",@"童装",@"玩具",@"纸巾",@"纸尿裤"],@[@"耳钉",@"发饰",@"帽子",@"戒指",@"手表",@"手链",@"手套",@"围巾",@"项链",@"眼睛"],@[@"宠物零食",@"宠物用品",@"狗粮",@"猫粮"], nil];
    
    layout = [JKFlowLayout new];
    layout.naviHeight = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [Helper isHasNetWork:^(BOOL has) {
        if (has) {
            [self loadDataRequest];
        }else{
            [NetworkErrorView shared].hidden = NO;
            [NetworkErrorView shared].delegate = self;
            [self.view addSubview:[NetworkErrorView shared]];
        }
    }];
}

#pragma mark - ReloadNetworkDelegate
- (void)reloadNetwork{
    
    [Helper isHasNetWork:^(BOOL has) {
        if (has) {
            [NetworkErrorView shared].hidden = YES;
            [self loadDataRequest];
        }
    }];
    
}

- (void)layoutView{
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view).mas_offset(UI_IS_IPHONE_X?-171:-113);
    }];
    
//    [self.collectionView.mj_header beginRefreshing];
    
    [self loadingCategoryList];
}

- (void)loadDataRequest{
    
    //子分类标题等信息请求
    [HTTPManager getHomeMainCategoryInfo:^(NSString *code, NSString *msg, NSArray *result) {
        
        for (HomeCatetoryModel *parentModel in result) {
            
            [self.goodsMainCodeArray addObject:parentModel.code];
            
            NSArray *cateArray = parentModel.subArray;
            NSMutableArray *mubNameArray = [NSMutableArray array];
            NSMutableArray *mubCodeArray = [NSMutableArray array];
            NSMutableArray *mubImageArray = [NSMutableArray array];
            for (HomeSubCatetoryModel *subModel in cateArray) {
                [mubNameArray addObject:subModel.name];
                [mubCodeArray addObject:subModel.code];
                [mubImageArray addObject:subModel.thumb];
            }
            [self.goodsNameArray addObject:mubNameArray];
            [self.goodsCodeArray addObject:mubCodeArray];
            [self.goodsImageArray addObject:mubImageArray];
            //            if (mubImageArray.count>8) {
            //                _goodsImageArray = [mubImageArray subarrayWithRange:NSMakeRange(0, 7)];
            //                [_goodsImageArray addObject:@"home_btn_classfiAlle"];
            //            }
        }
        
        [self layoutView];
    }];
}

- (void)loadingCategoryList{
    
    if (_pageNum == 1) {
        [self.goodsListArray removeAllObjects];
    }
    
    [HTTPManager getHomeMainCategoryListInfo:^(NSString *code, NSString *msg, NSArray *result) {
        if (result.count != 0){
//            for (HomeListModel *model in result) {
//                [self.goodsListArray addObject:model];
//            }
            
            [self.goodsListArray addObjectsFromArray:result];
            
            [self.collectionView reloadData];
            
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
        }else{
            
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } category:self.code pageNum:_pageNum size:DEFULT_LOAD_NUM sort:_sort];
}

//上拉刷新数据
- (void)loadNewData{
    _pageNum = 1;
    
    [self loadingCategoryList];
}
- (void)loadMoreData{
    
    _pageNum ++;
    
    [self loadingCategoryList];
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.goodsNameArray[_goodsType] count];
    }else{
        return [self.goodsListArray count];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MyGoodsClassCell *cell = (MyGoodsClassCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID_TWO forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        setNetImage(cell.goodsPic, self.goodsImageArray[_goodsType][indexPath.item], @"");
        cell.goodsName.text = self.goodsNameArray[_goodsType][indexPath.item];
        
        return cell;
        
    }else{
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID_ONE forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        if (self.goodsListArray.count == 0) {
            [XSInfoView showInfo:@"正在刷新商品..." onView:self.view];
        }else{
          
            HomeListModel *model = self.goodsListArray[indexPath.item];
            
            setNetImage(cell.goodsPic, model.thumb, @"home_img_recmdList_plaHolder");
            cell.goodsName.text = model.title;
            cell.goodsPrice.text = [NSString stringWithFormat:@"天猫价 ￥%.1f", [model.originalPrice floatValue]];
            cell.couponPrice.text = [NSString stringWithFormat:@"￥%.1f", [model.price floatValue]];
            cell.couponLabel.text = [NSString stringWithFormat:@"%@元券", model.promoPrice];
            cell.soldLabel.text = [NSString stringWithFormat:@"月销 %@", model.sale];
        }
        
        return cell;
    }
    
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(Screen_Width/4, 60*SProportion_Height);

    }else{
        return CGSizeMake(145*SProportion_Width, 210*SProportion_Height);

    }
}

//footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(Screen_Width, 30*SProportion_Height);
    }else{
        return CGSizeMake(Screen_Width, 0.01);
    }
}

//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(Screen_Width, 0.01);
    }else{
        return CGSizeMake(Screen_Width, 30*SProportion_Height);
    }
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        return UIEdgeInsetsMake(0, 10, 0, 10);
    }
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }
}


//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (kind == UICollectionElementKindSectionHeader) {
            UICollectionReusableView *headerView = nil;
            
            headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HEAD_ID_ONE forIndexPath:indexPath];
            headerView.backgroundColor = [UIColor whiteColor];
            return headerView;

        }
        
        
        if (kind==UICollectionElementKindSectionFooter){
            //第一个区的区尾视图
            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:FOOT_ID_ONE forIndexPath:indexPath];
            footerView.backgroundColor = [UIColor whiteColor];
            
            for (UIView *view in footerView.subviews) {
                [view removeFromSuperview];
            }
            //推荐文字
            UIButton *recommendLabel = [UIButton buttonWithType:UIButtonTypeCustom];
            [recommendLabel setBackgroundColor:[UIColor whiteColor]];
            [recommendLabel setImage:image(@"home_img_crown") forState:UIControlStateNormal];
            [recommendLabel setTitle:@"实时推荐" forState:UIControlStateNormal];
            [recommendLabel setTitleColor:Red_Color forState:UIControlStateNormal];
            recommendLabel.titleLabel.font = font(14);
            [footerView addSubview:recommendLabel];
            
            [recommendLabel layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
            
            [recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.top.mas_equalTo(0);
                make.height.mas_equalTo(30*SProportion_Height);
            }];
            
            //渐变横条图片
            NSArray *sipesArr = @[@"home_img_gadtSipes_lft", @"home_img_gadtSipes_riht"];
            for (int i = 0 ; i < 2; i ++){
                UIImageView *leftHorImage = [[UIImageView alloc] initWithFrame:CGRectMake(30*SProportion_Width + 180*SProportion_Width*i, 14.5f*SProportion_Height, 80*SProportion_Width, 1)];
                leftHorImage.image = image(sipesArr[i]);
                [recommendLabel addSubview:leftHorImage];
            }
            
            return footerView;
        }
    
    }
    
    else if(indexPath.section == 1){
        
        if (kind == UICollectionElementKindSectionHeader) {
         
            MyCollectionReusableView *headerView = nil;
            
            headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEAD_ID_TWO forIndexPath:indexPath];
            
            //            for (UIView *view in headerView.subviews) {
            //                [view removeFromSuperview];
            //            }
            
            headerView.backgroundColor =[UIColor whiteColor];
            [headerView.newButton addTarget:self action:@selector(buttonTypeClick:) forControlEvents:UIControlEventTouchUpInside];
            [headerView.saleButton addTarget:self action:@selector(buttonTypeClick:) forControlEvents:UIControlEventTouchUpInside];
            [headerView.priceButton addTarget:self action:@selector(buttonTypeClick:) forControlEvents:UIControlEventTouchUpInside];
            [headerView.hitsButton addTarget:self action:@selector(buttonTypeClick:) forControlEvents:UIControlEventTouchUpInside];
            
            return headerView;
            
        }else{
            
            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:FOOT_ID_TWO forIndexPath:indexPath];
            footerView.backgroundColor = [UIColor whiteColor];
            return footerView;
        }
       

    }
    
    return nil;

}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ClassifyGoodsScrollViewController *cgsvc = [[ClassifyGoodsScrollViewController alloc] init];
        
        //此处数组赋值需要注意 数组用等号赋值另一个数组时，会是指针直接赋值，但一个数组变化时另一个数组的值也就会变化，所以当我们需要不同的数组时需要重新开辟空间
        cgsvc.dataArray = [[NSMutableArray alloc] initWithArray:self.goodsNameArray[self.goodsType]];
        cgsvc.codeArray = [[NSMutableArray alloc] initWithArray:self.goodsCodeArray[self.goodsType]];
        cgsvc.navTitle = self.goodsNameArray[self.goodsType][indexPath.item];
        cgsvc.mainCategoryCode = self.goodsMainCodeArray[self.goodsType];
        cgsvc.index = indexPath.item + 1;//此处跳转后因为有全部 其他商品的索引要加1
        [self.navigationController pushViewController:cgsvc animated:YES];
    } else {
        if (self.goodsListArray.count == 0) {
            [XSInfoView showInfo:@"正在刷新商品..." onView:self.view];
        }else{
            HomeListModel *model = self.goodsListArray[indexPath.item];
            GoodsDetailViewController *gdvc = [[GoodsDetailViewController alloc] init];
            gdvc.goodsId = model.goods_id;
            [self.navigationController pushViewController:gdvc animated:YES];
        }
        
    }
    
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"滑动了：%f  %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
//}

- (void)buttonTypeClick:(UIButton *)button{
    
    if (button.tag == 200){
        //最新
        _sort = 1;
    }else if (button.tag == 201){
        //销量
        _sort = 2;
    }else if (button.tag == 202){
        //价格
        if (button.isSelected == NO) {
            NSLog(@"升序");
            _sort = 3;
            button.selected = YES;
            [button setImage:image(@"home_btn_priceSort_high") forState:UIControlStateNormal];
        }else{
            NSLog(@"降序");
            _sort = 4;
            button.selected = NO;
            [button setImage:image(@"home_btn_priceSort_low") forState:UIControlStateNormal];
        }
    }else if (button.tag == 203){
        //人气
        _sort = 5;
    }
    _pageNum = 1;//切换筛选条件后 重新从第一页开始请求
    [self loadingCategoryList];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        if (@available(iOS 9.0, *)) {
//            设置是否当元素超出屏幕之后固定头部视图位置
//            layout.sectionHeadersPinToVisibleBounds = YES;
//            layout.sectionFootersPinToVisibleBounds = YES;

        } else {
            // Fallback on earlier versions
        }
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - (UI_IS_IPHONE_X?171:113) - 30*SProportion_Height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.alwaysBounceHorizontal = NO;
        _collectionView.opaque = NO;
        [_collectionView setPagingEnabled:NO];
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [self.view addSubview:_collectionView];
        
        //注册商品单元格
        [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:CELL_ID_ONE];
        //注册商品分类单元格
        [_collectionView registerClass:[MyGoodsClassCell class] forCellWithReuseIdentifier:CELL_ID_TWO];
        //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中一致; 终于发现问题，注册一个区头也得注册一个区尾，加载的时候如果没有返回区尾，他会返回两遍区头。
        //注册第一个区的区头
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEAD_ID_ONE];
        //注册第一个区的区尾
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FOOT_ID_ONE];
        //注册第二个区的区头 自定义
        [_collectionView registerClass:[MyCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEAD_ID_TWO];
        //注册第二个区的区尾
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FOOT_ID_TWO];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}

#pragma mark - lazyLoading

- (NSMutableArray *)goodsNameArray{
    if (_goodsNameArray == nil) {
        _goodsNameArray = [[NSMutableArray alloc] init];
    }
    return _goodsNameArray;
}

- (NSMutableArray *)goodsImageArray{
    if (_goodsImageArray == nil) {
        _goodsImageArray = [[NSMutableArray alloc] init];
    }
    return _goodsImageArray;
}

- (NSMutableArray *)goodsMainCodeArray{
    if (_goodsMainCodeArray == nil) {
        _goodsMainCodeArray = [[NSMutableArray alloc] init];
    }
    return _goodsMainCodeArray;
}

- (NSMutableArray *)goodsCodeArray{
    if (_goodsCodeArray == nil) {
        _goodsCodeArray = [[NSMutableArray alloc] init];
    }
    return _goodsCodeArray;
}

- (NSMutableArray *)goodsListArray{
    if (_goodsListArray == nil) {
        _goodsListArray = [[NSMutableArray alloc] init];
    }
    return _goodsListArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end