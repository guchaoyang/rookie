//
//  OrderDetailViewController.m
//  shopping
//
//  Created by 谷朝阳 on 2017/12/27.
//  Copyright © 2017年 GCY. All rights reserved.
//

#import "OrderDetailViewController.h"

#import "OrderDetailCell.h"

@interface OrderDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation OrderDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor] frame:self.navigationController.navigationBar.bounds] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = BackgroundColor;
    
    [self createNavigationItem];
    
    [self layoutView];
}

- (void)createNavigationItem{
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = @"订单明细";
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
    
    NSArray *btnTitles = @[@"1级订单",@"2级订单",@"3级订单"];
    for (int i=0; i<btnTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 200+i;
        button.frame = CGRectMake(Screen_Width/3*i, SProportion_Height, Screen_Width/3, 30*SProportion_Height);
        [button setTitleColor:Dark_TextColor forState:UIControlStateNormal];
        if (i==0) {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        [button setBackgroundColor:[UIColor whiteColor]];
        button.titleLabel.font = font(15);
        [button setTitle:btnTitles[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [weakSelf.view addSubview:button];
    }

    //订单列表
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).mas_offset(32*SProportion_Height);
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.goodsPic sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1338609333,2094772177&fm=27&gp=0.jpg"] placeholderImage:image(@"")];
    cell.goodsName.text = @"与狼共舞羽绒服男士短款 与狼共舞羽绒服男士短款 与狼共舞羽绒服男士短款 ";
    cell.goodsPrice.text = [NSString stringWithFormat:@"%@%@",@"付款金额:￥",@"15.00"];
    cell.goodsIncomePrice.text = [NSString stringWithFormat:@"%@%@",@"预估收入:￥",@"3.15"];
    [Helper setRichText:cell.goodsIncomePrice titleString:cell.goodsIncomePrice.text textFont:font(15) fontRang:NSMakeRange(6, cell.goodsIncomePrice.text.length-6) textColor:Red_Color colorRang:NSMakeRange(6, cell.goodsIncomePrice.text.length-6)];
    
    cell.createTimeLabel.text = [NSString stringWithFormat:@"%@%@",@"创建时间：￥",@"2017.12.27  11:40"];

    if (indexPath.row == 0) {
        cell.orderStateLabel.backgroundColor = Red_Color;
        cell.orderStateLabel.text = @"订单付款";
    }else if (indexPath.row == 1){
        cell.orderStateLabel.backgroundColor = Orange_Color;
        cell.orderStateLabel.text = @"订单失效";
    }else if (indexPath.row == 2){
        cell.orderStateLabel.backgroundColor = Golden_Color;
        cell.orderStateLabel.text = @"订单结算";
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

//上拉刷新数据
- (void)loadNewData{
    [self.tableView.mj_header endRefreshing];
}
- (void)loadMoreData{
//    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)buttonClick:(UIButton *)button{
    
    UIButton *button1 = [self.view viewWithTag:200];
    UIButton *button2 = [self.view viewWithTag:201];
    UIButton *button3 = [self.view viewWithTag:202];
    if (button.tag == 100) {
        //返回
        [self.navigationController popViewControllerAnimated:YES];
    }else if (button.tag == 200){
        //1级订单
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button2 setTitleColor:Dark_TextColor forState:UIControlStateNormal];
        [button3 setTitleColor:Dark_TextColor forState:UIControlStateNormal];

    }else if (button.tag == 201){
        //2级订单
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button1 setTitleColor:Dark_TextColor forState:UIControlStateNormal];
        [button3 setTitleColor:Dark_TextColor forState:UIControlStateNormal];
    }else if (button.tag == 202){
        //3级订单
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button1 setTitleColor:Dark_TextColor forState:UIControlStateNormal];
        [button2 setTitleColor:Dark_TextColor forState:UIControlStateNormal];
    }
}

#pragma mark -

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = BackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 105*SProportion_Height;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[OrderDetailCell class] forCellReuseIdentifier:@"cell"];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [self.view addSubview:_tableView];
    }
    return _tableView;
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
