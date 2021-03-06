//
//  JKAreaCollectionViewCell.m
//  CIO领域demo
//
//  Created by 王冲 on 2017/11/14.
//  Copyright © 2017年 希爱欧科技有限公司. All rights reserved.
//

#import "JKAreaCollectionViewCell.h"

@implementation JKAreaCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self layout];
    }
    
    return self;
}

-(void)layout{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    cut(self, 10);
    
    int w = (int)self.width;
    /*
     *  图片的添加
     */
    _iconImage = [[UIImageView alloc]initWithFrame:CGRectMake((w-55)/2, 5, 55, 55)];
    _iconImage.contentMode = UIViewContentModeScaleAspectFill;
    _iconImage.alpha = 1;
    [self.contentView addSubview:_iconImage];
    
    /*
     *  名字的添加
     */
    
    _areaName = [[UILabel alloc]initWithFrame:CGRectMake(0,75,w, self.height-75)];
    _areaName.backgroundColor = [UIColor whiteColor];
    _areaName.font = [UIFont systemFontOfSize:14.f];
    _areaName.textColor = TitleBlackCOLOR;
    _areaName.adjustsFontSizeToFitWidth = YES;
    _areaName.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_areaName];
    
}

@end

