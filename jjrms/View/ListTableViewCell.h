//
//  ListTableViewCell.h
//  jjrms
//
//  Created by user on 16/10/21.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "Commen.h"
#import "UIColor+Helper.h"
#import "AccountListModel.h"
@interface ListTableViewCell : UITableViewCell
@property(nonatomic, retain)UILabel *nameLB;
@property(nonatomic, retain)UILabel *resultLB;
@property(nonatomic, retain)UILabel *numLB;
@property(nonatomic, retain)UILabel *dateLB;
@property(nonatomic, retain)AccountListModel *model;
@end
