//
//  CalendarLogic1.m
//  Calendar
//
//  Created by 张凡 on 14-7-3.
//  Copyright (c) 2014年 张凡. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "CalendarLogic.h"

@interface CalendarLogic ()
{
    NSDate *today;//今天的日期
    NSDate *before;//之后的日期
    NSDate *select;//选择的日期
    CalendarDayModel *selectcalendarDay;
    UIAlertView *_alert;
}

@end


@implementation CalendarLogic





//计算当前日期之前几天或者是之后的几天（负数是之前几天，正数是之后的几天）
- (NSMutableArray *)reloadCalendarView:(NSDate *)date  selectDate:(NSDate *)selectdate needDays:(int)days_number;
{
    //如果为空就从当天的日期开始
    if(date == nil){
        date = [NSDate date];
    }
    //默认选择中的时间
    if (selectdate == nil) {
        selectdate = date;
    }
    
    today = date;//起始日期

/*
    // 时间字符串
    NSString *str = @"2014-03-11 06:44:11 +0800";
    // 1.创建一个时间格式化对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 2.格式化对象的样式/z大小写都行/格式必须严格和字符串时间一样
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss Z";
    // 3.利用时间格式化对象让字符串转换成时间 (自动转换0时区/东加西减)
    NSDate *date2 = [formatter dateFromString:str];
    today=date2;
*/
    
    
    //结束日期
    before = [date dayInTheFollowingDay:days_number];//计算它days天以后的时间
    
    select = selectdate;//选择的日期
    
    NSDateComponents *todayDC= [today YMDComponents];//起日期的年月日
    
    NSDateComponents *beforeDC= [before YMDComponents];//止日期的年月日
    
    NSInteger todayYear = todayDC.year;
    
    NSInteger todayMonth = todayDC.month;
    
    NSInteger beforeYear = beforeDC.year;
    
    NSInteger beforeMonth = beforeDC.month;
    
    NSInteger months = (beforeYear-todayYear) * 12 + (beforeMonth - todayMonth);
    
    NSMutableArray *calendarMonth = [[NSMutableArray alloc]init];//每个月的dayModel数组
    
    self.warehouseArr=[[NSMutableArray alloc]init];
    NSMutableArray *sArr=[[NSMutableArray alloc]init];//状态数组
    NSMutableArray *mArr=[[NSMutableArray alloc]init];//金额数组

    
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString* nowString = [formatter stringFromDate:now];
    
    
    NSDate *dateend = [now dateByAddingTimeInterval:60*60*24*365];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateend];
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dateend];
    NSInteger days = 365 + daysInOfMonth.length - comps.day;
    
    NSDate *dateEnd = [now dateByAddingTimeInterval:60*60*24*days];
    NSString* endString = [formatter stringFromDate:dateEnd];

    
    
    //获取一年内的房态
    NSString *str = [NSString stringWithFormat:@"house/liststatus?house_sn=%@&start_time=%@&end_time=%@", self.housesn, nowString, endString];
    NSURL *url = [NSURL URLWithString:[HOSTAPI stringByAppendingString:str]];
    NSDictionary *dic=@{@"house_sn":self.housesn};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"house/liststatus" timeString:dateStr];
    //创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求方式 这一步可以不写 默认设置为get请求
    [request setHTTPMethod:@"GET"];
    //创建相应对象
    [request setValue:sign forHTTPHeaderField:@"sign"];
    [request setValue:dateStr forHTTPHeaderField:@"timestamp"];
    [request setValue:@"1.0.1" forHTTPHeaderField:@"app_version"];
    [request setValue:@"1.0.1" forHTTPHeaderField:@"api_version"];
    [request setValue:@"130" forHTTPHeaderField:@"platform_type"];
    
    NSString *lang=[[NSUserDefaults standardUserDefaults]valueForKey:LANGUAGE];
    if ([lang isEqualToString:@"zh-Hans"] || [lang isEqualToString:@"zh-Hans-CN"]) {
        [request setValue:@"zh" forHTTPHeaderField:@"lang"];
    }else{
        [request setValue:@"en" forHTTPHeaderField:@"lang"];
    }
    [request setValue:[[NSUserDefaults standardUserDefaults]valueForKey:ACCESS_TOKEN] forHTTPHeaderField:@"access_token"];
    
    NSURLResponse *response = nil;
    NSError *error;
    //创建连接对象
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"header:%@", request.allHTTPHeaderFields);
    NSLog(@"url:%@", url);
    NSLog(@"sign:%@", sign);
    NSLog(@"%@",dict);
    
    //token错误
    NSInteger code=[[dict objectForKey:@"code"] integerValue];
    if (code==1001 || code==1511) {//token错误
        [self toLogin];
    }
    
    
    NSInteger status=[[dict objectForKey:@"status"] integerValue];

    if (status==1){
        
        NSDictionary *dic = [dict objectForKey:@"info"];//
        //NSString *unit=[dic objectForKey:@"rental_unit"];//单位
        //[[NSUserDefaults standardUserDefaults]setValue:unit forKey:RENTAL_UNIT];
        //数组添加对象的顺序
        //房态数组
        NSArray *statusArr = [[NSArray alloc]init];
        
        statusArr = [dic objectForKey:@"list"];
        
        //日期格式
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.dateFormat = @"yyyy-MM-dd";
        //遍历所有日期，获取房态
        for (int i=0; i<statusArr.count; i++) {
            
            NSDictionary *dic1 = statusArr[i];
            
            NSInteger status = [[dic1 objectForKey:@"status"] integerValue];
            
            if (status == 10) {
                
                continue;
                
            }else{
                
                //时间2014-12-2
                NSString *status_date = [dic1 objectForKey:@"status_date"];//status_date
                NSDate *date = [formatter dateFromString:status_date];//date为空
                
                NSTimeInterval timeInterval=[date timeIntervalSince1970];
                
                NSString *dateStr = [NSString stringWithFormat:@"%f", timeInterval];
                
                //每个日期的数据模型
                NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
                [dic2 setValue:dateStr forKey:@"dateString"];
                [dic2 setValue:date forKey:@"date"];
                [dic2 setValue:@"true" forKey:@"isWare"];
                [sArr addObject:dic2];
                
                //[dic2 setValue:start_time forKey:@"dateString"];
                //[dic2 setValue:startDate forKey:@"date"];
                //[dic2 setValue:@"true" forKey:@"isWare"];
                //[sArr addObject:dic2];
            }
        }

        mArr = [self moneyArr];

        
        for (int i=0; i<mArr.count; i++) {
            for (int j=0; j<sArr.count; j++) {
                if ([[mArr[i] objectForKey:@"dateString"] isEqualToString:[sArr[j] objectForKey:@"dateString"]]) {
                    [mArr[i] setValue:[sArr[j] objectForKey:@"isWare"]forKey:@"isWare"];
                }
            }
        }
        
        
        [self.warehouseArr addObjectsFromArray:sArr];
        [self.warehouseArr addObjectsFromArray:mArr];

    }
    
    for (int i = 0; i <= months; i++) {
        NSDate *month = [today dayInTheFollowingMonth:i];//今天之后的i个月 ？
        NSMutableArray *calendarDays = [[NSMutableArray alloc]init];
        [self calculateDaysInPreviousMonthWithDate:month andArray:calendarDays];
        [self calculateDaysInCurrentMonthWithDate:month andArray:calendarDays];
        [self calculateDaysInFollowingMonthWithDate:month andArray:calendarDays];//计算下月份的天数
        [calendarMonth insertObject:calendarDays atIndex:i];
    }
    
    return calendarMonth;
    
}

    /*
    //创建url对象
    NSString *str = [NSString stringWithFormat:@"house/detail?house_sn=%@", self.housesn];
    NSURL *url = [NSURL URLWithString:[HOSTAPI stringByAppendingString:str]];
    NSDictionary *dic=@{@"house_sn":self.housesn};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"house/detail" timeString:dateStr];
    //创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求方式 这一步可以不写 默认设置为get请求
    [request setHTTPMethod:@"GET"];
    //创建相应对象
    [request setValue:sign forHTTPHeaderField:@"sign"];
    [request setValue:dateStr forHTTPHeaderField:@"timestamp"];
    [request setValue:@"1.0.1" forHTTPHeaderField:@"app_version"];
    [request setValue:@"1.0.1" forHTTPHeaderField:@"api_version"];
    [request setValue:@"130" forHTTPHeaderField:@"platform_type"];

    NSString *lang=[[NSUserDefaults standardUserDefaults]valueForKey:LANGUAGE];
    if ([lang isEqualToString:@"zh-Hans"] || [lang isEqualToString:@"zh-Hans-CN"]) {
        [request setValue:@"zh" forHTTPHeaderField:@"lang"];
    }else{
        [request setValue:@"en" forHTTPHeaderField:@"lang"];
    }
    [request setValue:[[NSUserDefaults standardUserDefaults]valueForKey:ACCESS_TOKEN] forHTTPHeaderField:@"access_token"];
    
    NSURLResponse *response = nil;
    NSError *error;
    //创建连接对象
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"header:%@", request.allHTTPHeaderFields);
    NSLog(@"url:%@", url);
    NSLog(@"sign:%@", sign);
    NSLog(@"%@",dict);
    
    NSInteger status=[[dict objectForKey:@"status"] integerValue];
    
    if (status==1){
        
        NSDictionary *dic = [dict objectForKey:@"info"];//
        NSString *unit=[dic objectForKey:@"rental_unit"];//单位
        [[NSUserDefaults standardUserDefaults]setValue:unit forKey:RENTAL_UNIT];
        //数组添加对象的顺序
        //房态数组
        NSArray *statusArr = [[NSArray alloc]init];
        statusArr = [dic objectForKey:@"house_status"];//
        for (int i=0; i<statusArr.count; i++) {
            NSDictionary *dic = statusArr[i];
            NSString *start_time = [dic objectForKey:@"start_time"];
            NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:[start_time intValue]];
            NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
            [dic2 setValue:start_time forKey:@"dateString"];
            [dic2 setValue:startDate forKey:@"date"];
            [dic2 setValue:@"true" forKey:@"isWare"];
            [sArr addObject:dic2];//房态数组
        }
        
        //租金数组
        NSArray *rentalArr = [[NSArray alloc]init];
        rentalArr = [dic objectForKey:@"house_rental"];//
        
        for (int i=0; i<rentalArr.count; i++) {
            NSDictionary *dic = rentalArr[i];
            NSString *start_time = [dic objectForKey:@"start_time"];
            NSString *rental = [dic objectForKey:@"rental"];
            NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:[start_time intValue]];
            NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
            [dic2 setValue:start_time forKey:@"dateString"];
            [dic2 setValue:startDate forKey:@"date"];
            [dic2 setValue:rental forKey:@"money"];
            [mArr addObject:dic2];//价格数组
        }
        

        for (int i=0; i<mArr.count; i++) {
            for (int j=0; j<sArr.count; j++) {
                if ([[mArr[i] objectForKey:@"dateString"] isEqualToString:[sArr[j] objectForKey:@"dateString"]]) {
                    [mArr[i] setValue:[sArr[j] objectForKey:@"isWare"]forKey:@"isWare"];
                }
            }
        }
        [self.warehouseArr addObjectsFromArray:sArr];
        [self.warehouseArr addObjectsFromArray:mArr];

    }
    */
    
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



//获取价格数组
-(NSMutableArray *)moneyArr{
    
    NSMutableArray *moneyModelArr = [[NSMutableArray alloc]init];
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString* nowString = [formatter stringFromDate:now];
    
    
    NSDate *dateend = [now dateByAddingTimeInterval:60*60*24*365];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateend];
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dateend];
    NSInteger days = 365 + daysInOfMonth.length - comps.day;
    
    NSDate *dateEnd = [now dateByAddingTimeInterval:60*60*24*days];
    NSString* endString = [formatter stringFromDate:dateEnd];
    
    
    
    //获取一年内的房态
    NSString *str = [NSString stringWithFormat:@"house/listrental?house_sn=%@&start_time=%@&end_time=%@", self.housesn, nowString, endString];
    NSURL *url = [NSURL URLWithString:[HOSTAPI stringByAppendingString:str]];
    NSDictionary *dic=@{@"house_sn":self.housesn};
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"house/listrental" timeString:dateStr];
    //创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求方式 这一步可以不写 默认设置为get请求
    [request setHTTPMethod:@"GET"];
    //创建相应对象
    [request setValue:sign forHTTPHeaderField:@"sign"];
    [request setValue:dateStr forHTTPHeaderField:@"timestamp"];
    [request setValue:@"1.0.1" forHTTPHeaderField:@"app_version"];
    [request setValue:@"1.0.1" forHTTPHeaderField:@"api_version"];
    [request setValue:@"130" forHTTPHeaderField:@"platform_type"];
    
    NSString *lang=[[NSUserDefaults standardUserDefaults]valueForKey:LANGUAGE];
    if ([lang isEqualToString:@"zh-Hans"] || [lang isEqualToString:@"zh-Hans-CN"]) {
        [request setValue:@"zh" forHTTPHeaderField:@"lang"];
    }else{
        [request setValue:@"en" forHTTPHeaderField:@"lang"];
    }
    [request setValue:[[NSUserDefaults standardUserDefaults]valueForKey:ACCESS_TOKEN] forHTTPHeaderField:@"access_token"];
    
    NSURLResponse *response = nil;
    NSError *error;
    //创建连接对象
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"header:%@", request.allHTTPHeaderFields);
    NSLog(@"url:%@", url);
    NSLog(@"sign:%@", sign);
    NSLog(@"%@",dict);
    
    //token错误
    NSInteger code=[[dict objectForKey:@"code"] integerValue];
    if (code==1001 || code==1511) {//token错误
        [self toLogin];
    }
    
    NSInteger status=[[dict objectForKey:@"status"] integerValue];
    
    if (status==1){
        
        NSDictionary *dic = [dict objectForKey:@"info"];//
 
        NSArray *moneyArr = [[NSArray alloc]init];
        
        moneyArr = [dic objectForKey:@"list"];
        
        //日期格式
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.dateFormat = @"yyyy-MM-dd";
        //遍历所有日期，获取房态
        for (int i=0; i<moneyArr.count; i++) {
            
            NSDictionary *dic1 = moneyArr[i];
            
            NSInteger rental = [[dic1 objectForKey:@"rental"] integerValue];
            
            if (rental == 0) {
                
                continue;
                
            }else{
                

                //时间2014-12-2
                NSString *rental_date = [dic1 objectForKey:@"rental_date"];
                
                NSDate *date = [formatter dateFromString:rental_date];
                
                NSTimeInterval timeInterval=[date timeIntervalSince1970];
                
                NSString *dateStr = [NSString stringWithFormat:@"%f", timeInterval];
                
                NSString *rental = [dic1 objectForKey:@"rental"];

                //每个日期的数据模型
                NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
                [dic2 setValue:dateStr forKey:@"dateString"];
                [dic2 setValue:date forKey:@"date"];
                [dic2 setValue:rental forKey:@"money"];
                [moneyModelArr addObject:dic2];
                
            }
            
        }
        
    }
    return moneyModelArr;
}


-(BOOL)yesDate:(NSDate *)yesDate endDate:(NSDate *)endDate{
    NSComparisonResult result = [yesDate compare:endDate];
    int ci;
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending: ci=1; break;
            //date02比date01小
        case NSOrderedDescending: ci=-1; break;
            //date02=date01
        case NSOrderedSame: ci=0; break;
            
    }
    if (ci==-1) {
        return false;
    }else{
        return true;
    }
    
}

#pragma mark - 日历上+当前+下月份的天数

//计算上月份的天数

- (NSMutableArray *)calculateDaysInPreviousMonthWithDate:(NSDate *)date andArray:(NSMutableArray *)array
{
    NSUInteger weeklyOrdinality = [[date firstDayOfCurrentMonth] weeklyOrdinality];//计算这个的第一天是礼拜几,并转为int型
    
    NSDate *dayInThePreviousMonth = [date dayInThePreviousMonth];//上一个月的NSDate对象
    
    NSUInteger daysCount = [dayInThePreviousMonth numberOfDaysInCurrentMonth];//计算上个月有多少天
    
    NSUInteger partialDaysCount = weeklyOrdinality - 1;//获取上月在这个月的日历上显示的天数
    
    NSDateComponents *components = [dayInThePreviousMonth YMDComponents];//获取年月日对象
    
    
    
    for (int i = daysCount - partialDaysCount + 1; i < daysCount + 1; ++i) {
        
        CalendarDayModel *calendarDay = [CalendarDayModel calendarDayWithYear:components.year month:components.month day:i];
        calendarDay.style = CellDayTypeEmpty;//不显示
        [array addObject:calendarDay];
    }
    
    
    return NULL;
}



//计算下月份的天数

- (void)calculateDaysInFollowingMonthWithDate:(NSDate *)date andArray:(NSMutableArray *)array
{
    NSUInteger weeklyOrdinality = [[date lastDayOfCurrentMonth] weeklyOrdinality];
    if (weeklyOrdinality == 7) return ;
    
    NSUInteger partialDaysCount = 7 - weeklyOrdinality;
    NSDateComponents *components = [[date dayInTheFollowingMonth] YMDComponents];
    
    for (int i = 1; i < partialDaysCount + 1; ++i) {
        CalendarDayModel *calendarDay = [CalendarDayModel calendarDayWithYear:components.year month:components.month day:i];
        calendarDay.style = CellDayTypeEmpty;
        [array addObject:calendarDay];
    }
}


//计算当月的天数

- (void)calculateDaysInCurrentMonthWithDate:(NSDate *)date andArray:(NSMutableArray *)array
{
    
    NSUInteger daysCount = [date numberOfDaysInCurrentMonth];//计算这个月有多少天
    NSDateComponents *components = [date YMDComponents];//date日期的年月日
    
    //当月遍历每一天
    for (int i = 1; i < daysCount + 1; ++i) {
        
        //每天都创建一个对象
        CalendarDayModel *calendarDay = [CalendarDayModel calendarDayWithYear:components.year month:components.month day:i];
        //每天都和网络请求后的有库存日期比较
        for (int j=0; j<self.warehouseArr.count; j++) {
            
            NSDateComponents *wareComponent = [[self.warehouseArr[j] objectForKey:@"date"] YMDComponents];//有库存日期的年月日
            
            if (components.year==wareComponent.year && components.month==wareComponent.month && i==wareComponent.day) {
                
                if ([[self.warehouseArr[j] objectForKey:@"isWare"] isEqualToString:@"true"]) {
                    calendarDay.is_warehouse=true;
                }else{
                    calendarDay.is_warehouse=false;
                }
                
                calendarDay.money=[self.warehouseArr[j] objectForKey:@"money"];
                
            }
        }
        
        if (calendarDay.money==nil) {
            calendarDay.money=@"0.00";
        }
        
        calendarDay.week = [[calendarDay date]getWeekIntValueWithDate];
        [self changStyle:calendarDay];
        [array addObject:calendarDay];
    }
    
}




- (void)changStyle:(CalendarDayModel *)calendarDay
{
    
    NSDateComponents *calendarToDay  = [today YMDComponents];//今天
    NSDateComponents *calendarbefore = [before YMDComponents];//最后一天
    NSDateComponents *calendarSelect = [select YMDComponents];//默认选择的那一天
    
    
    //被点击选中
    if(calendarSelect.year == calendarDay.year &
       calendarSelect.month == calendarDay.month &
       calendarSelect.day == calendarDay.day){
        
        calendarDay.style = CellDayTypeClick;
        selectcalendarDay = calendarDay;
        
      
    //没被点击选中
    }else{
        
        //昨天乃至过去的时间设置一个灰度
        if (calendarToDay.year >= calendarDay.year &
            calendarToDay.month >= calendarDay.month &
            calendarToDay.day > calendarDay.day) {
            
            calendarDay.style = CellDayTypePast;
          
        //之后的时间时间段
        }else if (calendarbefore.year <= calendarDay.year &
                  calendarbefore.month <= calendarDay.month &
                  calendarbefore.day <= calendarDay.day) {
            
            calendarDay.style = CellDayTypePast;
          
        //需要正常显示的时间段
        }else{
            
            //周末
            if (calendarDay.week == 1 || calendarDay.week == 7){
                calendarDay.style = CellDayTypeWeek;
                
            //工作日
            }else{
                calendarDay.style = CellDayTypeFutur;
            }
        }
    }
 
}


- (void)selectLogic:(CalendarDayModel *)day
{
    
    if (day.style == CellDayTypeClick) {
        return;
    }
    
    day.style = CellDayTypeClick;
    //周末
    if (selectcalendarDay.week == 1 || selectcalendarDay.week == 7){
        selectcalendarDay.style = CellDayTypeWeek;
        
    //工作日
    }else{
        selectcalendarDay.style = CellDayTypeFutur;
    }
    selectcalendarDay = day;
}



@end
