//
//  WithdrawalRecordCell.m
//  shopping
//
//  Created by 谷朝阳 on 2017/12/27.
//  Copyright © 2017年 GCY. All rights reserved.
//

#import "WithdrawalRecordCell.h"

@implementation WithdrawalRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCell];
    }
    return self;
}

- (void)createCell{
    
    __weak typeof(self) weakSelf = self;//防止循环引用

    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.text = @"提现";
    textLabel.font = font(17);
    textLabel.textColor = Dark_TextColor;
    textLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:textLabel];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf.contentView).mas_offset(5*SProportion_Width);
        make.size.mas_equalTo(CGSizeMake(40*SProportion_Width, 20*SProportion_Height));
    }];
    
    //状态
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textLabel.mas_right);
        make.top.equalTo(weakSelf.contentView).mas_offset(7.5f*SProportion_Width);
        make.size.mas_equalTo(CGSizeMake(40*SProportion_Width, 15*SProportion_Height));
    }];
    
    //金额
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).mas_offset(-50*SProportion_Width);
        make.top.equalTo(textLabel);
        make.size.mas_equalTo(CGSizeMake(100*SProportion_Width, 20*SProportion_Height));
    }];
    
    //阿里账号
    [self.alipayAccLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textLabel);
        make.top.equalTo(textLabel.mas_bottom).mas_offset(5*SProportion_Height);
        make.size.mas_equalTo(CGSizeMake(120*SProportion_Width, 15*SProportion_Height));
    }];
    
    //时间
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).mas_offset(-10*SProportion_Width);
        make.top.equalTo(self.alipayAccLabel);
        make.size.mas_equalTo(CGSizeMake(120*SProportion_Width, 15*SProportion_Height));
    }];
    
    //横线
    UIView *horLine = [[UIView alloc] initWithFrame:CGRectMake(0, 49*SProportion_Height, Screen_Width, SProportion_Height)];
    horLine.backgroundColor = BackgroundColor;
    [self.contentView addSubview:horLine];
}

- (UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        cut(_stateLabel, 3);
        _stateLabel.text = @"---";
        _stateLabel.font = font(14);
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.textColor = [UIColor whiteColor];
        _stateLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_stateLabel];
    }
    return _stateLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.text = @"---";
        _priceLabel.font = font(17);
        _priceLabel.textColor = Orange_Color;
        _priceLabel.adjustsFontSizeToFitWidth = YES;
        _priceLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_priceLabel];
    }
    return _priceLabel;
}

- (UILabel *)alipayAccLabel{
    if (!_alipayAccLabel) {
        _alipayAccLabel = [[UILabel alloc] init];
        _alipayAccLabel.text = @"---";
        _alipayAccLabel.font = font(14);
        _alipayAccLabel.textColor = Light_TextColor;
        _alipayAccLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_alipayAccLabel];
    }
    return _alipayAccLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"---";
        _timeLabel.font = font(14);
        _timeLabel.textColor = Light_TextColor;
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
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
