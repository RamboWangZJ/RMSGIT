//
//  ForgetTelCheckViewController.h
//  jjrms
//
//  Created by user on 2016/12/8.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "ContryCodeModel.h"
#import "ForgrtPasswordViewController.h"
@interface ForgetTelCheckViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView *contryCodeTableView;
@property(nonatomic, strong)NSMutableArray *countryCodeArr;
@end
