//
//  AcountTableViewCell.h
//  jjrms
//
//  Created by user on 16/10/20.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "Commen.h"
#import "UIColor+Helper.h"
#import "AccountsModel.h"
@interface AcountTableViewCell : UITableViewCell
@property(nonatomic, retain)AccountsModel *model;
@property(nonatomic, retain)UIImageView *typeImage;
@property(nonatomic, retain)UILabel *typeName;
@property(nonatomic,retain)UIView *lineView;

@end
