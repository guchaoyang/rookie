//
//  OrderDetailCell.m
//  shopping
//
//  Created by 谷朝阳 on 2017/12/27.
//  Copyright © 2017年 GCY. All rights reserved.
//

#import "OrderDetailCell.h"

@implementation OrderDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCell];
    }
    return self;
}

- (void)createCell{
    //图片
    [self.goodsPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(10*SProportion_Width);
        make.top.equalTo(self.contentView).mas_offset(10*SProportion_Height);
        make.size.mas_equalTo(CGSizeMake(80*SProportion_Height, 80*SProportion_Height));
    }];
    
    //名称
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsPic.mas_right).mas_offset(10*SProportion_Width);
        make.top.equalTo(self.goodsPic);
        make.right.equalTo(self.contentView).mas_offset(-60*SProportion_Width);
        make.height.mas_equalTo(40*SProportion_Height);
    }];
    
    //价格
    [self.goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsPic.mas_right).mas_offset(10*SProportion_Width);
        make.top.equalTo(self.goodsName.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(100*SProportion_Width, 20*SProportion_Height));
    }];
    
    //收入
    [self.goodsIncomePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsName.mas_bottom);
        make.right.equalTo(self.contentView).mas_offset(-30*SProportion_Width);
        make.size.mas_equalTo(CGSizeMake(80*SProportion_Width, 20*SProportion_Height));
    }];
    
    //创建时间
    [self.createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsPrice.mas_bottom);
        make.left.equalTo(self.goodsPic.mas_right).mas_offset(10*SProportion_Width);
        make.size.mas_equalTo(CGSizeMake(200*SProportion_Width, 20*SProportion_Height));
    }];
    
    //订单状态
    [self.orderStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsName.mas_right).mas_offset(5*SProportion_Width);
        make.top.equalTo(self.goodsPic).mas_offset(5*SProportion_Height);
        make.right.equalTo(self.contentView).mas_offset(-10*SProportion_Width);
        make.height.mas_equalTo(15*SProportion_Height);
    }];
    
    //横线
    UIView *horLine = [[UIView alloc] initWithFrame:CGRectMake(0, 100*SProportion_Height, Screen_Width, 5*SProportion_Height)];
    horLine.backgroundColor = BackgroundColor;
    [self.contentView addSubview:horLine];
}

- (UIImageView *)goodsPic{
    if (!_goodsPic) {
        _goodsPic = [[UIImageView alloc] init];
        _goodsPic.image = image(@"activity_test.jpg");
        [self.contentView addSubview:_goodsPic];
    }
    return _goodsPic;
}

- (UILabel *)goodsName{
    if (!_goodsName) {
        _goodsName = [[UILabel alloc] init];
        _goodsName.text = @"-------";
        _goodsName.font = font(15);
        _goodsName.numberOfLines = 0;
        _goodsName.textColor = Dark_TextColor;
        _goodsName.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_goodsName];
    }
    return _goodsName;
}

- (UILabel *)goodsPrice{
    if (!_goodsPrice) {
        _goodsPrice = [[UILabel alloc] init];
        _goodsPrice.text = @"---";
        _goodsPrice.font = font(14);
        _goodsPrice.textColor = Dark_TextColor;
        _goodsPrice.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_goodsPrice];
    }
    return _goodsPrice;
}

- (UILabel *)goodsIncomePrice{
    if (!_goodsIncomePrice) {
        _goodsIncomePrice = [[UILabel alloc] init];
        _goodsIncomePrice.text = @"---";
        _goodsIncomePrice.font = font(14);
        _goodsIncomePrice.textColor = Dark_TextColor;
        _goodsIncomePrice.textAlignment = NSTextAlignmentRight;
        _goodsIncomePrice.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_goodsIncomePrice];
    }
    return _goodsIncomePrice;
}

- (UILabel *)createTimeLabel{
    if (!_createTimeLabel) {
        _createTimeLabel = [[UILabel alloc] init];
        _createTimeLabel.text = @"---";
        _createTimeLabel.font = font(14);
        _createTimeLabel.textColor = Light_TextColor;
        _createTimeLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_createTimeLabel];
    }
    return _createTimeLabel;
}

- (UILabel *)orderStateLabel{
    if (!_orderStateLabel) {
        _orderStateLabel = [[UILabel alloc] init];
        _orderStateLabel.text = @"---";
        _orderStateLabel.font = font(14);
        _orderStateLabel.textColor = [UIColor whiteColor];
        _orderStateLabel.textAlignment = NSTextAlignmentCenter;
        cut(_orderStateLabel, 3);
        _orderStateLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_orderStateLabel];
    }
    return _orderStateLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
