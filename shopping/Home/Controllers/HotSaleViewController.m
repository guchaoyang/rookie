//
//  HotSaleViewController.m
//  shopping
//
//  Created by 谷朝阳 on 2017/12/29.
//  Copyright © 2017年 GCY. All rights reserved.
//

#import "HotSaleViewController.h"

#import "HomeTableViewCell.h"

#import "GoodsDetailViewController.h"

#import "HomeListModel.h"

@interface HotSaleViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSInteger _pageNum;
}
@property(nonatomic, strong)UITableView    *tableView;

@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation HotSaleViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackgroundColor;
    
    _pageNum = 1;
    
    [self createNavigationItem];
    
    [self layoutView];
}

- (void)createNavigationItem{
    
    self.navigationItem.title = self.navTitle;
    //导航返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    //图片左移
    [backBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:image(NAV_WHITE_BACKBTN_NAME) forState:UIControlStateNormal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = left;
    
}

- (void)layoutView{
    
    __weak typeof(self) weakSelf = self;//防止循环引用
    
    //榜单列表
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(weakSelf.view);
    }];
    
//    [self.tableView.mj_header beginRefreshing];//开始刷新
    
    [self loadingData];
}

- (void)loadingData{
    
    if (_pageNum == 1) {
        [self.dataArray removeAllObjects];
    }
    
    if (self.type == 0) {
        
        //榜单
        [HTTPManager getHomeRankListInfo:^(NSString *code, NSString *msg, NSArray *result) {
            
            if (result.count != 0) {
                for (HomeListModel *model in result) {
                    [self.dataArray addObject:model];
                }
                
                [self.tableView reloadData];
                
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                
            }else{
                
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        } pageNum:_pageNum size:DEFULT_LOAD_NUM];
        
    }else{
        
        //精选推送
        [HTTPManager getHomeGoodsPushListInfo:^(NSString *code, NSString *msg, NSArray *result) {
            if (code.intValue == 200) {
                
                if (result.count != 0){
//                    for (HomeListModel *model in result) {
//                        [self.dataArray addObject:model];
//                    }
                    [self.dataArray addObjectsFromArray:result];
                    
                    [self.tableView reloadData];
                    
                    [self.tableView.mj_header endRefreshing];
                    [self.tableView.mj_footer endRefreshing];
                    
                }else{
                    
                    [self.tableView.mj_header endRefreshing];
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];

                }
            }
        } pageNum:_pageNum size:DEFULT_LOAD_NUM];
        
    }
    
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


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    HomeListModel *model = self.dataArray[indexPath.row];
    
    setNetImage(cell.goodsPic, model.thumb, @"home_img_recmdList_plaHolder");
    cell.goodsName.text = model.title;
    cell.goodsOriginalPrice.text = [NSString stringWithFormat:@"天猫价 ￥%.1f", [model.originalPrice floatValue]];;
    cell.goodsPrice.text = [NSString stringWithFormat:@"￥%.1f", [model.price floatValue]];
    cell.couponsPrice.text = [NSString stringWithFormat:@"%@元券", model.promoPrice];
    cell.goodsSales.text = [NSString stringWithFormat:@"月销%@", model.sale];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsDetailViewController *gdvc = [[GoodsDetailViewController alloc] init];
    HomeListModel *model = self.dataArray[indexPath.row];
    gdvc.goodsId = model.goods_id;
    [self.navigationController pushViewController:gdvc animated:YES];
    
}

- (void)backClick{
    //返回
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 100*SProportion_Height;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [self.view addSubview:_tableView];
    }
    return _tableView;
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
