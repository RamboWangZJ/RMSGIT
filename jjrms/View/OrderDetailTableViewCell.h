//
//  OrderDetailTableViewCell.h
//  jjrms
//
//  Created by user on 16/10/8.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "OrderDetailModel.h"
#import "OrderNoDealModel.h"
#import "Commen.h"
#import "UIColor+Helper.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
@interface OrderDetailTableViewCell : UITableViewCell
@property(nonatomic,retain)UILabel *detail;
@property(nonatomic,retain)UILabel *date;

@property(nonatomic,retain)UILabel *money;
@property(nonatomic,retain)UILabel *moneyRed;
@property(nonatomic,retain)UILabel *danwei;

@property(nonatomic,retain)UILabel *name;
@property(nonatomic,retain)UILabel *tel;
@property(nonatomic,retain)UIButton *telBut;

@property(nonatomic,retain)UIImageView *ota;

@property(nonatomic,retain)OrderDetailModel *model;
@end
