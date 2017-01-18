//
//  HousesViewController.h
//  jjrms
//
//  Created by user on 2016/11/15.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeSourceModel.h"
#import "HomesTableViewCell.h"
#import "PointTableViewCell.h"
@interface HousesViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView *homeTableView;
@property(nonatomic,retain)NSMutableArray *homeArr;
@end
