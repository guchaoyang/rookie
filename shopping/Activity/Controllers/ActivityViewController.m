//
//  ActivityViewController.m
//  shopping
//
//  Created by 谷朝阳 on 2017/12/10.
//  Copyright © 2017年 GCY. All rights reserved.
//

#import "ActivityViewController.h"

#import "ActivityCell.h"

#import "ActivityModel.h"

#import "PartnerViewController.h"

#import "JoinPartnerViewController.h"

#import "H5RecordPage.h"

#import "RegisterViewController.h"

@interface ActivityViewController ()<UITableViewDelegate, UITableViewDataSource, ReloadNetworkDelegate>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSArray *dataArray;

@property(nonatomic, strong)UILabel *noDataLabel;

//@property(nonatomic, assign)BOOL isLike;

@end

@implementation ActivityViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [Helper isHasNetWork:^(BOOL has) {
        if (has) {
            [self loadingData];
        }else{
            [NetworkErrorView shared].hidden = NO;
            [NetworkErrorView shared].delegate = self;
            [self.view addSubview:[NetworkErrorView shared]];
        }
    }];
    
}

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
    
    __weak typeof(self) weakSelf = self;//防止循环引用
    
    //没有收藏时的label
    [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(30*SProportion_Height);
        make.centerY.equalTo(weakSelf.view);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(10*SProportion_Height);
    }];
    
}

- (void)loadingData{
    
    [HTTPManager getActivityListInfo:^(NSString *code, NSString *msg, NSArray *result) {
        if (code.intValue == 200) {
            if (result.count == 0) {
                self.noDataLabel.hidden = NO;
                self.tableView.hidden = YES;
            }else{
                
                self.noDataLabel.hidden = YES;
                self.tableView.hidden = NO;
                
                self.dataArray = result;
                
                [self.tableView reloadData];
            }
            
        }else{
            
            [XSInfoView showInfo:msg onView:self.view];

        }
       
    }];
}

#pragma mark - ReloadNetworkDelegate
- (void)reloadNetwork{
    
    [Helper isHasNetWork:^(BOOL has) {
        if (has) {
            [NetworkErrorView shared].hidden = YES;
            [self loadingData];
        }
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.likeButton.tag = indexPath.row + 100;
    
    ActivityModel *model = self.dataArray[indexPath.row];
    
    setNetImage(cell.activityPic, model.thumb, @"home_img_baner_plaHolder");
    [cell.likeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.pageViewButton setTitle:model.footCount forState:UIControlStateNormal];
    [cell.likeButton setTitle:model.goodCount forState:UIControlStateNormal];
    if (model.favor == true) {
        [cell.likeButton setImage:image(@"activity_btn_good_selected") forState:UIControlStateNormal];
    }else{
        [cell.likeButton setImage:image(@"activity_btn_good") forState:UIControlStateNormal];
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ActivityModel *model = self.dataArray[indexPath.row];
    
    if (model.type.intValue == 0) {
        //金币商城等等网页活动
        if (TOKEN_ISEMPTY) {
            RegisterViewController *rvc = [[RegisterViewController alloc] init];
            NavigationController *nav = [[NavigationController alloc] initWithRootViewController:rvc];
            [self presentViewController:nav animated:YES completion:nil];
        }else{
            H5RecordPage *hrp = [[H5RecordPage alloc] init];
            hrp.titleString = model.title;
            hrp.type = 3;
            hrp.requestUrl = model.url;
            [self.navigationController pushViewController:hrp animated:YES];
        }
        
    }else if (model.type.intValue == 1){
        //邀请合伙人
        BOOL isPartner = [UserDefaultUtil boolValueForKey:IS_PARTNER];
        if (isPartner == NO) {
            //非合伙人 去申请加入
//            JoinPartnerViewController *jpvc = [[JoinPartnerViewController alloc] init];
//            [self.navigationController pushViewController:jpvc animated:YES];
            [XSInfoView showInfo:@"您还不是合伙人~" onView:self.view];
        }else{
            //是合伙人 合伙人中心
            PartnerViewController *pvc = [[PartnerViewController alloc] init];
            [self.navigationController pushViewController:pvc animated:YES];
        }
    }
    
    //增加访问量👣
    if (TOKEN_ISEMPTY) {
        
    }else{
        [HTTPManager addActivityFoot:^(NSString *code, NSString *msg, id result) {

        } activityId:model.activity_id];
    }
    
}

//点赞button事件
- (void)buttonClick:(UIButton *)button{
    if (TOKEN_ISEMPTY) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"亲~登录后才能点赞呦~" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            RegisterViewController *rvc = [[RegisterViewController alloc] init];
            NavigationController *nav = [[NavigationController alloc] initWithRootViewController:rvc];
            [self presentViewController:nav animated:YES completion:nil];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"再看看" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        
        ActivityModel *model = self.dataArray[button.tag - 100];
        if (model.favor == true) {
            //取消点赞
            [HTTPManager deleteActivityCancelLike:^(NSString *code, NSString *msg, NSString *result) {
                if (code.intValue == 200) {
                    
                    [self loadingData];
                }
                
                [XSInfoView showInfo:result onView: self.view];
                
            } activityId:model.activity_id];
        }else{
            //点赞
            [HTTPManager postActivityLike:^(NSString *code, NSString *msg, NSString *result) {
                if (code.intValue == 200) {
                    
                    
                    [self loadingData];
                }
                
                [XSInfoView showInfo:result onView: self.view];
                
            } activityId:model.activity_id];
        }
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
        [_tableView registerClass:[ActivityCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UILabel *)noDataLabel{
    if (!_noDataLabel) {
        _noDataLabel = [[UILabel alloc] init];
        _noDataLabel.font = font(16);
        _noDataLabel.text = @"暂无活动";
        _noDataLabel.textColor = Light_TextColor;
        _noDataLabel.adjustsFontSizeToFitWidth = YES;
        _noDataLabel.textAlignment = NSTextAlignmentCenter;
        _noDataLabel.hidden = YES;
        [self.view addSubview:_noDataLabel];
    }
    return _noDataLabel;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSArray alloc] init];
    }
    return _dataArray;
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
