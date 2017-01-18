//
//  OrderTableViewCell.h
//  jjrms
//
//  Created by user on 16/9/28.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "OrderModel.h"
#import "Commen.h"
#import "UIColor+Helper.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
@interface OrderTableViewCell : UITableViewCell
@property(nonatomic,retain)UILabel *name;
@property(nonatomic,retain)UILabel *address;
@property(nonatomic,retain)UILabel *money;
@property(nonatomic,retain)UIImageView *homeImg;
@property(nonatomic,retain)UILabel *orderStates;

@property(nonatomic,retain)UIImageView *addressImg;
@property(nonatomic,retain)UILabel *moneyLab;

@property(nonatomic,retain)OrderModel *model;
@end
