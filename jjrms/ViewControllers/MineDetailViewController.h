//
//  MineDetailViewController.h
//  jjrms
//
//  Created by user on 16/10/24.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "Masonry.h"
#import "UIColor+Helper.h"
#import "Commen.h"
#import "LoginViewController.h"
#import "MineDetailViewController.h"
@interface MineDetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
@property(nonatomic, retain)NSMutableArray *infoArr;

@end
