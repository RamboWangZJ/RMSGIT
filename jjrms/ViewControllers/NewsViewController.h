//
//  NewsViewController.h
//  jjrms
//
//  Created by user on 16/9/23.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "NewsDetailViewController.h"
@interface NewsViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView *orderTableView;
@property(nonatomic,retain)NSMutableArray *orderArr;

@end
