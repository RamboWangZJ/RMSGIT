//
//  WithdrawViewController.h
//  jjrms
//
//  Created by user on 2016/11/21.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"

@interface WithdrawViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView *checkTableView;
@property(nonatomic,retain)NSMutableArray *checkArr;
@property(nonatomic,retain)NSString *type;
@end
