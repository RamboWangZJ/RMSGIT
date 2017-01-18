//
//  ChildOrderTableViewController.h
//  jjrms
//
//  Created by user on 16/9/28.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderModel.h"
#import "OrderTableViewCell.h"
#import "OrderDetailViewController.h"
#import "PointView.h"
#import "PointTableViewCell.h"
@interface ChildOrderTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property(nonatomic,retain)UITableView *orderTableView;
@property(nonatomic,retain)NSMutableArray *orderArr;
@property(nonatomic, assign)BOOL isNoDeal;//是否待处理
@property(nonatomic, assign)NSInteger order_status;//订单状态
@end
