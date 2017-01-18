//
//  CreateTelCheckViewController.h
//  jjrms
//
//  Created by user on 2016/12/7.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "ContryCodeModel.h"
#import "CreatTelViewController.h"
@interface CreateTelCheckViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView *contryCodeTableView;
@property(nonatomic, strong)NSMutableArray *countryCodeArr;

@end
