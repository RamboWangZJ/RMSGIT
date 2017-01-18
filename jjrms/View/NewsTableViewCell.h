//
//  NewsTableViewCell.h
//  jjrms
//
//  Created by user on 16/10/24.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "Commen.h"
#import "UIColor+Helper.h"
#import "NewsModel.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
@interface NewsTableViewCell : UITableViewCell
@property (retain, nonatomic) UIImageView *headImageV;
@property (retain, nonatomic) UILabel *titleLB;//
@property (retain, nonatomic) UILabel *timeLB;//
@property (retain, nonatomic) UILabel *DetailLB;//
@property (retain, nonatomic) UIView *blackV;//
@property(nonatomic,retain)UIView *lineView;

@property(nonatomic, retain)NewsModel *model;
@end
