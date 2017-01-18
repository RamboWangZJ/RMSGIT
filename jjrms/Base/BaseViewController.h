//
//  BaseViewController.h
//  jjrms
//
//  Created by user on 16/9/6.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Commen.h"
#import "UIColor+Helper.h"
#import "Masonry.h"
#import "JPUSHService.h"
#import "BaseService.h"
#import "BaseScrollView.h"
#import "Reachability.h"
#import "httpManager.h"
#import "DataProcessing.h"
#import "NSString+MD5.h"
#import "MJExtension.h"
#import "NSObject+MJKeyValue.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "NavBarView.h"
#import "LoginBarView.h"
#import "CreateUserModel.h"
@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate>
@property(nonatomic, retain)NavBarView *navBarView;

@end
