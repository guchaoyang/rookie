//
//  ActivityViewController.m
//  shopping
//
//  Created by 谷朝阳 on 2017/12/10.
//  Copyright © 2017年 GCY. All rights reserved.
//

#import "ActivityViewController.h"

#import "ActivityCell.h"

#import "PartnerViewController.h"

#import "JoinPartnerViewController.h"

@interface ActivityViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = BackgroundColor;
    
    self.navigationItem.title = @"活动";
    
    [self createNavigationItem];
    
    [self layoutView];

}

- (void)createNavigationItem{
    
//    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
//    title.text = @"活动";
//    title.textAlignment = NSTextAlignmentCenter;
//    title.textColor = [UIColor whiteColor];
//    self.navigationItem.titleView = title;
}


- (void)layoutView{
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(10*SProportion_Height);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.likeButton.tag = indexPath.row + 100;
    
    if (indexPath.row == 0) {
        cell.activityPic.image = image(@"activity_img_mall");
    }else if (indexPath.row == 1){
        cell.activityPic.image = image(@"activity_img_partner");

    }
    
    [cell.likeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.pageViewButton setTitle:@"568" forState:UIControlStateNormal];
    [cell.likeButton setTitle:@"200" forState:UIControlStateNormal];

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //金币商城
    }else if (indexPath.row == 1){
        //邀请合伙人
        NSString *partnerValueStr = [UserDefaultUtil valueForKey:IS_PARTNER];
        if ([partnerValueStr isEqualToString:@"0"]) {
            //非合伙人 去申请加入
            JoinPartnerViewController *jpvc = [[JoinPartnerViewController alloc] init];
            [self.navigationController pushViewController:jpvc animated:YES];
        }else{
            //是合伙人 合伙人中心
            PartnerViewController *pvc = [[PartnerViewController alloc] init];
            [self.navigationController pushViewController:pvc animated:YES];
        }
    }
}

- (void)buttonClick:(UIButton *)button{
    if (button.tag == 100) {
        //金币商城
        NSLog(@"金币");
    }else if (button.tag == 101){
        //合伙人
        NSLog(@"合伙人");

    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = BackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 160*SProportion_Height;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[ActivityCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

//控制状态栏字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleLightContent;
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
