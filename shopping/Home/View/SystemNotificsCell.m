//
//  SystemNotificsCell.m
//  shopping
//
//  Created by 谷朝阳 on 2018/1/25.
//  Copyright © 2018年 GCY. All rights reserved.
//

#import "SystemNotificsCell.h"

@implementation SystemNotificsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCell];
    }
    return self;
}

- (void)createCell{
    __weak typeof(self) weakSelf = self;//防止循环引用
    
    weakSelf.backgroundColor = BackgroundColor;

    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.contentView);
        make.top.mas_equalTo(10*SProportion_Height);
        make.height.mas_equalTo(20*SProportion_Height);
    }];
    
    //内容白色底层
}

- (void)setDetailString:(NSString *)detailString{
    
    UIView *whiteView = [[UIView alloc] init];
    cut(whiteView, 5);
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:whiteView];
    
    CGSize size = [Helper calculateTheSizeOfTheText:detailString :14 :280*SProportion_Width];
    
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(10*SProportion_Width);
        make.right.equalTo(self.contentView).mas_offset(-10*SProportion_Width);
        make.top.equalTo(self.dateLabel.mas_bottom);
        make.height.mas_equalTo(size.height + 40*SProportion_Height);
    }];
    
    //标题
    [whiteView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteView).mas_offset(10*SProportion_Width);
        make.top.mas_equalTo(5*SProportion_Height);
        make.size.mas_equalTo(CGSizeMake(300, 20*SProportion_Height));
    }];
    
    //通知内容
    [whiteView addSubview:self.detailLabel];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.right.equalTo(whiteView).mas_offset(-10*SProportion_Width);
        make.top.equalTo(_titleLabel.mas_bottom);
        make.height.mas_equalTo(size.height);
    }];
}

- (UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = font(13);
        _dateLabel.textColor = Light_TextColor;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_dateLabel];
    }
    return _dateLabel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = font(15);
        _titleLabel.textColor = Dark_TextColor;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
//        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = font(14);
        _detailLabel.textColor = customColor(@"666666");
        _detailLabel.numberOfLines = 0;
        _detailLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _detailLabel;
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
