//
//  CalsViewController.m
//  jjrms
//
//  Created by user on 2016/11/15.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "CalsViewController.h"

@interface CalsViewController ()

@end

@implementation CalsViewController
{
    CalendarHomeViewController *_chv;
    NSInteger _days;
    
    UIImageView *_houseImage;
    UILabel *_address;
    UIButton *_xialaBtn;
    
    UIView *_grayView;
    
    
    int _currentPageInt;//当前页int型
    NSNumber *_currentPageNum;//当前页NSNumber型
    
    NSInteger _checkNum;//选择房源的num
    
    UIImageView *_translentView;
    
    UIAlertView *_alert;//强制登录
}

static NSString *MonthHeader = @"MonthHeaderView";
static NSString *DayCell = @"DayCell";
static NSString *homeCell = @"HomeTableViewCell";

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
    [SVProgressHUD dismiss];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.navBarView.titleLab.text=NSLocalizedString(@"rili_tit",nil);//Loginbt_lg
    self.navBarView.hidden=YES;
    
    _houseImage=[[UIImageView alloc]init];
    [self.view addSubview:_houseImage];
    [_houseImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90*WSCALE, 60*HSCALE));
        make.left.mas_equalTo(16*WSCALE);
        make.top.mas_equalTo(54*HSCALE);
    }];
    
    
    _address=[[UILabel alloc]init];
    [self.view addSubview:_address];
    _address.font=[UIFont systemFontOfSize:18];
    _address.textAlignment=NSTextAlignmentCenter;
    _address.textColor=[UIColor colorWithHexString:@"#555555"];
    [_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(32*HSCALE);
        make.left.mas_equalTo(_houseImage.mas_right).offset(20*WSCALE);
        make.top.mas_equalTo(68*HSCALE);
        make.width.mas_equalTo(408*WSCALE);
    }];
    
    
    _xialaBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_xialaBtn setBackgroundImage:[UIImage imageNamed:@"xialaca"] forState:UIControlStateNormal];
    //[_xialaBtn addTarget:self action:@selector(xialaAC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_xialaBtn];
    [_xialaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(22*WSCALE, 12*HSCALE));
        make.right.mas_equalTo(-30*WSCALE);
        make.centerY.mas_equalTo(_address.mas_centerY);
    }];
    
    
    
    _translentView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiayouming"]];
    //_translentView.backgroundColor=[UIColor blueColor];
    //_translentView.alpha=0.1;
    _translentView.userInteractionEnabled=YES;
    [self.view addSubview:_translentView];
    [_translentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 64));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    [self.view addSubview:_translentView];
    UITapGestureRecognizer *whiteViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xialaAC)];
    // 设置触控对象
    [whiteViewTap setNumberOfTouchesRequired:1];
    // 设置轻拍的次数
    [whiteViewTap setNumberOfTapsRequired:1];
    // 给创建好的视图添加手势 (一个视图可以添加多个手势，但是一个手势只能添加到一个视图上）
    [_translentView addGestureRecognizer:whiteViewTap];
    
    
    
    
    _currentPageInt=1;
    _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
    self.homeArr=[[NSMutableArray alloc]init];
    self.selectArr=[[NSMutableArray alloc]init];
    _checkNum=0;
    
    
    
    _editView=[[EditView alloc]init];
    [_editView.cancel addTarget:self action:@selector(CancelAC) forControlEvents:UIControlEventTouchUpInside];
    [_editView.save addTarget:self action:@selector(SaveAC) forControlEvents:UIControlEventTouchUpInside];
    [_editView.PriceBtn addTarget:self action:@selector(PriceAC) forControlEvents:UIControlEventTouchUpInside];
    [_editView.kezuBtn addTarget:self action:@selector(KezuAC:) forControlEvents:UIControlEventTouchUpInside];
    [_editView.pingbiBtn addTarget:self action:@selector(PingBiAC:) forControlEvents:UIControlEventTouchUpInside];
    _editView.kezuBtn.tag=20001;
    _editView.pingbiBtn.tag=20002;
    [self getHouseid];
    
}


-(void)getHouseid{

    NSDictionary *dic=@{};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"house/calendarhouse"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"house/calendarhouse" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        if (status==1){
            
            NSDictionary *info=[responseDic objectForKey:@"info"];
            
            _house_sn=[info objectForKey:@"house_sn"];
            
            _unit=[info objectForKey:@"rental_unit"];
            _editView.uint.text=_unit;
            
            _address.text=[info objectForKey:@"house_name"];
            NSArray *images=[info objectForKey:@"images"];
            NSDictionary *dicImage=images[0];
            NSString *url=[dicImage objectForKey:@"url"];
            [_houseImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"di"]];
            [self initCal];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"qingqiuchaoshi",nil)];

    }];
    
}

- (void)initCal {
    
    [SVProgressHUD show];
    
    NSDate *datenow  = [NSDate date];
    NSDate *dateend = [datenow dateByAddingTimeInterval:60*60*24*365];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateend];
    /*
     NSLog(@"...年 = year = %ld",comps.year);
     NSLog(@"...月 = month = %ld",comps.month);
     NSLog(@"...日 = day = %ld",comps.day);
     NSLog(@"时 = hour = %ld",comps.hour);
     NSLog(@"分 = minute = %ld",comps.minute);
     NSLog(@"秒 = second = %ld",comps.second);
     NSLog(@"星期 = weekDay = %ld",comps.weekday);
     */
    
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dateend]; // 返回某个特定时间(date)其对应的小的时间单元(smaller)在大的时间单元(larger)中的范围return daysInOfMonth.length;
    //NSLog(@"...%lu", (unsigned long)daysInOfMonth.length);
    _days = 365 + daysInOfMonth.length - comps.day;
    
    _chv=[[CalendarHomeViewController alloc]init];
    
    self.calendarMonth = [[NSMutableArray alloc]init];//每个月份的数组
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 处理耗时的操作
        self.calendarMonth = [_chv getMonthArrayOfDayNumber:_days ToDateforString:nil houseSn:_house_sn];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //CaCollectionViewLayout *layout=[[CaCollectionViewLayout alloc]init];
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 65.0f);//头部视图的框架大小
            //layout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, 65.0f);
            //layout.itemSize = CGSizeMake((SCREEN_WIDTH-25)/7, 50);//每个cell的大小 88*HSCALE
            int cw = floor((SCREEN_WIDTH)/7);
            layout.itemSize = CGSizeMake(cw,  cw);//每个cell的大小 88*HSCALE
            
            //NSLog(@"%f.....%f",(SCREEN_WIDTH)/7, 88*HSCALE);
            
            layout.minimumLineSpacing = 0.0f;//每行的最小间距
            layout.minimumInteritemSpacing = 0.0f;//每列的最小间距
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//网格视图的/上/左/下/右,的边距
            layout.sectionInset = UIEdgeInsetsZero;
            
            //self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout]; //初始化网格视图大小
            // self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(12, 64, SCREEN_WIDTH-25, SCREEN_HEIGHT-64-49) collectionViewLayout:layout]; //初始化网格视图大小
            
            
            self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - cw*7)/2, 64, cw*7, SCREEN_HEIGHT-64-49) collectionViewLayout:layout]; //初始化网格视图大小
            
            [self.collectionView registerClass:[CalendarDayCell class] forCellWithReuseIdentifier:DayCell];
            [self.collectionView registerClass:[CalendarMonthHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader];
            self.collectionView.delegate = self;
            self.collectionView.dataSource = self;
            self.collectionView.backgroundColor = [UIColor whiteColor];
            
            [self.view addSubview:self.collectionView];
            
            
            _editView.frame=CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 480*HSCALE);
            [self.view addSubview:_editView];
            
            [SVProgressHUD dismiss];
        });
        
    });
    
}



//可租
-(void)KezuAC:(UIButton *)btn{
    
    if(btn.isSelected==NO)
    {
        btn.selected=YES;  //!btn.selected;
    
        //
        if (btn.isSelected==YES) {
         _editView.pingbiBtn.selected=NO;
         
        }else{
         _editView.pingbiBtn.selected=YES;
        }
        [self reviewBtn];

    }
}


//屏蔽
-(void)PingBiAC:(UIButton *)btn{
    if(btn.isSelected==NO)
    {
        btn.selected= YES; //!btn.selected;
        
        if (btn.isSelected==YES) {
            _editView.kezuBtn.selected=NO;
        }else{
            _editView.kezuBtn.selected=YES;
        }
        
        [self reviewBtn];
    }
}

#pragma 每次点击按钮 更新修改价格状态
-(void)reviewBtn{
    if (_editView.kezuBtn.isSelected==YES) {
        _editView.PriceBtn.userInteractionEnabled=YES;
        [_editView.PriceBtn setTitleColor:[UIColor colorWithHexString:@"#F06464"] forState:UIControlStateNormal];
        _editView.uint.textColor=[UIColor colorWithHexString:@"#F06464"];

    }else{
        _editView.PriceBtn.userInteractionEnabled=NO;
        [_editView.PriceBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
        _editView.uint.textColor=[UIColor colorWithHexString:@"#555555"];

    }
}


//输入价格
-(void)PriceAC{
    PriceViewController *vc=[[PriceViewController alloc]init];
    [vc returnCALText:^(NSString *text) {
        [_editView.PriceBtn setTitle:text forState:UIControlStateNormal];
    }];
    vc.datetext=_editView.dateLab.text;
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//保存修改 房态和房价
-(void)SaveAC{
    
    [SVProgressHUD show];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
        NSString *lang=[[NSUserDefaults standardUserDefaults]valueForKey:LANGUAGE];
        
        
        //更新价格
        for (int i=0; i<self.selectArr.count; i++) {
            
            NSInteger priceInt=_editView.PriceBtn.titleLabel.text.integerValue * 100;
            NSString *priceStr=[NSString stringWithFormat:@"%ld", (long)priceInt];
            CalendarDayModel *model=self.selectArr[i];
            
            
            NSString *yue=@"";
            NSString *ri=@"";
            ;
            if (model.month < 10) {
                yue=[NSString stringWithFormat:@"0%lu", (unsigned long)model.month];
            }else{
                yue=[NSString stringWithFormat:@"%lu",(unsigned long)model.month] ;
            }
            if (model.day < 10) {
                ri=[NSString stringWithFormat:@"0%lu", (unsigned long)model.day];
            }else{
                ri=[NSString stringWithFormat:@"%lu",(unsigned long)model.day];
            }
            NSString *start_time=[NSString stringWithFormat:@"%lu-%@-%@", (unsigned long)model.year, yue, ri];
            
            
            NSDictionary *dic=@{@"house_sn":self.house_sn, @"rental":priceStr, @"start_time":start_time, @"end_time":start_time};
            //1.创建一个web路径
            NSString  *webPath=[HOSTAPI stringByAppendingString:@"house/saverental"];
            webPath = [webPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url=[NSURL URLWithString:webPath];
            //2.建立一个带协议缓存类型的请求 (使用NSMutableURLRequest，是post方法的关键)
            NSMutableURLRequest  *request=[NSMutableURLRequest requestWithURL:url cachePolicy:(NSURLRequestUseProtocolCachePolicy) timeoutInterval:10];
            //3.设置表单提交的方法（默认为get）
            NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"house/saverental" timeString:dateStr];
            [request setValue:sign forHTTPHeaderField:@"sign"];
            [request setValue:dateStr forHTTPHeaderField:@"timestamp"];
            [request setValue:@"1.0.1" forHTTPHeaderField:@"app_version"];
            [request setValue:@"1.0.1" forHTTPHeaderField:@"api_version"];
            [request setValue:@"130" forHTTPHeaderField:@"platform_type"];
            
            if ([lang isEqualToString:@"zh-Hans"] || [lang isEqualToString:@"zh-Hans-CN"]) {
                [request setValue:@"zh" forHTTPHeaderField:@"lang"];
            }else{
                [request setValue:@"en" forHTTPHeaderField:@"lang"];
            }
            [request setValue:[[NSUserDefaults standardUserDefaults]valueForKey:ACCESS_TOKEN] forHTTPHeaderField:@"access_token"];
            
            [request setHTTPMethod:@"post"];
            //4.设置要提交的参数
            NSString  *args=[NSString stringWithFormat:@"house_sn=%@&rental=%ld&start_time=%@&end_time=%@",_house_sn,(long)priceInt, start_time,start_time];
            
            [request setHTTPBody:[args dataUsingEncoding:NSUTF8StringEncoding]];
            NSData *recvData=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:recvData options:NSJSONReadingAllowFragments error:nil];
            
//            NSLog(@"header:%@", request.allHTTPHeaderFields);
//            NSLog(@"url:%@", url);
//            NSLog(@"sign:%@", sign);
//            NSLog(@"param:%@", args);
//            NSLog(@"%@",dict);
            
            //token错误
            NSInteger code=[[dict objectForKey:@"code"] integerValue];
            if (code==1001 || code==1511) {//token错误
                [self toLogin];
            }
            
        }
        
        //房态
        for (int i=0; i<self.selectArr.count; i++) {

            CalendarDayModel *model=self.selectArr[i];
            
            
            NSString *yue=@"";
            NSString *ri=@"";
            ;
            if (model.month < 10) {
                yue=[NSString stringWithFormat:@"0%lu", (unsigned long)model.month];
            }else{
                yue=[NSString stringWithFormat:@"%lu",(unsigned long)model.month] ;
            }
            if (model.day < 10) {
                ri=[NSString stringWithFormat:@"0%lu", (unsigned long)model.day];
            }else{
                ri=[NSString stringWithFormat:@"%lu",(unsigned long)model.day];
            }
            NSString *start_time=[NSString stringWithFormat:@"%lu-%@-%@", (unsigned long)model.year, yue, ri];
            
            NSDictionary *dic=@{};
            //关
            if (_editView.pingbiBtn.isSelected==YES && _editView.kezuBtn.isSelected==NO) {
                NSLog(@"1111");
                dic=@{@"house_sn":self.house_sn, @"status":@20, @"start_time":start_time, @"end_time":start_time};
            }else  if(_editView.kezuBtn.isSelected==YES && _editView.pingbiBtn.isSelected==NO){
                //开
                NSLog(@"11111");
                dic=@{@"house_sn":self.house_sn, @"status":@10, @"start_time":start_time, @"end_time":start_time};
            }
            
            //1.创建一个web路径
            NSString  *webPath=[HOSTAPI stringByAppendingString:@"house/savestatus"];
            webPath = [webPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url=[NSURL URLWithString:webPath];
            //2.建立一个带协议缓存类型的请求 (使用NSMutableURLRequest，是post方法的关键)
            NSMutableURLRequest  *request=[NSMutableURLRequest requestWithURL:url cachePolicy:(NSURLRequestUseProtocolCachePolicy) timeoutInterval:10];
            //3.设置表单提交的方法（默认为get）
            NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"house/savestatus" timeString:dateStr];
            [request setValue:sign forHTTPHeaderField:@"sign"];
            [request setValue:dateStr forHTTPHeaderField:@"timestamp"];
            [request setValue:@"1.0.1" forHTTPHeaderField:@"app_version"];
            [request setValue:@"1.0.1" forHTTPHeaderField:@"api_version"];
            [request setValue:@"130" forHTTPHeaderField:@"platform_type"];
            
            if ([lang isEqualToString:@"zh-Hans"] || [lang isEqualToString:@"zh-Hans-CN"]) {
                [request setValue:@"zh" forHTTPHeaderField:@"lang"];
            }else{
                [request setValue:@"en" forHTTPHeaderField:@"lang"];
            }
            [request setValue:[[NSUserDefaults standardUserDefaults]valueForKey:ACCESS_TOKEN] forHTTPHeaderField:@"access_token"];
            
            [request setHTTPMethod:@"post"];
            NSString *args=@"";
            //4.设置要提交的参数
            if (_editView.pingbiBtn.isSelected==YES && _editView.kezuBtn.isSelected==NO) {
                args=[NSString stringWithFormat:@"house_sn=%@&status=20&start_time=%@&end_time=%@",_house_sn, start_time,start_time];
            }else if (_editView.kezuBtn.isSelected==YES && _editView.pingbiBtn.isSelected==NO){
                args=[NSString stringWithFormat:@"house_sn=%@&status=10&start_time=%@&end_time=%@",_house_sn, start_time,start_time];
            }
            
            
            [request setHTTPBody:[args dataUsingEncoding:NSUTF8StringEncoding]];
            NSData *recvData=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:recvData options:NSJSONReadingAllowFragments error:nil];
            
//            NSLog(@"header:%@", request.allHTTPHeaderFields);
//            NSLog(@"url:%@", url);
//            NSLog(@"sign:%@", sign);
//            NSLog(@"param:%@", args);
//            NSLog(@"%@",dict);
            
            //token错误
            NSInteger code=[[dict objectForKey:@"code"] integerValue];
            if (code==1001 || code==1511) {//token错误
                [self toLogin];
            }
            
        }
        
        [_selectArr removeAllObjects];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.calendarMonth = [_chv getMonthArrayOfDayNumber:_days ToDateforString:nil houseSn:self.house_sn];
            [self.collectionView reloadData];
            
            [SVProgressHUD dismiss];
            
        });
        
    });
    
    [UIView animateWithDuration:0.5 animations:^{
        _editView.frame=CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 480*HSCALE);    }completion:^(BOOL finished) {
    }];
}

#pragma 重新登录
-(void)toLogin{
    NSLog(@"toLogin");
    //防止并发提示
    if ([[NSUserDefaults standardUserDefaults]boolForKey:FORCIBLY_LOGIN]) {
        
        _alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"tokenerror_alert",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"queren",nil) otherButtonTitles:nil, nil];
        [_alert show];
        
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:FORCIBLY_LOGIN];
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView == _alert) {
        if (buttonIndex==0) {
            [[NSUserDefaults standardUserDefaults]setValue:nil forKey:ACCESS_TOKEN];
            [[NSUserDefaults standardUserDefaults]setValue:nil forKey:USER_SN];
            
            
            LoginViewController *login=[[LoginViewController alloc]init];
            UINavigationController *NaVC1=[[UINavigationController alloc]initWithRootViewController:login];
            UIWindow *window = [[UIApplication sharedApplication].delegate window];
            window.rootViewController=NaVC1;
            [window makeKeyAndVisible];
        }
    }
    
}




//取消
-(void)CancelAC{
    for (int i=0; i<_selectArr.count; i++) {
        CalendarDayModel *model=_selectArr[i];
        model.type=nil;
    }
    [_selectArr removeAllObjects];
    [self.collectionView reloadData];
    [UIView animateWithDuration:0.5 animations:^{
        _editView.frame=CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 480*HSCALE);    }completion:^(BOOL finished) {
    }];
}




#pragma 日历协议方法


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
    
    //修改collectionview位置
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    CGRect rect = [self.view convertRect:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height) fromView:cell];
    if (rect.origin.y > (SCREEN_HEIGHT-480*HSCALE-49-20)) {
        CGFloat offsetY = self.collectionView.contentOffset.y;
        self.collectionView.contentOffset = CGPointMake(0, offsetY+480*HSCALE);
    }
    
    
    [UIView animateWithDuration:0.5 animations:^{
        //执行的动画
        _editView.frame=CGRectMake(0, SCREEN_HEIGHT-49-480*HSCALE, SCREEN_WIDTH, 480*HSCALE);
    }completion:^(BOOL finished) {
        //动画执行完毕后的操作
    }];
    
    
    
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:indexPath.section];
   


    //没有alloc对象， 所以修改的model就是，数组对应位置的model。内存地址完全一样。
    //NSLog(@"%p..1", model);
    //用字面量设置字符串后 新的地址会变掉

    CalendarDayModel *model = [monthArray objectAtIndex:indexPath.row];//选择当天的model
    CalendarDayModel *tempModel = [[CalendarDayModel alloc]init];//空数据
    
    CalendarDayModel *modelbefore =[[CalendarDayModel alloc]init];
    CalendarDayModel *modelbefore2 =[[CalendarDayModel alloc]init];
    CalendarDayModel *modelafter =[[CalendarDayModel alloc]init];
    CalendarDayModel *modelafter2 =[[CalendarDayModel alloc]init];
    
    
    //前2
    if (indexPath.row==0) {
        modelbefore=tempModel;
        modelbefore2=tempModel;
    }else if (indexPath.row==1) {
        modelbefore2=tempModel;
        modelbefore = [monthArray objectAtIndex:indexPath.row-1];
    }else{
        modelbefore = [monthArray objectAtIndex:indexPath.row-1];
        modelbefore2 = [monthArray objectAtIndex:indexPath.row-2];
    }
    
    //后2  5x7=35个
    if (indexPath.row==34) {
        modelafter=tempModel;
        modelafter2=tempModel;
    }else if (indexPath.row==33) {
        modelafter2=tempModel;
        modelafter = [monthArray objectAtIndex:indexPath.row+1];
    }else{
        modelafter = [monthArray objectAtIndex:indexPath.row+1];
        modelafter2 = [monthArray objectAtIndex:indexPath.row+2];
    }
    
    
    //第二次点击  给type赋值为空     之后reload
    
    if (model.type.length > 0) { //>4
        //被选的cell 设置为空背景
        
        model.type=nil;    //model.type=@""
        
        //左边
        if (modelbefore2.type.length > 0) {
            modelbefore.selectStyle=CellSelectTypeRightYuan;
        }else{
            modelbefore.selectStyle=CellSelectTypeYuan;
        }
        
        //右边
        if (modelafter2.type.length > 0) {
            modelafter.selectStyle=CellSelectTypeLeftYuan;
        }else{
            modelafter.selectStyle=CellSelectTypeYuan;
        }
        
        
        //第一次点击  给type赋值     之后reload
    }else{
        
        model.type=@"sele";//第一次点击
        
        //圆
        if (modelbefore.type.length == 0  && modelafter.type == 0) {
            //NSLog(@"圆");
            model.selectStyle=CellSelectTypeYuan;
        }
        
        //左圆
        if (modelbefore.type.length == 0  && modelafter.type > 0) {
            //NSLog(@"左圆");
            
            model.selectStyle=CellSelectTypeLeftYuan;
            
            if (modelafter2.type.length > 0) {
                modelafter.selectStyle=CellSelectTypeCenter;
            }else{
                modelafter.selectStyle=CellSelectTypeRightYuan;
            }
        }
        
        //右圆
        if (modelbefore.type.length > 0  && modelafter.type == 0) {
            //NSLog(@"右圆");
            
            model.selectStyle=CellSelectTypeRightYuan;
            
            if (modelbefore2.type.length > 0) {
                modelbefore.selectStyle=CellSelectTypeCenter;
            }else{
                modelbefore.selectStyle=CellSelectTypeLeftYuan;
            }
        }
        //方
        if (modelbefore.type.length > 0  && modelafter.type > 0) {
            //NSLog(@"方");
            
            model.selectStyle=CellSelectTypeCenter;
            if (modelbefore2.type.length > 0) {
                modelbefore.selectStyle=CellSelectTypeCenter;
            }else{
                modelbefore.selectStyle=CellSelectTypeLeftYuan;
            }
            if (modelafter2.type.length > 0) {
                modelafter.selectStyle=CellSelectTypeCenter;
            }else{
                modelafter.selectStyle=CellSelectTypeRightYuan;
            }
        }
        
        
    }
    
    

    
    
    
    // NSLog(@"%@...", model.money);null
    
    
    //收集？ 多次点击  1. >0   2.nil  第二次点击
    if (model.type.length > 0) {
        [self.selectArr addObject:model];
    }else{
        [self.selectArr removeObject:model];//? model 和 日期数组的内存地址一样？
    }
    
    
    
    //更新日期和价格
    [self reloadEditView:self.selectArr];
    
    
    //刷新
    [UIView performWithoutAnimation:^{
        
        if (indexPath.row==0) {
            [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:indexPath.row inSection:indexPath.section],[NSIndexPath indexPathForItem:indexPath.row+1 inSection:indexPath.section]]];
        }else if (indexPath.row==34){
            [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:indexPath.row-1 inSection:indexPath.section],[NSIndexPath indexPathForItem:indexPath.row inSection:indexPath.section]]];
        }else{
            [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:indexPath.row-1 inSection:indexPath.section],[NSIndexPath indexPathForItem:indexPath.row inSection:indexPath.section],[NSIndexPath indexPathForItem:indexPath.row+1 inSection:indexPath.section]]];
        }
        
    }];
    
}

#pragma  每次点击更新 价格 与 按钮
-(void)reloadEditView:(NSMutableArray *)modelArr{
    
    //设置 日期label        1.一天2.时间段3.不同的日期
    if (_selectArr.count==1) {
        CalendarDayModel *model = _selectArr[0];
        _editView.dateLab.text=[NSString stringWithFormat:@"%lu/%lu", (unsigned long)model.month, (unsigned long)model.day];
    }else{
        //不同的日期
        NSMutableArray *dateresultArr=[[NSMutableArray alloc]init];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        
        for (int i=0; i<_selectArr.count; i++) {
            CalendarDayModel *model = _selectArr[i];
            NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%lu-%lu-%lu", (unsigned long)model.year, (unsigned long)model.month, (unsigned long)model.day]];
            NSTimeInterval timeInterval=[date timeIntervalSince1970];
            
            NSString * time = [NSString stringWithFormat:@"%f", timeInterval];
            [dateresultArr addObject:time];
        }
        
        float max = [[dateresultArr valueForKeyPath:@"@max.intValue"] floatValue];
        float min = [[dateresultArr valueForKeyPath:@"@min.intValue"] floatValue];
        
        int endtime = ((int)max)/(3600*24);
        int begintime = ((int)min)/(3600*24);
        //NSLog(@"%d...", endtime - begintime);
        //NSLog(@"%dooo", _selectArr.count);
        if ((endtime - begintime + 1) > _selectArr.count) {
            _editView.dateLab.text=NSLocalizedString(@"butongderiqi_ca",nil);
        }else{
            NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:min];
            NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:max];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"MM/dd";
            _editView.dateLab.text=[NSString stringWithFormat:@"%@—%@", [formatter stringFromDate:startDate],  [formatter stringFromDate:endDate]];
            
        }
    }
    
    
    //设置价格
    NSMutableArray *moneyArr=[[NSMutableArray alloc]init];
    for (int i=0; i<_selectArr.count; i++) {
        CalendarDayModel *model = _selectArr[i];
        [moneyArr addObject:model.money];
    }
    
    float max = [[moneyArr valueForKeyPath:@"@max.intValue"] floatValue] / 100;
    float min = [[moneyArr valueForKeyPath:@"@min.intValue"] floatValue] / 100;
    if (max==min && max == 0) {
        [ _editView.PriceBtn setTitle:[NSString stringWithFormat:@"0"] forState:UIControlStateNormal];
    }else if(max==min && max != 0){
        [ _editView.PriceBtn setTitle:[NSString stringWithFormat:@"%.0f", max] forState:UIControlStateNormal];
    }else{
        [ _editView.PriceBtn setTitle:[NSString stringWithFormat:@"%.0f—%.0f", min, max] forState:UIControlStateNormal];
    }
    
    
    
    
    
     //设置按钮背景
     BOOL colse = NO;
     BOOL open = NO;
     for (int i=0; i<_selectArr.count; i++) {
         CalendarDayModel *model = _selectArr[i];
         if (model.is_warehouse==YES) {
             colse=YES;
     }
         if (model.is_warehouse==NO) {
            open=YES;
         }
     }
     if (colse==YES && open==YES) {//房态有开有关
         _editView.kezuBtn.selected=NO;
         _editView.pingbiBtn.selected=NO;
         _editView.PriceBtn.userInteractionEnabled=NO;
        [_editView.PriceBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
         _editView.uint.textColor=[UIColor colorWithHexString:@"#555555"];
     }else if(colse==YES && open==NO){//房态全关
         _editView.kezuBtn.selected=NO;
        _editView.pingbiBtn.selected=YES;
         _editView.PriceBtn.userInteractionEnabled=NO;
        [_editView.PriceBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
        _editView.uint.textColor=[UIColor colorWithHexString:@"#555555"];

    }else if(colse==NO && open==YES){//房态全开
        _editView.kezuBtn.selected=YES;
        _editView.pingbiBtn.selected=NO;
        _editView.PriceBtn.userInteractionEnabled=YES;
        [_editView.PriceBtn setTitleColor:[UIColor colorWithHexString:@"#F06464"] forState:UIControlStateNormal];
        _editView.uint.textColor=[UIColor colorWithHexString:@"#F06464"];


    }
    
    
    
    if (_selectArr.count==0) {
        [UIView animateWithDuration:0.5 animations:^{
            _editView.frame=CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 480*HSCALE);    }completion:^(BOOL finished) {
        }];
    }
    
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








-(void)xialaAC{
    
    _grayView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _grayView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapClick:)];
    tap.delegate=self;
    [_grayView addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:_grayView];
    
    
    self.homeTableView=[[UITableView alloc]initWithFrame:CGRectMake(30*WSCALE, 58*HSCALE, SCREEN_WIDTH-60*WSCALE, SCREEN_HEIGHT/3*2) style:UITableViewStylePlain];
    self.homeTableView.delegate=self;
    self.homeTableView.dataSource=self;
    self.homeTableView.showsVerticalScrollIndicator=NO;
    self.homeTableView.tableFooterView = [UIView new];
    [_grayView addSubview:self.homeTableView];
    [self.homeTableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:homeCell];
    //[self.homeTableView registerClass:[PointTableViewCell class] forCellReuseIdentifier:PointCell];
    self.homeTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTop)];
    self.homeTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadBottom)];
    [self.homeTableView.mj_header beginRefreshing];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 点击tableViewCell不执行Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

-(void)TapClick:(UIGestureRecognizer *)tap{
    [_grayView removeFromSuperview];
}


#pragma 下拉刷新
-(void)loadTop{
    
    _currentPageInt=1;
    
    _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    
    
    dic=@{@"landlord_sn":[[NSUserDefaults standardUserDefaults]valueForKey:USER_SN],@"page_size":@10,@"current_page":_currentPageNum};
    
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"house/list"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"house/list" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            
            NSDictionary *info=[responseDic objectForKey:@"info"];
            
            NSArray *list=[info objectForKey:@"list"];
            
            self.homeArr=[[NSMutableArray alloc]init];
            
            self.homeArr=[HomeSourceModel objectArrayWithKeyValuesArray:list];
            
            [self.homeTableView reloadData];
            
            _currentPageInt+=1;
            
            _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
            
            
        }
        
        [self.homeTableView.mj_header endRefreshing];
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}
#pragma 上拉刷新
-(void)loadBottom{
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    dic=@{@"landlord_sn":[[NSUserDefaults standardUserDefaults]valueForKey:USER_SN],@"page_size":@10,@"current_page":_currentPageNum};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"house/list"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"house/list" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            
            NSDictionary *info=[responseDic objectForKey:@"info"];
            
            NSArray *list=[info objectForKey:@"list"];
            
            NSMutableArray *newModelArr=[[NSMutableArray alloc]init];
            
            newModelArr=[HomeSourceModel objectArrayWithKeyValuesArray:list];
            
            [self.homeArr addObjectsFromArray:newModelArr];
            
            [self.homeTableView reloadData];
            
            _currentPageInt+=1;
            
            _currentPageNum=[NSNumber numberWithInt:_currentPageInt];
            
        }
        
        [self.homeTableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.homeArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeTableViewCell *cell = [self.homeTableView dequeueReusableCellWithIdentifier:homeCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model=self.homeArr[indexPath.row];
    if (indexPath.row==_checkNum) {
        cell.checkImag.hidden=NO;
    }else{
        cell.checkImag.hidden=YES;//消除重用
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    return 162*HSCALE;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeSourceModel *model=self.homeArr[indexPath.row];
    
    _house_sn=model.house_sn;
    
    _checkNum=indexPath.row;
    
    [_selectArr removeAllObjects];
    
    [_grayView removeFromSuperview];
    
    
    if (_chv==nil) {
        [self initCal];
    }else{
        self.calendarMonth = [_chv getMonthArrayOfDayNumber:_days ToDateforString:nil houseSn:self.house_sn];
        
        [self.collectionView reloadData];
    }
    

        
    
    _address.text=model.house_name;
    
    _unit=model.rental_unit;
    _editView.uint.text=_unit;
    
    NSArray *imgArr=model.images;
    NSDictionary *dic = imgArr[0];
    NSString *url = [dic objectForKey:@"url"];
    [_houseImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"di"]];
    
    [UIView animateWithDuration:0.5 animations:^{
        _editView.frame=CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 480*HSCALE);    }completion:^(BOOL finished) {
    }];
    
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
