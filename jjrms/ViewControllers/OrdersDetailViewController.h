//
//  OrdersDetailViewController.h
//  jjrms
//
//  Created by user on 2016/11/17.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderModel.h"
#import "OrderDetailModel.h"
#import "OrdersViewController.h"
@interface OrdersDetailViewController : BaseViewController

@property(nonatomic, retain)OrderModel *orderModel;
@property(nonatomic, assign)BOOL showAcc;
@end
