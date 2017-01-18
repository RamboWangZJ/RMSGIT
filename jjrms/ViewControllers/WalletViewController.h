//
//  WalletViewController.h
//  jjrms
//
//  Created by user on 2016/11/18.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "BalanceView.h"
#import "AccountsModel.h"
#import "Masonry.h"
#import "AddAccountViewController.h"
#import "AddAccount2ViewController.h"
#import "AcountTableViewCell.h"
#import "ChildAccountViewController.h"
@interface WalletViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property(nonatomic, retain)UITableView *accountTableView;
@property(nonatomic, retain)NSMutableArray *accountArr;
@property(nonatomic, assign)BOOL isRloadList;//账户列表
@property(nonatomic, assign)BOOL isRloadAccount;//账户列表

@end
