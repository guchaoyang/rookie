//
//  ActivityCell.h
//  shopping
//
//  Created by 谷朝阳 on 2017/12/10.
//  Copyright © 2017年 GCY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCell : UITableViewCell

@property(nonatomic, strong)UIImageView *activityPic;

@property(nonatomic, retain)UIButton    *pageViewButton;//访问量

@property(nonatomic, retain)UIButton    *likeButton;//点赞

@end
