//
//  AddAccount2ViewController.h
//  jjrms
//
//  Created by user on 2016/11/21.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "AccountsModel.h"
@interface AddAccount2ViewController : BaseViewController<UIAlertViewDelegate>
@property(nonatomic, strong)NSString *type;
@property(nonatomic, strong)NSString *whichShow;
@property(nonatomic, retain)AccountsModel *model;

@end
