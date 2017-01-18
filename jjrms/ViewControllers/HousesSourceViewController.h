//
//  HousesSourceViewController.h
//  jjrms
//
//  Created by user on 16/9/23.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeSourceModel.h"
#import "ChildTableViewController.h"
#import "LoginViewController.h"
@interface HousesSourceViewController : BaseViewController<UIGestureRecognizerDelegate>
@property(nonatomic,retain)HomeSourceModel *homeModel;
@property(nonatomic,retain)NSMutableArray *homeArr;
@end
