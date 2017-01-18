//
//  HomeViewController.h
//  jjrms
//
//  Created by user on 16/9/23.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic ,strong) UICollectionView* collectionView;//菜单
@property(nonatomic ,strong) NSMutableArray *MenuArr;//

@end
