//
//  CalenViewController.m
//  jjrms
//
//  Created by user on 16/9/29.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "CalenViewController.h"
#import "grayChangeView.h"
@interface CalenViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate>

@end

@implementation CalenViewController
{
    CalendarHomeViewController *_chv;
    grayChangeView *_grayView;
    UIAlertView *_alert;
    NSInteger _days;
}
static NSString *MonthHeader = @"MonthHeaderView";

static NSString *DayCell = @"DayCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCal];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
    [SVProgressHUD dismiss];
    
}

- (void)initCal {
    
    [SVProgressHUD show];
    
    NSDate *datenow  = [NSDate date];
    NSDate *dateend = [datenow dateByAddingTimeInterval:60*60*24*365];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateend];
     NSLog(@"...年 = year = %ld",comps.year);
     NSLog(@"...月 = month = %ld",comps.month);
     NSLog(@"...日 = day = %ld",comps.day);
     NSLog(@"时 = hour = %ld",comps.hour);
     NSLog(@"分 = minute = %ld",comps.minute);
     NSLog(@"秒 = second = %ld",comps.second);
     NSLog(@"星期 =weekDay = %ld ",comps.weekday);
    
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dateend]; // 返回某个特定时间(date)其对应的小的时间单元(smaller)在大的时间单元(larger)中的范围return daysInOfMonth.length;
    NSLog(@"...%lu", (unsigned long)daysInOfMonth.length);
    _days = 365 + daysInOfMonth.length - comps.day;
    
    _chv=[[CalendarHomeViewController alloc]init];
    
    self.calendarMonth = [[NSMutableArray alloc]init];//每个月份的数组
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 处理耗时的操作
        self.calendarMonth = [_chv getMonthArrayOfDayNumber:_days ToDateforString:nil houseSn:self.homeModel.house_sn];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //CaCollectionViewLayout *layout=[[CaCollectionViewLayout alloc]init];
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 65.0f);//头部视图的框架大小
            //layout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, 65.0f);
            layout.itemSize = CGSizeMake(SCREEN_WIDTH/7, 86*HSCALE);//每个cell的大小
            layout.minimumLineSpacing = 0.0f;//每行的最小间距
            layout.minimumInteritemSpacing = 0.0f;//每列的最小间距
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//网格视图的/上/左/下/右,的边距
            //self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout]; //初始化网格视图大小
            self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-80*HSCALE-188*HSCALE) collectionViewLayout:layout]; //初始化网格视图大小
            [self.collectionView registerClass:[CalendarDayCell class] forCellWithReuseIdentifier:DayCell];
            [self.collectionView registerClass:[CalendarMonthHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader];
            self.collectionView.delegate = self;
            self.collectionView.dataSource = self;
            self.collectionView.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:self.collectionView];
            
            [SVProgressHUD dismiss];
        });
        
    });
    
}


- (BOOL)collectionView:(UICollectionView *)collectionView
shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:indexPath.section];
    CalendarDayModel *model = [monthArray objectAtIndex:indexPath.row];
    if (model.style==CellDayTypeEmpty || model.style==CellDayTypePast) {
        return NO;
    }else{
        return YES;
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:indexPath.section];
    CalendarDayModel *model = [monthArray objectAtIndex:indexPath.row];
    _grayView=[[grayChangeView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_grayView reInitDatePicker:model];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sureTapClick:)];
    [_grayView addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:_grayView];
    [_grayView.save addTarget:self action:@selector(saveButton) forControlEvents:UIControlEventTouchUpInside];
    [_grayView.cancel addTarget:self action:@selector(cancelButton) forControlEvents:UIControlEventTouchUpInside];
    
    //[self.collectionView reloadItemsAtIndexPaths:indexPath];

}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        NSMutableArray *month_Array = [self.calendarMonth objectAtIndex:indexPath.section];
        CalendarDayModel *model = [month_Array objectAtIndex:15];
        
        CalendarMonthHeaderView *monthHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader forIndexPath:indexPath];
        monthHeader.masterLabel.text = [NSString stringWithFormat:@"%lu%@ %lu%@",(unsigned long)model.year,NSLocalizedString(@"nian_ca",nil),(unsigned long)model.month,NSLocalizedString(@"yue_ca",nil)];//@"日期";
        monthHeader.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        reusableview = monthHeader;
    }
    
    return reusableview;
    
}

#pragma 保存到后台， 调接口刷新日历
-(void)saveButton{
    if (_grayView.isTrueDate) {
        _alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"tishi_alert",nil) message:NSLocalizedString(@"shifouqueen_alert",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"qvxiao",nil) otherButtonTitles:NSLocalizedString(@"queren",nil), nil];
        [_alert show];
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:NSLocalizedString(@"shijiancuowu_alert",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"queren",nil) otherButtonTitles:nil, nil];
        [alert show];
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView==_alert) {
        if (buttonIndex==1) {
            [self confirm];
        }
    }
}

-(void)confirm{
    [_grayView removeFromSuperview];
    NSMutableDictionary *dic=[_grayView dealedData];
    
    NSMutableDictionary *paramDic=[[NSMutableDictionary alloc]init];;
    
    if ([[dic objectForKey:@"check"]isEqualToString:@"status"]) {
        [paramDic setValue:self.homeModel.house_sn forKey:@"house_sn"];
        [paramDic setValue:[dic valueForKey:@"start_time"]  forKey:@"start_time"];
        [paramDic setValue:[dic valueForKey:@"end_time"]  forKey:@"end_time"];
        //关
        if ([[dic objectForKey:@"house_status"] isEqualToString:@"20"]) {
            [paramDic setValue:[dic valueForKey:@"house_status"]  forKey:@"status"];
        }else{
            [paramDic setValue:[dic valueForKey:@"house_status"]  forKey:@"status"];
        };
        NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
        NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:paramDic url:@"house/savestatus" timeString:dateStr];
        [[httpManager sharedManager]httpWithURL:@"house/savestatus" method:POST param:paramDic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
            NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
            if (status==1){
                self.calendarMonth = [_chv getMonthArrayOfDayNumber:_days ToDateforString:nil houseSn:self.homeModel.house_sn];
                [self.collectionView reloadData];
            }
            
        } failure:^(NSError *error) {
        }];
        
    }else{
        //价格
        [paramDic setValue:self.homeModel.house_sn forKey:@"house_sn"];
        [paramDic setValue:[dic valueForKey:@"start_time"]  forKey:@"start_time"];
        [paramDic setValue:[dic valueForKey:@"end_time"]  forKey:@"end_time"];
        [paramDic setValue:[dic valueForKey:@"house_rental"]  forKey:@"rental"];
        [paramDic setValue:@"10"  forKey:@"status"];
        NSLog(@"%@",paramDic);
        
        NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
        NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:paramDic url:@"house/saverental" timeString:dateStr];
        [[httpManager sharedManager]httpWithURL:@"house/saverental" method:POST param:paramDic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
            NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
            if (status==1){
                self.calendarMonth = [_chv getMonthArrayOfDayNumber:_days ToDateforString:nil houseSn:self.homeModel.house_sn];
                [self.collectionView reloadData];
            }
            
        } failure:^(NSError *error) {
            
        }];
        
    }
    
}

-(void)cancelButton{
    [_grayView removeFromSuperview];
}
-(void)sureTapClick:(UIGestureRecognizer *)tap{
    [_grayView removeFromSuperview];
}

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.calendarMonth.count;
}


//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:section];
    return monthArray.count;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CalendarDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DayCell forIndexPath:indexPath];
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:indexPath.section];
    CalendarDayModel *model = [monthArray objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
