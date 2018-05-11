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
    
    /*
     *  名字的添加
     */
    int w = (int)self.width;
    _areaName = [[UILabel alloc]initWithFrame:CGRectMake(0,0,w, self.height)];
    _areaName.backgroundColor = [UIColor whiteColor];
    _areaName.font = [UIFont systemFontOfSize:14.f];
    _areaName.textColor = TitleBlackCOLOR;
    _areaName.adjustsFontSizeToFitWidth = YES;
    _areaName.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_areaName];
    
}

@end

