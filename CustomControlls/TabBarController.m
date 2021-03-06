//
//  TabBarController.m
//  niuniu
//
//  Created by 成都牛牛优选信息科技有限公司 on 2017/4/19.
//  Copyright © 2017年 成都牛牛优选信息科技有限公司. All rights reserved.
//

#import "TabBarController.h"

#import "HomeViewController.h"

#import "MyViewController.h"

#import "ActivityViewController.h"

#import "CustomerViewController.h"


@interface TabBarController () <UITabBarControllerDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createViewControllers];
    
}
- (void)dealloc{
    
}

- (void)createViewControllers{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    HomeViewController *fvc = [[HomeViewController alloc] init];
    
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:fvc];
    nav.tabBarItem.image = [UIImage imageNamed:@"img_tabbar_home"];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:@"img_tabbar_home_selected"];
    nav.tabBarItem.title = @"首页";
    /*---*/
    
    CustomerViewController *pvc = [[CustomerViewController alloc] init];
    
    NavigationController *nav_1 = [[NavigationController alloc] initWithRootViewController:pvc];
    nav_1.tabBarItem.image = [UIImage imageNamed:@"img_tabbar_classify"];
    nav_1.tabBarItem.selectedImage = [UIImage imageNamed:@"img_tabbar_classify_selected"];
    nav_1.tabBarItem.title = @"分类";
    /*---*/
    
    ActivityViewController *rvc = [[ActivityViewController alloc] init];
    
    NavigationController *nav_3 = [[NavigationController alloc] initWithRootViewController:rvc];
    nav_3.tabBarItem.image = [UIImage imageNamed:@"img_tabbar_activity"];
    nav_3.tabBarItem.selectedImage = [UIImage imageNamed:@"img_tabbar_activity_selected"];
    nav_3.tabBarItem.title = @"活动";
    /*---*/
    
    MyViewController *mvc = [[MyViewController alloc] init];
    
    NavigationController *nav_4 = [[NavigationController alloc] initWithRootViewController:mvc];
    nav_4.tabBarItem.image = [UIImage imageNamed:@"img_tabbar_my"];
    nav_4.tabBarItem.selectedImage = [UIImage imageNamed:@"img_tabbar_my_selected"];
    nav_4.tabBarItem.title = @"个人";
    /*---*/
    
    
    self.viewControllers = @[nav,nav_1,nav_3,nav_4];
    
    self.delegate = self;
    self.tabBar.tintColor = [UIColor redColor];
    self.selectedIndex = 0;
    self.tabBar.translucent = NO;//设置为不透明
//    self.tabBarItem.imageInsets = UIEdgeInsetsMake(10, 0, -10, 0);
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -3)];//文字向上偏移3个像素
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont   systemFontOfSize:12],NSForegroundColorAttributeName:Light_TextColor}   forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:Red_Color} forState:UIControlStateSelected];
}


/**
 
 判断点击了哪个视图
 */
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSInteger index = tabBarController.selectedIndex;
    if (index == 2) {
        
    }
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
