//
//  TelCheckViewController.h
//  jjrms
//
//  Created by user on 2016/11/17.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"
#import "ContryCodeModel.h"
@interface TelCheckViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView *contryCodeTableView;
@property(nonatomic, strong)NSMutableArray *countryCodeArr;

@end
