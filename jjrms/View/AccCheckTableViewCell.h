//
//  AccCheckTableViewCell.h
//  jjrms
//
//  Created by user on 16/10/21.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccCheckModel.h"
#import "Masonry.h"
#import "Commen.h"
#import "UIColor+Helper.h"
#import "AccountsModel.h"
@interface AccCheckTableViewCell : UITableViewCell
//@property(nonatomic, retain)AccCheckModel *model;
@property(nonatomic, retain)AccountsModel *model;
//@property(nonatomic, retain)UIImageView *typeImage;
@property(nonatomic, retain)UILabel *typeName;
@property(nonatomic, retain)UILabel *zhanghuLB;

@end
