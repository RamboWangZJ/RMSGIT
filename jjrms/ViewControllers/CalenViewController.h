//
//  CalenViewController.h
//  jjrms
//
//  Created by user on 16/9/29.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "CalendarDayCell.h"
#import "CalendarMonthHeaderView.h"
#import "CalendarHomeViewController.h"
#import "Commen.h"
#import "grayChangeView.h"
#import "HomeSourceModel.h"
#import "SVProgressHUD.h"
#import "CaCollectionViewLayout.h"
@interface CalenViewController : UIViewController
@property(nonatomic ,strong) UICollectionView* collectionView;//网格视图
@property(nonatomic ,strong) NSMutableArray *calendarMonth;//每个月份的中的daymodel容器
@property(nonatomic, retain) HomeSourceModel *homeModel;


@end
