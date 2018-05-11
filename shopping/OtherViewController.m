//
//  OtherViewController.m
//  shopping
//
//  Created by 谷朝阳 on 2017/12/7.
//  Copyright © 2017年 GCY. All rights reserved.
//

#import "OtherViewController.h"

#import "MyCollectionViewCell.h"

#import "MyCollectionReusableView.h"

@interface OtherViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView *collectionView;

@property(nonatomic, strong)NSArray          *goodsNameArray;

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"中海智融";

//    self.view.backgroundColor = [self randomColor];

    _goodsNameArray = @[@"兑换金币",@"淘宝订单",@"我的收藏",@"我的足迹",@"意见反馈",@"清理缓存",@"收货地址",@"退出登录"];
    [self layoutView];
}

- (void)layoutView{
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view).mas_offset(-49-64);
    }];
}

//- (UIColor*) randomColor{
//    NSInteger r = arc4random() % 255;
//    NSInteger g = arc4random() % 255;
//    NSInteger b = arc4random() % 255;
//    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
//}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 8;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    [cell.goodsPic sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512993522688&di=62c10649bfca99dc4de552a96c5affcf&imgtype=0&src=http%3A%2F%2Fpic31.photophoto.cn%2F20140608%2F0021033853003391_b.jpg"] placeholderImage:image(@"")];
    cell.goodsName.text = @"南极峰冬季新款加厚羽绒服女士中长款修身时尚外套白";
    cell.goodsPrice.text = @"￥999.0";
    cell.soldLabel.text = @"已售199件";

    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(145*SProportion_Width, 200*SProportion_Height);
}

//footer的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(Screen_Width, 10);
//}

//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(Screen_Width, 120*SProportion_Height);
    }else{
        return CGSizeMake(Screen_Width, 30*SProportion_Height);
    }
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10*SProportion_Width;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10*SProportion_Height;
}


//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"heardID" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor whiteColor];
        //最后8个功能按钮
        for (int i=0; i<8; i++){
            UIButton *button = [headerView viewWithTag:100+i];
            if (button == nil) {
                
                for (int i=0; i<8; i++){
                    
                    int x = i%4;
                    int y = i/4;
                    
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.tag = 100+i;
                    [button setBackgroundColor:[UIColor whiteColor]];
                    [button setImage:image(@"test") forState:UIControlStateNormal];
                    [button setTitle:_goodsNameArray[i] forState:UIControlStateNormal];
                    [button setTitleColor:Dark_TextColor forState:UIControlStateNormal];
                    button.titleLabel.font = font(12);
                    [button addTarget:self action:@selector(buttonTypeClick:) forControlEvents:UIControlEventTouchUpInside];
                    [headerView addSubview:button];
                    
                    [button mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(80*SProportion_Width*x);
                        make.top.mas_offset(60*SProportion_Height*y);
                        make.size.mas_equalTo(CGSizeMake(80*SProportion_Width, 60*SProportion_Height));
                    }];
                    
                    [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
                }
            }
        }
        
        
        return headerView;
        
    }if (indexPath.section == 1) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"heardID2" forIndexPath:indexPath];
        headerView.backgroundColor =[UIColor whiteColor];
        
        for (int i=0; i<4; i++){
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 200+i;
            [button setBackgroundColor:[UIColor whiteColor]];
            [button setTitle:@"最新" forState:UIControlStateNormal];
            [button setTitleColor:Dark_TextColor forState:UIControlStateNormal];
            button.titleLabel.font = font(13);
            [button addTarget:self action:@selector(buttonTypeClick:) forControlEvents:UIControlEventTouchUpInside];
            [headerView addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(80*SProportion_Width*i);
                make.top.equalTo(headerView);
                make.size.mas_equalTo(CGSizeMake(80*SProportion_Width, 30*SProportion_Height));
            }];
        
    }
        return headerView;
    }
    return nil;

}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
}

- (void)buttonTypeClick:(UIButton *)button{
    if (button.tag == 100) {
        
    }else if (button.tag == 101){
        
    }else if (button.tag == 102){
        
    }else if (button.tag == 103){
        
    }else if (button.tag == 104){
        
    }else if (button.tag == 105){
        
    }else if (button.tag == 106){
        
    }else if (button.tag == 107){
        
    }else if (button.tag == 200){
        
    }else if (button.tag == 201){
        
    }else if (button.tag == 202){
        
    }else if (button.tag == 203){
        
    }
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.sectionHeadersPinToVisibleBounds = YES;
        
        //2.初始化collectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        [self.view addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
        
        //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致
        [_collectionView registerClass:[MyCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"heardID"];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"heardID2"];
        
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        
    }
    return _collectionView;
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
