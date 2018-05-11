//
//  HomeViewController.m
//  shopping
//
//  Created by 成都牛牛优选信息科技有限公司 on 2017/12/7.
//  Copyright © 2017年 成都牛牛优选信息科技有限公司. All rights reserved.
//

#import "HomeViewController.h"

#import "FSScrollContentView.h"

#import "OtherViewController.h"

#import "MainViewController.h"

#import "SearchViewController.h"

#import "MessageCenterViewController.h"

#import "HomeListModel.h"

@interface HomeViewController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate,UIGestureRecognizerDelegate,ReloadNetworkDelegate>
{
    NSMutableArray *_titles;//标题数组
    NSMutableArray *_codes;//标题编码数组
    NSMutableArray *_images;//主分类图片数组
    NSMutableArray *_clickImages;//主分类点击图片数组

    UIView  *_titlesBackView;
    NSInteger _index;
}
@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic, strong) BlackBarrierView *bbv;
@property (nonatomic, strong) BlackBarrierView *bbv2;
@end

@implementation HomeViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNavigationItem];

    _images = [[NSMutableArray alloc] init];
    _clickImages = [[NSMutableArray alloc] init];
    _codes  = [[NSMutableArray alloc] init];
    _titles = [[NSMutableArray alloc] init];
    
    [Helper isHasNetWork:^(BOOL has) {
        if (has) {
            [self loadData];
        }else{
            [NetworkErrorView shared].hidden = NO;
            [NetworkErrorView shared].delegate = self;
            [self.view addSubview:[NetworkErrorView shared]];
        }
    }];
    
}

- (void)loadData{
    
    //获取主分类标题等信息
    [HTTPManager getHomeMainCategoryInfo:^(NSString *code, NSString *msg, NSArray *result) {
        
        if (code.intValue == 200) {
            [_titles addObject:@"推荐"];
            [_images addObject:@"home_btn_clas_recomend"];
            [_clickImages addObject:@"home_btn_clas_recomend_click"];
            
            for (HomeCatetoryModel *model in result) {
                [_titles addObject:model.name];
                [_codes addObject:model.code];
                [_images addObject:model.thumb];
                [_clickImages addObject:model.clickThumb];
            }
            
            [self layoutView];
        }
        
    }];
}

#pragma mark - ReloadNetworkDelegate
- (void)reloadNetwork{
    
    [Helper isHasNetWork:^(BOOL has) {
        if (has) {
            [NetworkErrorView shared].hidden = YES;
            [self loadData];
        }
    }];
    
}

- (void)layoutView{
    
    _index = 300;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width - 30*SProportion_Width, 30*SProportion_Height) titles:_titles delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    self.titleView.backgroundColor = [UIColor whiteColor];
    self.titleView.titleNormalColor = Dark_TextColor;
    self.titleView.titleSelectFont = [UIFont systemFontOfSize:15];
    self.titleView.indicatorExtension = 0;//下方红线延伸长度
    self.titleView.selectIndex = 0;
    [self.view addSubview:_titleView];
    
    //展示全部的button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.userInteractionEnabled = YES;
    button.tag = 200;
    [button setImage:image(@"home_btn_bottomArrow") forState:UIControlStateNormal];
    button.frame = CGRectMake(Screen_Width - 30*SProportion_Width, 0 , 30*SProportion_Width, 30*SProportion_Height);
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitleColor:Light_TextColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    for (NSString *title in _titles) {
        if ([title isEqual:@"推荐"]) {
            MainViewController *vc = [[MainViewController alloc]init];
            [childVCs addObject:vc];
        }else{
            OtherViewController *ovc = [[OtherViewController alloc]init];
            //            ovc.navigationItem.title = title;
            
            //判断数组里是否包含除了推荐 剩下的标题
            if ([_titles containsObject:title]) {
                //取出标题在数组中的索引值 赋给goodsType
                NSInteger index = [_titles indexOfObject:title] - 1;
                ovc.goodsType = index;
                NSLog(@"%@的索引值：%ld",title,index);
                
                ovc.code = _codes[index];
            }
            
            [childVCs addObject:ovc];
        }
        
    }
    
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 30*SProportion_Height, Screen_Width, Screen_Height - 30*SProportion_Height) childVCs:childVCs parentVC:self delegate:self];
    self.pageContentView.contentViewCurrentIndex = 0;
    //    self.pageContentView.contentViewCanScroll = NO;//设置滑动属性
    [self.view addSubview:_pageContentView];
    
    _bbv = [[BlackBarrierView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [self.view addSubview:_bbv];
    _bbv2 = [[BlackBarrierView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 49)];
    [self.tabBarController.tabBar addSubview:_bbv2];
    
    //添加手势
    UITapGestureRecognizer *hiddenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenTapAction:)];
    UITapGestureRecognizer *hiddenTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenTapAction:)];
    [_bbv addGestureRecognizer:hiddenTap];
    [_bbv2 addGestureRecognizer:hiddenTap2];
    
    //创建商品分类底层视图
    _titlesBackView = [[UIView alloc] initWithFrame:CGRectMake(0, -1000, Screen_Width, 70*SProportion_Height + 40*((_titles.count+3)/4)*SProportion_Height)];
    _titlesBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_titlesBackView];
    
    UILabel *allGoodsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, Screen_Width-10, 30*SProportion_Height)];
    allGoodsLabel.userInteractionEnabled = YES;
    allGoodsLabel.text = @"选择分类";
    allGoodsLabel.textAlignment = NSTextAlignmentLeft;
    allGoodsLabel.textColor = Dark_TextColor;
    allGoodsLabel.font = font(16);
    [_titlesBackView addSubview:allGoodsLabel];
    
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.tag = 500;
    cancelBtn.frame = CGRectMake(Screen_Width -10 - 30*SProportion_Width, 0, 30*SProportion_Width, 30*SProportion_Height);
    [cancelBtn setImage:image(@"home_btn_topArrow") forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [allGoodsLabel addSubview:cancelBtn];
    
    //创建商品大分类按钮
    for (int i=0; i<_titles.count; i++){
        
        int x = i%4;
        int y = i/4;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 300+i;
        [button setBackgroundColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_titlesBackView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(80*SProportion_Width*x);
            make.top.equalTo(_titlesBackView).mas_offset(50*SProportion_Height*y + 30*SProportion_Height);
            make.size.mas_equalTo(CGSizeMake(Screen_Width/4, 40*SProportion_Height));
        }];
    
        //图片
        UIImageView *icon = [[UIImageView alloc] init];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        icon.tag = 800+i;
        if (i==0) {
            icon.image = image(@"home_btn_clas_recomend_click");
        }else{
            setNetImage(icon, _images[i], @"");
        }
        [button addSubview:icon];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30*SProportion_Width);
            make.top.equalTo(button);
            make.size.mas_equalTo(CGSizeMake(20*SProportion_Width, 20*SProportion_Width));
        }];
        
        //label
        UILabel *label = [[UILabel alloc] init];
        label.tag = 900+i;
        label.text = _titles[i];
        label.textAlignment = NSTextAlignmentCenter;
        if (i==0) {
            label.textColor = Red_Color;
        }else{
            label.textColor = Dark_TextColor;
        }
        label.font = font(14);
        [button addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(button);
            make.top.equalTo(icon.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(Screen_Width/4, 20*SProportion_Width));
        }];
    }
    
}
//#pragma mark -- 绘制图片
//- (UIImage *)drawPngWithAlpha:(CGFloat)alpha
//{
//    UIColor *color = [UIColor colorWithRed:1 green:1 blue:1 alpha:alpha];
//    //位图大小
//    CGSize size = CGSizeMake(1, 1);
//    //绘制位图
//    UIGraphicsBeginImageContext(size);
//    //获取当前创建的内容
//    CGContextRef contextRef = UIGraphicsGetCurrentContext();
//    //充满指定的填充色
//    CGContextSetFillColorWithColor(contextRef, color.CGColor);
//    //充满指定的矩形
//    CGContextFillRect(contextRef, CGRectMake(0, 0, 1, 1));
//    //绘制image
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    //结束绘制
//    UIGraphicsEndImageContext();
//    return image;
//}
- (void)createNavigationItem{

    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.tag = 100;
    cut(searchBtn, 5);
    [searchBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    searchBtn.frame = CGRectMake(-20*SProportion_Width, 5, 260*SProportion_Width, 30);
    [searchBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 15*SProportion_Width, -3*SProportion_Height, 0)];
    [searchBtn setImage:image(@"home_btn_search") forState:UIControlStateNormal];
    [searchBtn setTitle:@"输入商品名或粘贴淘宝标题" forState:UIControlStateNormal];
    searchBtn.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:142 / 255.0 blue:109/255.0 alpha:1.0];
//    searchBtn.backgroundColor = [UIColor whiteColor];
//    searchBtn.alpha = 0.9f;
    searchBtn.titleLabel.font = font(14);
    [searchBtn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    self.navigationItem.titleView = searchBtn;

    //导航右按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.tag = 600;
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10*SProportion_Width)];
    [rightBtn setImage:image(@"home_btn_message") forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
    
    // --- iOS 11异常处理
    if(@available(iOS 11.0, *)) {
    }

}
- (CAGradientLayer *)gradientLayer {
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc]init];
    // CGColor是无法放入数组中的，必须要转型。
    gradientLayer.colors = @[
                             (__bridge id)[UIColor colorWithRed:236 / 255.0 green:99 / 255.0 blue:56/255.0 alpha:1.0].CGColor,
                             (__bridge id)[UIColor colorWithRed:236 / 255.0 green:84 / 255.0 blue:    46/255.0 alpha:1.0].CGColor,
                             (__bridge id)[UIColor colorWithRed:236 / 255.0 green:69 / 255.0 blue:36/255.0 alpha:1.0].CGColor,
                             ];
    // 颜色分割线
    gradientLayer.locations = @[@0, @0.8,@1.5];
    // 颜色渐变的起点和终点，范围为 (0~1.0, 0~1.0)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, UI_IS_IPHONE_X?-44:-20, self.navigationController.navigationBar.bounds.size.width, (UI_IS_IPHONE_X?44:20) + self.navigationController.navigationBar.bounds.size.height);
    return gradientLayer;
}
#pragma mark --
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.pageContentView.contentViewCurrentIndex = endIndex;
//    self.title = @[@"推荐",@"女装",@"男装",@"鞋子",@"箱包",@"美妆",@"生活",@"家居",@"食品",@"内衣",@"运动",@"数码",@"母婴",@"配饰",@"宠物"][endIndex];
    NSLog(@"点击了第%ld个button，它是：%@",endIndex,_titles[endIndex]);
    
    _index = endIndex + 300;
//    self.delegate = _ovc;
//
//    if (self.delegate && [self.delegate respondsToSelector:@selector(sendGoodsNum:)]) {
//
//        [self.delegate sendGoodsNum:endIndex-1];
//    }else{
//        NSLog(@"设置代理失败");
//    }
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.titleView.selectIndex = endIndex;
//    self.title = @[@"推荐",@"女装",@"男装",@"鞋子",@"箱包",@"美妆",@"生活",@"家居",@"食品",@"内衣",@"运动",@"数码",@"母婴",@"配饰",@"宠物"][endIndex];
    NSLog(@"滑动到第%ld个界面，它是：%@",endIndex,_titles[endIndex]);
    
    _index = endIndex + 300;
}

- (void)typeBtnClick:(UIButton *)button{
    if (button.tag == 100) {
        //跳转搜索界面
        SearchViewController *svc = [[SearchViewController alloc] init];
        [self.navigationController pushViewController:svc animated:NO];

    }else if (button.tag == 200){
        //展示全部商品类
        [_bbv showView];
        [_bbv2 showView];
        
        [UIView animateWithDuration:0.5 animations:^{
            _titlesBackView.frame = CGRectMake(0, 0, Screen_Width, 70*SProportion_Height + 40*((_titles.count+3)/4)*SProportion_Height);
        }];
        
        //设置选中按钮的字体颜色
        for (int i=0; i<_titles.count; i++) {
            if (_index != i+300) {
                UIImageView *icon = [self.view viewWithTag:i+800];
                UILabel *label = [self.view viewWithTag:i+900];
                if (i==0) {
                    icon.image = image(_images[i]);
                }else{
                    setNetImage(icon, _images[i], @"");
                }
                label.textColor = Dark_TextColor;
            }else{
                UIImageView *icon = [self.view viewWithTag:i+800];
                UILabel *label = [self.view viewWithTag:i+900];
                if (i==0) {
                    icon.image = image(_clickImages[i]);
                }else{
                    setNetImage(icon, _clickImages[i], @"");
                }
                label.textColor = Red_Color;
            }
        }
        
    }else if (button.tag>=300 && button.tag < 320){
        //选中了某个商品类
        self.titleView.selectIndex = button.tag - 300;
        self.pageContentView.contentViewCurrentIndex = button.tag - 300;
        
        [UIView animateWithDuration:0.5 animations:^{
            _titlesBackView.frame = CGRectMake(0, -1000, Screen_Width, 70*SProportion_Height + 40*((_titles.count+3)/4)*SProportion_Height);
        }];
        [_bbv dismissView];
        [_bbv2 dismissView];
        
        _index = button.tag;
        //设置选中按钮的字体颜色
        for (int i=0; i<_titles.count; i++) {
            if (_index != i+300) {
                UIImageView *icon = [self.view viewWithTag:i+800];
                UILabel *label = [self.view viewWithTag:i+900];
                setNetImage(icon, _images[i], @"");
                label.textColor = Dark_TextColor;
            }else{
                UIImageView *icon = [self.view viewWithTag:i+800];
                UILabel *label = [self.view viewWithTag:i+900];
                setNetImage(icon, _clickImages[i], @"");
                label.textColor = Red_Color;
            }
        }
        
    }else if (button.tag == 500){
        //取消  移除商品类底层视图
        [UIView animateWithDuration:0.5 animations:^{
            _titlesBackView.frame = CGRectMake(0, -1000, Screen_Width, 70*SProportion_Height + 40*((_titles.count+3)/4)*SProportion_Height);
        }];
        
        [_bbv dismissView];
        [_bbv2 dismissView];
    }else if (button.tag == 600){
        MessageCenterViewController *mcvc = [[MessageCenterViewController alloc] init];
        [self.navigationController pushViewController:mcvc animated:YES];
    }
}
//黑色透明遮挡层响应事件
- (void)hiddenTapAction:(UITapGestureRecognizer *)gesture{
    
    //取消  移除商品类底层视图
    [UIView animateWithDuration:0.5 animations:^{
        _titlesBackView.frame = CGRectMake(0, -1000, Screen_Width, 70*SProportion_Height + 40*((_titles.count+3)/4)*SProportion_Height);
    }];
    
    [_bbv dismissView];
    [_bbv2 dismissView];
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
