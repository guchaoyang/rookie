//
//  BlackBarrierView.m
//  shopping
//
//  Created by 成都牛牛优选信息科技有限公司 on 2017/12/14.
//  Copyright © 2017年 成都牛牛优选信息科技有限公司. All rights reserved.
//

#import "BlackBarrierView.h"

@implementation BlackBarrierView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutAllSubviews];
    }
    return self;
}

- (void)layoutAllSubviews{
    
    /*创建灰色背景*/
//    self = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    self.alpha = 0.5f;
    self.hidden = YES;
    self.backgroundColor = [UIColor blackColor];
    
    
    /*添加手势事件,移除View*/
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissContactView:)];
//    [self addGestureRecognizer:tapGesture];
    
//    /*创建显示View*/
//    _contentView = [[UIView alloc] init];
//    _contentView.frame = CGRectMake(0, 0, self.frame.size.width - 40, 180);
//    _contentView.backgroundColor=[UIColor whiteColor];
//    _contentView.layer.cornerRadius = 4;
//    _contentView.layer.masksToBounds = YES;
//    [self addSubview:_contentView];
//    /*可以继续在其中添加一些View 虾米的*/
    
}

#pragma mark - 手势点击事件,移除View
//- (void)dismissContactView:(UITapGestureRecognizer *)tapGesture{
//
//    [self dismissView];
//}

-(void)dismissView
{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha = 0.5f;
    } completion:^(BOOL finished) {
//        [weakSelf removeFromSuperview];
        weakSelf.hidden = YES;
    }];
}

// 这里加载在了window上
-(void)showView
{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha = 0.5f;
    } completion:^(BOOL finished) {
        weakSelf.hidden = NO;
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
