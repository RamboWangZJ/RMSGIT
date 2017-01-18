//
//  CalsViewController.h
//  jjrms
//
//  Created by user on 2016/11/15.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "CalendarDayCell.h"
#import "CalendarMonthHeaderView.h"
#import "CalendarHomeViewController.h"
#import "Commen.h"
#import "HomeSourceModel.h"
#import "SVProgressHUD.h"
#import "EditView.h"
#import "PriceViewController.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "HomeTableViewCell.h"
@interface CalsViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property(nonatomic ,strong) UICollectionView* collectionView;//网格视图
@property(nonatomic ,strong) NSMutableArray *calendarMonth;//每个月份的中的daymodel容器
//@property(nonatomic, retain) HomeSourceModel *homeModel;
@property(nonatomic ,strong) NSString *house_sn;
@property(nonatomic ,strong) NSString *unit;

@property(nonatomic ,strong) EditView *editView;

@property(nonatomic,retain)UITableView *homeTableView;
@property(nonatomic,retain)NSMutableArray *homeArr;

@property(nonatomic,retain)NSMutableArray *selectArr;//点击的所有日期

@end
