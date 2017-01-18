//
//  AccountGrayView.h
//  jjrms
//
//  Created by user on 16/10/21.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Helper.h"
#import "Commen.h"
#import "Masonry.h"
#import "AccCheckTableViewCell.h"
#import "AccCheckModel.h"
#import "httpManager.h"
#import "DataProcessing.h"
#import "AccountsModel.h"
#import "MJExtension.h"
#import "NSObject+MJKeyValue.h"
@interface AccountGrayView : UIView<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property(nonatomic,retain)UITableView *checkTableView;
@property(nonatomic,retain)NSMutableArray *checkArr;
@property(nonatomic, retain)UIButton *cancel;
@property(nonatomic, retain)UIButton *save;

-(void)initUIDataWithUnit:(NSString *)unit Ketixian:(NSString*)ketixian;
-(double)getMoney;
-(NSString *)getId;


@end
