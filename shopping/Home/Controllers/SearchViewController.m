//
//  SearchViewController.m
//  shopping
//
//  Created by 成都牛牛优选信息科技有限公司 on 2017/12/12.
//  Copyright © 2017年 成都牛牛优选信息科技有限公司. All rights reserved.
//

#import "SearchViewController.h"
#import "TagView.h"
#import "SearchResultViewController.h"

@interface SearchViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *searchTextField;
//热门搜索标签数组
@property(strong, nonatomic)NSMutableArray *hotSearchArray;
///历史搜索标签数组
@property(strong, nonatomic)NSMutableArray *historySearchArray;

@property(nonatomic,strong) UILabel *hotText;

@property(nonatomic,strong) TagView *hotTagView;

@property(nonatomic,strong) UILabel *historyText;

@property(nonatomic,strong) TagView *historyTagView;

@property(nonatomic,strong) UIButton *cleanBtn;

@end

@implementation SearchViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor] frame:self.navigationController.navigationBar.bounds] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    //热门标签请求
    [HTTPManager getGoodsHotSearchTags:^(NSString *code, NSString *msg, NSArray *result) {
        
        if (code.intValue == 200) {
            
            self.hotSearchArray = (NSMutableArray *)result;
            
            [self layoutView];
            
        }else{
            
            [XSInfoView showInfo:msg onView:self.view];
        }
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:image(@"home_img_navBackground") forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNavigationItem];
    
}

- (void)createNavigationItem{
    
    [self.navigationItem setHidesBackButton:YES];
    
    UIImageView *searchImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7.5f, 15, 15)];
    searchImage.image = [UIImage imageNamed:@"img_search_search"];
    
    _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 260*SProportion_Width, 30)];
    _searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    _searchTextField.backgroundColor = BackgroundColor;
    _searchTextField.keyboardType = UIKeyboardTypeDefault;
    _searchTextField.tintColor = Blue_TextColor;//光标颜色
    [_searchTextField becomeFirstResponder];//直接开始编辑
    _searchTextField.font=[UIFont systemFontOfSize:14];
    [_searchTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    _searchTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入关键词" attributes:@{NSForegroundColorAttributeName: Light_TextColor}];
    [_searchTextField setTextColor:Light_TextColor];
    _searchTextField.delegate = self;
    _searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _searchTextField.returnKeyType = UIReturnKeySearch;
    _searchTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 20)];
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    [_searchTextField addSubview:searchImage];
    self.navigationItem.titleView = _searchTextField;
    
    //导航取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, 30, 30);
    [cancelBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = font(14);
    [cancelBtn setTitleColor:Dark_TextColor forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
    self.navigationItem.rightBarButtonItem = right;

}

- (void)layoutView{
    
    __weak typeof(self) weakSelf = self;//防止循环引用
    
    if (_hotText) {
        [_hotText removeFromSuperview];
    }
    //热门文字
    _hotText = [[UILabel alloc] init];
    _hotText.text = @"热门搜索";
    _hotText.textColor = Dark_TextColor;
    _hotText.font = font(14);
    _hotText.adjustsFontSizeToFitWidth = YES;
    [weakSelf.view addSubview:_hotText];
    
    [_hotText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).mas_offset(15*SProportion_Width);
        make.top.equalTo(weakSelf.view).mas_offset(10*SProportion_Height);
        make.size.mas_equalTo(CGSizeMake(60*SProportion_Width, 15*SProportion_Height));
    }];
    
    
    //热门搜索标签
    if (_hotTagView) {
        [_hotTagView removeFromSuperview];
    }
    _hotTagView = [[TagView alloc]initWithFrame:CGRectMake(0, 25*SProportion_Height, Screen_Width ,0) dataArr:self.hotSearchArray];
    NSLog(@"%f",_hotTagView.frame.size.height);
    _hotTagView.backgroundColor = [UIColor whiteColor];
    [_hotTagView btnClickBlock:^(NSInteger index) {
        
        NSLog(@"热门搜索标签:%@",self.hotSearchArray[index-100]);
        SearchResultViewController *srvc = [[SearchResultViewController alloc] init];
        srvc.keyword = self.hotSearchArray[index-100];
        [self.navigationController pushViewController:srvc animated:YES];
        
    }];
    [weakSelf.view addSubview:_hotTagView];
    
    
    //从本地取出数据源
    NSMutableArray *infoArr = [UserDefaultUtil valueForKey:HISTORY_SEARCH_ARRAY];
    if (infoArr == nil) {
        //Nsuserdefult数组初始化
        NSMutableArray *infoArr = [[NSMutableArray alloc] init];
        [UserDefaultUtil saveValue:infoArr forKey:HISTORY_SEARCH_ARRAY];
    }
    
    //历史搜索文字
    if (_historyText) {
        [_historyText removeFromSuperview];
    }
    _historyText = [[UILabel alloc] init];
    _historyText.text = @"历史搜索";
    _historyText.textColor = Dark_TextColor;
    _historyText.font = font(14);
    _historyText.adjustsFontSizeToFitWidth = YES;
    [weakSelf.view addSubview:_historyText];
    
    [_historyText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).mas_offset(15*SProportion_Width);
        make.top.mas_equalTo(40*SProportion_Height + _hotTagView.frame.size.height);
        make.size.mas_equalTo(CGSizeMake(60*SProportion_Width, 15*SProportion_Height));
    }];
    
    //历史搜索标签
    if (_historyTagView) {
        [_historyTagView removeFromSuperview];
    }
    _historyTagView = [[TagView alloc]initWithFrame:CGRectMake(0, 55*SProportion_Height + _hotTagView.frame.size.height, Screen_Width ,0) dataArr:infoArr];
    _historyTagView.backgroundColor = [UIColor whiteColor];
    [_historyTagView btnClickBlock:^(NSInteger index) {
        
        NSLog(@"历史搜索标签:%@",infoArr[index-100]);
        SearchResultViewController *srvc = [[SearchResultViewController alloc] init];
        srvc.keyword = infoArr[index-100];
        [self.navigationController pushViewController:srvc animated:YES];
        
    }];
    [weakSelf.view addSubview:_historyTagView];
    
    //清空历史搜索button
    if (_cleanBtn) {
        [_cleanBtn removeFromSuperview];
    }
    _cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cut(_cleanBtn, 5);
    cutBorder(_cleanBtn, 1, @"f0f0f0");
    [_cleanBtn setTitle:@"清空历史搜索" forState:UIControlStateNormal];
    [_cleanBtn setImage:image(@"img_search_delete") forState:UIControlStateNormal];
    _cleanBtn.titleLabel.font = font(15);
    [_cleanBtn setTitleColor:Light_TextColor forState:UIControlStateNormal];
    [_cleanBtn addTarget:self action:@selector(cleanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [weakSelf.view addSubview:_cleanBtn];
    
    [_cleanBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10*SProportion_Width];
    
    [_cleanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(65*SProportion_Height + _hotTagView.frame.size.height + _historyTagView.frame.size.height);
        make.left.equalTo(weakSelf.view).mas_equalTo(55*SProportion_Width);
        make.size.mas_equalTo(CGSizeMake(210*SProportion_Width, 30*SProportion_Height));
    }];
}


//点击搜索
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([Helper isNotBlankString:textField.text]) {
        
        //统计搜索关键字
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              textField.text, @"keyword", nil];
        [MobClick event:@"search_Keyword" attributes:dict];
        
        NSMutableArray *infoArr = [UserDefaultUtil valueForKey:HISTORY_SEARCH_ARRAY];
        
        //可变对象存入NSUserDefaults后无法直接改变，强制执行会崩溃，必须把可变对象复制出来修改后替换掉原来的对象
        NSMutableArray *mutableCopyArr = [infoArr mutableCopy];
        //对数组添加元素的个数进行限制 最多15
        if (mutableCopyArr.count >= 15) {
            [mutableCopyArr removeObjectAtIndex:0];
        }
        
        [mutableCopyArr addObject: textField.text];
        
        //过滤重复的字符串
        NSMutableArray *filterArray = [[NSMutableArray alloc] init];
        for (NSString *str in mutableCopyArr) {
            if (![filterArray containsObject:str]) {
                [filterArray addObject:str];
            }
        }
        
        [UserDefaultUtil saveValue:filterArray forKey:HISTORY_SEARCH_ARRAY];
        
//        [textField resignFirstResponder];//取消第一响应者
        
        SearchResultViewController *srvc = [[SearchResultViewController alloc] init];
        srvc.keyword = textField.text;
        [self.navigationController pushViewController:srvc animated:NO];
        
        return YES;
        
    }else{
        
        [XSInfoView showInfo:@"关键词不能为空" onView:self.view];
    }
    
    return NO;
    
}
//清除历史记录
- (void)cleanBtnClick{
    //从本地取出数据源
    NSMutableArray *infoArr = [UserDefaultUtil valueForKey:HISTORY_SEARCH_ARRAY];
    
    //可变对象存入NSUserDefaults后无法直接改变，强制执行会崩溃，必须把可变对象复制出来修改后替换掉原来的对象
    NSMutableArray *mutableCopyArr = [infoArr mutableCopy];
    //找到历史标签全部清除
    for (int i=0; i<mutableCopyArr.count; i++) {
        UIButton *button = [self.view viewWithTag:300+i];
        [button removeFromSuperview];
    }
    [mutableCopyArr removeAllObjects];//清空本地数据源
    
    [UserDefaultUtil saveValue:mutableCopyArr forKey:HISTORY_SEARCH_ARRAY];
    
    //更新UI
    [_historyTagView removeFromSuperview];
    
    [_cleanBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(65*SProportion_Height + _hotTagView.frame.size.height);
    }];
    
}
//返回
- (void)backBtn{
    [self.navigationController popViewControllerAnimated:NO];
}
///热门搜索数组
- (NSMutableArray *)hotSearchArray{
    if (!_hotSearchArray) {
        _hotSearchArray = [[NSMutableArray alloc] init];
    }
    return _hotSearchArray;
}
///历史搜索数组
- (NSMutableArray *)historySearchArray{
    if (!_historySearchArray) {
        _historySearchArray = [[NSMutableArray alloc] init];
    }
    return _historySearchArray;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
