//
//  OtherOrdersTableViewCell.h
//  jjrms
//
//  Created by user on 2016/11/17.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "OrderModel.h"
#import "Commen.h"
#import "UIColor+Helper.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
@interface OtherOrdersTableViewCell : UITableViewCell
//2.0
@property(nonatomic,retain)UIImageView *headImg;
@property(nonatomic,retain)UILabel *name;
@property(nonatomic,retain)UILabel *datefirst;
@property(nonatomic,retain)UILabel *address;
@property(nonatomic,retain)UILabel *datedetail;
@property(nonatomic,retain)UILabel *info;
@property(nonatomic,retain)UILabel *money;
@property(nonatomic,retain)UIView *lineView;
@property(nonatomic,retain)UIImageView *homeImg;
@property(nonatomic,retain)OrderModel *model;
@end
