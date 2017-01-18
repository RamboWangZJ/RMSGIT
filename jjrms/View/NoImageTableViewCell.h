//
//  NoImageTableViewCell.h
//  jjrms
//
//  Created by user on 16/10/26.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "Commen.h"
#import "UIColor+Helper.h"
#import "NewsModel.h"
@interface NoImageTableViewCell : UITableViewCell
@property (retain, nonatomic) UILabel *titleLB2;//没有图片
@property (retain, nonatomic) UILabel *timeLB;//
@property (retain, nonatomic) UILabel *DetailLB;//
@property(nonatomic,retain)UIView *lineView;

@property(nonatomic, retain)NewsModel *model;
@end
