//
//  HomesTableViewCell.h
//  jjrms
//
//  Created by user on 2016/11/17.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "Commen.h"
#import "HomeSourceModel.h"
#import "UIColor+Helper.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
@interface HomesTableViewCell : UITableViewCell
@property(nonatomic,retain)UILabel *name;
@property(nonatomic,retain)UILabel *address;
@property(nonatomic,retain)UILabel *info;
@property(nonatomic,retain)UILabel *homeTime;
@property(nonatomic,retain)UIImageView *homeImg;
@property(nonatomic,retain)UIView *lineView;

@property(nonatomic,retain)HomeSourceModel *model;
@end
