//
//  WithdrawalRecordViewController.m
//  shopping
//
//  Created by 谷朝阳 on 2017/12/27.
//  Copyright © 2017年 GCY. All rights reserved.
//

#import "WithdrawalRecordViewController.h"

#import "WithdrawalRecordCell.h"

@interface WithdrawalRecordViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView    *tableView;

@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation WithdrawalRecordViewController

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
    title.text = @"提现记录";
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
    
    //粉丝列表
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).mas_offset(1);
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WithdrawalRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([self.dataArray[indexPath.row] isEqual:@"0"]) {
        cell.stateLabel.backgroundColor = Red_Color;
        cell.stateLabel.text = @"处理中";
    }else if ([self.dataArray[indexPath.row] isEqual:@"1"]){
        cell.stateLabel.backgroundColor = Golden_Color;
        cell.stateLabel.text = @"成功";
    }else{
        cell.stateLabel.backgroundColor = Orange_Color;
        cell.stateLabel.text = @"拒绝";
    }
    
    cell.priceLabel.text = @"￥120.11";
    cell.alipayAccLabel.text = [NSString stringWithFormat:@"支付宝：%@",@"18865531187"];
    cell.timeLabel.text = @"2017.12.27  15:25";
    
    return cell;
}


- (void)buttonClick:(UIButton *)button{
    if (button.tag == 100) {
        //返回
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = BackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50*SProportion_Height;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[WithdrawalRecordCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"0",@"1",@"1",@"2", nil];
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
