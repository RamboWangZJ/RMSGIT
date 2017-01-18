//
//  AccountViewController.h
//  jjrms
//
//  Created by user on 16/9/23.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "BalanceView.h"
#import "AccountsModel.h"
#import "Masonry.h"
#import "AddAccountViewController.h"
#import "AccCheckTableViewCell.h"
#import "ReviewAccViewController.h"
@interface AccountViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property(nonatomic, retain)UITableView *accountTableView;
@property(nonatomic, retain)NSMutableArray *accountArr;
@property(nonatomic, assign)BOOL isRloadList;
@end
