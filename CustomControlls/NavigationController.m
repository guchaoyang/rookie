//
//  NavigationController.m
//  niuniu
//
//  Created by 谷朝阳 on 2017/4/19.
//  Copyright © 2017年 谷朝阳. All rights reserved.
//

#import "NavigationController.h"

//#import "UIColor+stringColor.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO;
//    self.navigationBar.barTintColor = customColor(@"38393e");//灰色38393e
//    self.navigationBar.barTintColor = [UIColor colorWithRed:236 / 255.0 green:99 / 255.0 blue:56/255.0 alpha:1.0];

    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];//设置系统默认二级界面返回的字体颜色
//    //设置导航标题的属性
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize:17]}];
////
    self.navigationBar.barStyle = UIBarStyleBlack;//设置状态栏的字体颜色

    // 去掉导航栏底部的线
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_img_navBackground"] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setShadowImage:[UIImage new]]; 
    //渐变 atIndex为0 择为图层的最底层
//    [self.navigationBar.layer insertSublayer:[self gradientLayer] atIndex:1];
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
    gradientLayer.frame = CGRectMake(0, UI_IS_IPHONE_X?-44:-20, self.navigationBar.bounds.size.width, (UI_IS_IPHONE_X?44:20) + self.navigationBar.bounds.size.height);
    return gradientLayer;
}



// 处理tabbar的显示隐藏
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES; //viewController是将要被push的控制器
    }
    [super pushViewController:viewController animated:animated];
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
