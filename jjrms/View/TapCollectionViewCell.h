//
//  TapCollectionViewCell.h
//  jjrms
//
//  Created by user on 16/9/26.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "Commen.h"
#import "UIColor+Helper.h"
@interface TapCollectionViewCell : UICollectionViewCell
@property (retain, nonatomic) UIImageView *hImageView;//房源管理图片
@property (retain, nonatomic) UILabel *hLabel;//房源管理 文字
@property (nonatomic,retain) NSDictionary *model;//菜单数据模型
@end
