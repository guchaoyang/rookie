//
//  FansCell.m
//  shopping
//
//  Created by 谷朝阳 on 2017/12/27.
//  Copyright © 2017年 GCY. All rights reserved.
//

#import "FansCell.h"

@implementation FansCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCell];
    }
    return self;
}

- (void)createCell{
    
    __weak typeof(self) weakSelf = self;//防止循环引用

    //手机号
    [self.phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).mas_offset(10*SProportion_Width);
        make.top.equalTo(weakSelf.contentView).mas_offset(7.5f*SProportion_Width);
        make.size.mas_equalTo(CGSizeMake(100*SProportion_Width, 20*SProportion_Height));
    }];
    
    //粉丝状态
    [self.fansStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneNumLabel.mas_right);
        make.top.equalTo(weakSelf.contentView).mas_offset(10*SProportion_Width);
        make.size.mas_equalTo(CGSizeMake(40*SProportion_Width, 15*SProportion_Height));
    }];
    
    //时间
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).mas_offset(-10*SProportion_Width);
        make.top.equalTo(weakSelf.contentView).mas_offset(10*SProportion_Width);
        make.size.mas_equalTo(CGSizeMake(120*SProportion_Width, 15*SProportion_Height));
    }];
}

- (UILabel *)phoneNumLabel{
    if (!_phoneNumLabel) {
        _phoneNumLabel = [[UILabel alloc] init];
        _phoneNumLabel.text = @"---";
        _phoneNumLabel.font = font(17);
        _phoneNumLabel.textColor = Dark_TextColor;
        _phoneNumLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_phoneNumLabel];
    }
    return _phoneNumLabel;
}

- (UILabel *)fansStateLabel{
    if (!_fansStateLabel) {
        _fansStateLabel = [[UILabel alloc] init];
        cut(_fansStateLabel, 3);
        _fansStateLabel.text = @"---";
        _fansStateLabel.font = font(14);
        _fansStateLabel.textAlignment = NSTextAlignmentCenter;
        _fansStateLabel.textColor = [UIColor whiteColor];
        _fansStateLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_fansStateLabel];
    }
    return _fansStateLabel;
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
