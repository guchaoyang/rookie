//
//  CollectionViewController.m
//  shopping
//
//  Created by 谷朝阳 on 2018/1/11.
//  Copyright © 2018年 GCY. All rights reserved.
//

#import "CollectionViewController.h"

#import "MyCollectionViewCell.h"

#import "GoodsDetailViewController.h"

#import "HomeListModel.h"

@interface CollectionViewController ()<UICollectionViewDataSource , UICollectionViewDelegate>
{
    NSInteger _pageNum;
}
@property(nonatomic, strong)UICollectionView *collectionView;

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic, strong)UILabel *noDataLabel;

@end

@implementation CollectionViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor] frame:self.navigationController.navigationBar.bounds] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:image(@"home_img_navBackground") forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackgroundColor;
    _pageNum = 1;
    [self createNavigationItem];
    
    [self layoutView];
}

- (void)createNavigationItem{
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = @"我的收藏";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = Dark_TextColor;
    self.navigationItem.titleView = title;
    
    //导航返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.tag = 100;
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    //图片左移
    [backBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    [backBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:image(NAV_BACKBTN_NAME) forState:UIControlStateNormal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = left;
    
}

- (void)layoutView{
    
    __weak typeof(self) weakSelf = self;//防止循环引用
    
    //没有收藏时的label
    [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(30*SProportion_Height);
        make.centerY.equalTo(weakSelf.view);
    }];
//    self.noDataLabel.hidden = NO;
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(weakSelf.view);
    }];
    
    [self.collectionView.mj_header beginRefreshing];//开始刷新

    [self loadingData];
}

- (void)loadingData{
    
    if (_pageNum == 1) {
        [self.dataArray removeAllObjects];
    }
    
    [HTTPManager getGoodsCollectionList:^(NSString *code, NSString *msg, NSArray *result) {
        
        if (code.intValue == 200) {
            if (result.count != 0) {

//                for (HomeListModel *model in result) {
//                    [self.dataArray addObject:model];
//                }
                [self.dataArray addObjectsFromArray:result];
                
                [self.collectionView reloadData];
                
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView.mj_footer endRefreshing];
                
            }else{
                
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                
                if (_pageNum == 1) {
                    self.noDataLabel.hidden = NO;
                    self.collectionView.hidden = YES;
                }
            }
            
        }else{
            
            [XSInfoView showInfo:msg onView:self.view];
        }
        
    } pageNum:_pageNum size:DEFULT_LOAD_NUM];
}

//上拉刷新数据
- (void)loadNewData{
    _pageNum = 1;
    [self loadingData];
}
- (void)loadMoreData{
    _pageNum ++;
    [self loadingData];
}

- (void)buttonClick:(UIButton *)button{
    if (button.tag == 100) {
        //返回
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark collectionView代理方法
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    HomeListModel *model = self.dataArray[indexPath.row];
    setNetImage(cell.goodsPic, model.thumb, @"home_img_recmdList_plaHolder");
    cell.goodsName.text = model.title;
    cell.goodsPrice.text = [NSString stringWithFormat:@"天猫价 ￥%.1f", [model.originalPrice floatValue]];
    cell.couponPrice.text = [NSString stringWithFormat:@"￥%.1f", [model.price floatValue]];
    cell.couponLabel.text = [NSString stringWithFormat:@"%@元券", model.promoPrice];
    cell.soldLabel.text = [NSString stringWithFormat:@"已售%@件", model.sale];
    
    if (model.del == YES) {
        //商品过期
        cell.imageMatte.hidden = NO;
        cell.invalidLabel.hidden = NO;
        cell.invalidTags.hidden = NO;
        cell.couponPriceImage.hidden = YES;
        cell.couponPrice.hidden = YES;
        cell.couponImage.hidden = YES;
    }else{
        cell.imageMatte.hidden = YES;
        cell.invalidLabel.hidden = YES;
        cell.invalidTags.hidden = YES;
        cell.couponPriceImage.hidden = NO;
        cell.couponPrice.hidden = NO;
        cell.couponImage.hidden = NO;
    }
    
    return cell;
    
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(145*SProportion_Width, 220*SProportion_Height);
    
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeListModel *model = _dataArray[indexPath.item];
    if (model.del == YES) {
        //商品过期
        [XSInfoView showInfo:@"该商品已过期或下架~" onView:self.view];
    }else{
        GoodsDetailViewController *gdvc = [[GoodsDetailViewController alloc] init];
        gdvc.goodsId = model.goods_id;
        [self.navigationController pushViewController:gdvc animated:YES];
    }
    
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //2.初始化collectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height ) collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.alwaysBounceHorizontal = NO;
        _collectionView.opaque = NO;
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
        [self.view addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];//注册商品单元格
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        
    }
    return _collectionView;
}

- (UILabel *)noDataLabel{
    if (!_noDataLabel) {
        _noDataLabel = [[UILabel alloc] init];
        _noDataLabel.font = font(16);
        _noDataLabel.text = @"您还没有收藏任何商品 ~";
        _noDataLabel.textColor = Light_TextColor;
        _noDataLabel.adjustsFontSizeToFitWidth = YES;
        _noDataLabel.textAlignment = NSTextAlignmentCenter;
        _noDataLabel.hidden = YES;
        [self.view addSubview:_noDataLabel];
    }
    return _noDataLabel;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
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
