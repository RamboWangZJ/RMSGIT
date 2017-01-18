//
//  OrderDetailViewController.h
//  jjrms
//
//  Created by user on 16/9/28.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderDetailTableViewCell.h"
#import "OrderDetailModel.h"
#import "OrderModel.h"
#import "OrderResultViewController.h"
#import "OrderDetailTopView.h"
@interface OrderDetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, retain)UITableView *orderTableView;
@property(nonatomic,retain)NSMutableArray *orderArr;
@property(nonatomic, assign)BOOL isNoDeal;
@property(nonatomic, retain)OrderModel *orderModel;
@end
