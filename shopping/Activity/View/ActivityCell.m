//
//  ActivityCell.m
//  shopping
//
//  Created by 谷朝阳 on 2017/12/10.
//  Copyright © 2017年 GCY. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCell];
    }
    return self;
}

- (void)createCell{
    
//    self.contentView.backgroundColor = [UIColor redColor];
    
    [self.activityPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(5*SProportion_Width);
        make.top.equalTo(self.contentView).mas_offset(5*SProportion_Height);
        make.right.mas_equalTo(-5*SProportion_Width);
        make.height.mas_equalTo(130*SProportion_Height);
    }];
    
    
    //分割线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = BackgroundColor;
    [self.contentView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_bottom).mas_offset(-5*SProportion_Height);
        make.height.mas_equalTo(5*SProportion_Height);

    }];
    
    [self.pageViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_activityPic.mas_left).mas_offset(5*SProportion_Width);
        make.top.equalTo(_activityPic.mas_bottom).mas_offset(2.5f*SProportion_Height);
        make.size.mas_equalTo(CGSizeMake(70*SProportion_Width, 15*SProportion_Height));
        
    }];
    
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_activityPic.mas_right).mas_offset(-5*SProportion_Width);
        make.top.equalTo(self.pageViewButton);
        make.size.mas_equalTo(CGSizeMake(70*SProportion_Width, 15*SProportion_Height));
        
    }];
    
    
}

- (UIImageView *)activityPic{
    if (!_activityPic) {
        _activityPic = [[UIImageView alloc] init];
        [self.contentView addSubview:_activityPic];
    }
    return _activityPic;
}

- (UIButton *)pageViewButton{
    if (!_pageViewButton) {
        _pageViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pageViewButton setTitleColor:Dark_TextColor forState:UIControlStateNormal];
        [_pageViewButton setImage:image(@"activity_btn_visits") forState:UIControlStateNormal];
        _pageViewButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _pageViewButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:_pageViewButton];
        
        [_pageViewButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5*SProportion_Width];
    }
    return _pageViewButton;
}

- (UIButton *)likeButton{
    if (!_likeButton) {
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeButton setTitleColor:Dark_TextColor forState:UIControlStateNormal];
        [_likeButton setImage:image(@"activity_btn_good") forState:UIControlStateNormal];
        _likeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _likeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.contentView addSubview:_likeButton];
        
        [_likeButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5*SProportion_Width];
    }
    return _likeButton;
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