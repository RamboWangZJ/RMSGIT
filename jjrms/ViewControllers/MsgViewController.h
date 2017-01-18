//
//  MsgViewController.h
//  jjrms
//
//  Created by user on 2016/11/15.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "NewsDetailViewController.h"

@interface MsgViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)UITableView *orderTableView;
@property(nonatomic,retain)NSMutableArray *orderArr;
@end
