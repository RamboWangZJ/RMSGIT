//
//  OrdersViewController.h
//  jjrms
//
//  Created by user on 2016/11/15.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "OrdersTableViewCell.h"
#import "PointTableViewCell.h"
#import "OrderModel.h"
#import "OrdersDetailViewController.h"
#import "OtherOrdersViewController.h"
@interface OrdersViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView *orderTableView;
@property(nonatomic,retain)NSMutableArray *orderArr;
@property(nonatomic, assign)BOOL isRefresh;//接受订单后刷新
@end
