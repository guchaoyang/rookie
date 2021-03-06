//
//  ViewController.m
//  shopping
//
//  Created by 谷朝阳 on 2017/12/7.
//  Copyright © 2017年 GCY. All rights reserved.
//

#import "ViewController.h"
#import "TabBarController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView  *baseScrollView;

@property (nonatomic,strong)UIPageControl *pageControl;

@property (nonatomic,strong)NSArray       *guideViewArray;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackgroundColor;
    
    [self createGuidePage];
    
}

- (void)createGuidePage{
    
    for (int i = 0; i < self.guideViewArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width*i, 0, Screen_Width, Screen_Height)];
        imageView.image = [UIImage imageNamed:self.guideViewArray[i]];
        [self.baseScrollView addSubview:imageView];
    }
    
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (UI_IS_IPHONE_X) {
        startBtn.frame = CGRectMake(Screen_Width * (self.guideViewArray.count-1) + 90*SProportion_Width, 620*SProportion_Height, 150*SProportion_Width, 40*SProportion_Height);
    }else{
        startBtn.frame = CGRectMake(Screen_Width * (self.guideViewArray.count-1) + 90*SProportion_Width, 500*SProportion_Height, 150*SProportion_Width, 40*SProportion_Height);
    }
    [startBtn setImage:image(@"btn_guide_start") forState:UIControlStateNormal];
//    startBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.baseScrollView addSubview:startBtn];
    
    self.baseScrollView.contentSize = CGSizeMake(Screen_Width*self.guideViewArray.count, Screen_Height);
}

//翻页
- (void)nextPage{
    static int num = 1;
    if (num < self.guideViewArray.count) {
        self.baseScrollView.contentOffset = CGPointMake(Screen_Width*num, 0);
        num ++;
    }
    NSLog(@"%f",self.baseScrollView.contentOffset.x);
}

- (void)startBtnClick{
    
    [UserDefaultUtil saveValue:@"NO" forKey:IS_FIRST];
    // 切换到rootViewController!
    [UIView animateWithDuration:0.5 animations:^{
        //        _baseview.alpha = 0;
        //        _baseScrollView.alpha = 0;
        //        _pageControl.alpha = 0;
    } completion:^(BOOL finished) {
        [self.baseScrollView removeFromSuperview];
//        [self.pageControl removeFromSuperview];
        
        self.view.window.rootViewController = [[TabBarController alloc] init];
    }];
}

////小白点变换
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    if (scrollView == self.baseScrollView) {
//        CGPoint pt = self.baseScrollView.contentOffset;
//        self.pageControl.currentPage = pt.x / Screen_Width;
//    }
//}

- (BOOL)prefersStatusBarHidden
{
    return YES;// 返回YES表示隐藏，返回NO表示显示
}

- (UIScrollView *)baseScrollView{
    if (_baseScrollView == nil) {
        _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        _baseScrollView.showsHorizontalScrollIndicator = NO;
        _baseScrollView.showsVerticalScrollIndicator = NO;
        _baseScrollView.delegate = self;
        _baseScrollView.backgroundColor = [UIColor whiteColor];
        _baseScrollView.pagingEnabled = YES;
        _baseScrollView.bounces = NO;
        _baseScrollView.scrollEnabled = NO;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextPage)];
        [_baseScrollView addGestureRecognizer:gesture];
        [self.view addSubview:_baseScrollView];
    }
    return _baseScrollView;
}

//- (UIPageControl *)pageControl{
//    if (_pageControl == nil) {
//        //初始化pageControl
//        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(145*SProportion_Width, 490*SProportion_Height, 30*SProportion_Width, 15*SProportion_Height)];
//        //只有一个小点隐藏
//        _pageControl.hidesForSinglePage = YES;
//        //当前小点颜色
//        _pageControl.currentPageIndicatorTintColor = Blue_TextColor;
//        //设置其他小点颜色
//        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0xd5 / 255.0 green:0xd5 / 255.0 blue:0xd5 / 255.0 alpha:1];
//        _pageControl.numberOfPages = self.guideViewArray.count;
//        [self.view addSubview:_pageControl];
//    }
//    return _pageControl;
//}

- (NSArray *)guideViewArray{
    if (_guideViewArray == nil) {
        if (Screen_Height == 568) {
            //当前为iPhone 5/5c/5s
            _guideViewArray = @[@"img_guide_4inch_0", @"img_guide_4inch_1", @"img_guide_4inch_2", @"img_guide_4inch_3", @"img_guide_4inch_4"];
        }else if (Screen_Height == 667){
            //当前为iPhone6/6s iPhone7 iPhone8
            _guideViewArray = @[@"img_guide_4.7inch_0", @"img_guide_4.7inch_1", @"img_guide_4.7inch_2", @"img_guide_4.7inch_3", @"img_guide_4.7inch_4"];
        }else if (Screen_Height == 736){
            //当前为iPhone6 Plus/iPhone6s Plus iPhone7 Plus/iPhone8 Plus
            _guideViewArray = @[@"img_guide_5.5inch_0", @"img_guide_5.5inch_1", @"img_guide_5.5inch_2", @"img_guide_5.5inch_3", @"img_guide_5.5inch_4"];
        }else if (Screen_Height == 812){
            //当前为iPhone X
            _guideViewArray = @[@"img_guide_5.8inch_0", @"img_guide_5.8inch_1", @"img_guide_5.8inch_2", @"img_guide_5.8inch_3", @"img_guide_5.8inch_4"];
        }
    }
    return _guideViewArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

