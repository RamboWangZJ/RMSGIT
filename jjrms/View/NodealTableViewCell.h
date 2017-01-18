//
//  NodealTableViewCell.h
//  jjrms
//
//  Created by user on 16/10/9.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "OrderNoDealModel.h"
#import "Commen.h"
#import "UIColor+Helper.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
@interface NodealTableViewCell : UITableViewCell
@property(nonatomic, retain)UIButton *checkBut;
@property(nonatomic,retain)UILabel *detail;
@property(nonatomic,retain)UILabel *date;

@property(nonatomic,retain)UILabel *money;
@property(nonatomic,retain)UILabel *moneyRed;
@property(nonatomic,retain)UILabel *danwei;


@property(nonatomic,retain)UIImageView *ota;

@property(nonatomic,retain)OrderNoDealModel *model;
@end
