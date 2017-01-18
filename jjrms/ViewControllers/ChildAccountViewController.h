//
//  ChildAccountViewController.h
//  jjrms
//
//  Created by user on 16/10/21.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "AccountListModel.h"
#import "ListTableViewCell.h"
@interface ChildAccountViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property(nonatomic,retain)UITableView *listTableView;
@property(nonatomic,retain)NSMutableArray *listArr;
@end
