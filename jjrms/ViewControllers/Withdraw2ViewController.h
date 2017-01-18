//
//  Withdraw2ViewController.h
//  jjrms
//
//  Created by user on 2016/11/21.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "AccountsModel.h"
#import "WalletViewController.h"
@interface Withdraw2ViewController : BaseViewController<UIAlertViewDelegate>
@property(nonatomic, strong)AccountsModel *model;
@property(nonatomic,retain)NSString *type;

@end
