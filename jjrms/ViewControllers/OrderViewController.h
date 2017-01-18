//
//  OrderViewController.h
//  jjrms
//
//  Created by user on 16/9/23.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "ChildOrderTableViewController.h"
@interface OrderViewController : BaseViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic, strong)ChildOrderTableViewController *table2;
@end
