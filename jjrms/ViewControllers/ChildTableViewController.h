//
//  ChildTableViewController.h
//  jjrms
//
//  Created by user on 16/9/27.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeSourceModel.h"
#import "HomeTableViewCell.h"
#import "DetailViewController.h"
#import "PointTableViewCell.h"
@interface ChildTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView *homeTableView;
@property(nonatomic,retain)NSMutableArray *homeArr;
@property(nonatomic, assign)NSInteger status;//房屋状态

@end
