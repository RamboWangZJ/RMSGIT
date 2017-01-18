//
//  DetailViewController.h
//  jjrms
//
//  Created by user on 16/9/7.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"
#import "CalenViewController.h"
#import "HomeSourceModel.h"
#import "HomeTableViewCell.h"
@interface DetailViewController : BaseViewController

@property(nonatomic ,strong) UICollectionView* collectionView;//网格视图

@property(nonatomic ,strong) NSMutableArray *calendarMonth;//每个月份的中的daymodel容器数组
@property(nonatomic, retain) CalenViewController *homeCal;

@property(nonatomic, retain) HomeSourceModel *topModel;

@end
