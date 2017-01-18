//
//  OtherOrdersViewController.h
//  jjrms
//
//  Created by user on 2016/11/17.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "OtherOrdersTableViewCell.h"
#import "PointTableViewCell.h"
#import "OrderModel.h"
#import "OrdersDetailViewController.h"
#import "OtherOrdersViewController.h"
@interface OtherOrdersViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView *orderTableView;
@property(nonatomic,retain)NSMutableArray *orderArr;
@property(nonatomic, retain)UIButton *backBut;

@end
