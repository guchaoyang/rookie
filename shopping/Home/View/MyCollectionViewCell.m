//
//  MyCollectionViewCell.m
//  shopping
//
//  Created by 谷朝阳 on 2017/12/11.
//  Copyright © 2017年 GCY. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self layout];
    }
    
    return self;
}

-(void)layout{
    ///正方形图片
    [self.goodsPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(145*SProportion_Width);
    }];
    //商品名称
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.goodsPic.mas_bottom).mas_offset(3*SProportion_Height);
        make.height.mas_equalTo(25*SProportion_Height);
    }];
    //价格
    [self.goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsName);
        make.top.equalTo(self.goodsName.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(80*SProportion_Width, 20*SProportion_Height));
    }];
    //销量
    [self.soldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.goodsName);
        make.top.equalTo(self.goodsPrice);
        make.size.mas_equalTo(CGSizeMake(80*SProportion_Width, 20*SProportion_Height));
    }];
    
    //券后价图片
    [self.couponPriceImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsName);
        make.top.equalTo(self.goodsPrice.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(30*SProportion_Width, 15*SProportion_Height));
    }];
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = font(10);
    textLabel.text = @"券后价";
    textLabel.textColor = [UIColor whiteColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.adjustsFontSizeToFitWidth = YES;
    [self.couponPriceImage addSubview:textLabel];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.couponPriceImage);
    }];
    
    
    //券后价价格
    [self.couponPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.couponPriceImage.mas_right).mas_offset(5*SProportion_Width);
        make.top.equalTo(self.couponPriceImage);
        make.size.mas_equalTo(CGSizeMake(80*SProportion_Width, 15*SProportion_Height));
    }];
    
    //优惠券背景图片
    [self.contentView addSubview:self.couponImage];
    
    [self.couponImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.goodsName);
        make.top.equalTo(self.couponPrice);
        make.size.mas_equalTo(CGSizeMake(45*SProportion_Width, 15*SProportion_Height));
    }];
    
    
    [self.couponImage addSubview:self.couponLabel];
    //券价格
    [self.couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.couponImage);
    }];
    
    //失效遮罩
    [self.imageMatte mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.goodsPic);
    }];
    //长条文字
    [self.invalidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.mas_equalTo(55*SProportion_Height);
        make.height.mas_equalTo(20*SProportion_Height);
    }];
    //失效标签
    [self.invalidTags mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.goodsName);
        make.top.equalTo(self.couponPrice);
        make.size.mas_equalTo(CGSizeMake(40*SProportion_Width, 15*SProportion_Height));
    }];
}

- (UIImageView *)goodsPic{
    if (!_goodsPic) {
        _goodsPic = [[UIImageView alloc] init];
        /*UIViewContentModeScaleAspectFit 这个图片都会在view里面显示，并且比例不变 这就是说 如果图片和view的比例不一样 就会有留白
         UIViewContentModeScaleAspectFill 这是整个view会被图片填满，图片比例不变 ，这样图片显示就会大于view
         */
        _goodsPic.contentMode = UIViewContentModeScaleAspectFill;
        _goodsPic.clipsToBounds = YES;
        cut(_goodsPic, 3);
        [self.contentView addSubview:_goodsPic];
    }
    return _goodsPic;
}

- (UIImageView *)couponPriceImage{
    if (!_couponPriceImage) {
        _couponPriceImage = [[UIImageView alloc] init];
        _couponPriceImage.image = image(@"home_img_priceLeft");
        [self.contentView addSubview:_couponPriceImage];
    }
    return _couponPriceImage;
}

- (UIImageView *)couponImage{
    if (!_couponImage) {
        _couponImage = [[UIImageView alloc] init];
        _couponImage.image = image(@"home_img_couponBack");
        [self.contentView addSubview:_couponImage];
    }
    return _couponImage;
}

- (UIView *)imageMatte{
    if (!_imageMatte) {
        _imageMatte = [[UIView alloc] init];
        _imageMatte.backgroundColor = customColor(@"#666666");
        _imageMatte.alpha = 0.3f;
        _imageMatte.hidden = YES;
        [self.contentView addSubview:_imageMatte];
    }
    return _imageMatte;
}

- (UILabel *)goodsName{
    if (!_goodsName) {
        _goodsName = [[UILabel alloc] init];
        _goodsName.font = font(12);
        _goodsName.textColor = Dark_TextColor;
        _goodsName.numberOfLines = 0;
//        _goodsName.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_goodsName];
    }
    return _goodsName;
}

- (UILabel *)goodsPrice{
    if (!_goodsPrice) {
        _goodsPrice = [[UILabel alloc] init];
        _goodsPrice.font = font(12);
        _goodsPrice.adjustsFontSizeToFitWidth = YES;
        _goodsPrice.textColor = Light_TextColor;
        [self.contentView addSubview:_goodsPrice];
    }
    return _goodsPrice;
}


- (UILabel *)soldLabel{
    if (!_soldLabel) {
        _soldLabel = [[UILabel alloc] init];
        _soldLabel.font = font(12);
        _soldLabel.textColor = Light_TextColor;
        _soldLabel.textAlignment = NSTextAlignmentRight;
        _soldLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_soldLabel];
    }
    return _soldLabel;
}

//券后价
- (UILabel *)couponPrice{
    if (!_couponPrice) {
        _couponPrice = [[UILabel alloc] init];
        _couponPrice.font = font(16);
        _couponPrice.textColor = [UIColor redColor];
        _couponPrice.textAlignment = NSTextAlignmentLeft;
        _couponPrice.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_couponPrice];
    }
    return _couponPrice;
}

//券
- (UILabel *)couponLabel{
    if (!_couponLabel) {
        _couponLabel = [[UILabel alloc] init];
        _couponLabel.font = font(12);
        _couponLabel.textColor = [UIColor whiteColor];
        _couponLabel.textAlignment = NSTextAlignmentCenter;
        _couponLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _couponLabel;
}

- (UILabel *)invalidLabel{
    if (!_invalidLabel) {
        _invalidLabel = [[UILabel alloc] init];
        _invalidLabel.font = font(13);
        _invalidLabel.text = @"失效商品";
        _invalidLabel.backgroundColor = Light_TextColor;
        _invalidLabel.textColor = [UIColor whiteColor];
        _invalidLabel.textAlignment = NSTextAlignmentCenter;
        _invalidLabel.adjustsFontSizeToFitWidth = YES;
        _invalidLabel.hidden = YES;
        [self.contentView addSubview:_invalidLabel];
    }
    return _invalidLabel;
}

- (UILabel *)invalidTags{
    if (!_invalidTags) {
        _invalidTags = [[UILabel alloc] init];
        cut(_invalidTags, 7.5f*SProportion_Height);
        _invalidTags.text = @"失效";
        _invalidTags.font = font(12);
        _invalidTags.backgroundColor = customColor(@"#CCCCCC");
        _invalidTags.textColor = [UIColor whiteColor];
        _invalidTags.textAlignment = NSTextAlignmentCenter;
        _invalidTags.adjustsFontSizeToFitWidth = YES;
        _invalidTags.hidden = YES;
        [self.contentView addSubview:_invalidTags];
    }
    return _invalidTags;
}

@end
