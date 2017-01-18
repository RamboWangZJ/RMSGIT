//
//  CalendarLogic1.h
//  Calendar
//
//  Created by 张凡 on 14-7-3.
//  Copyright (c) 2014年 张凡. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <Foundation/Foundation.h>
#import "CalendarDayModel.h"
#import "NSDate+WQCalendarLogic.h"
#import "httpManager.h"
#import "DataProcessing.h"
#import "LoginViewController.h"
@interface CalendarLogic : NSObject<UIAlertViewDelegate>
@property(nonatomic,retain)NSMutableArray *warehouseArr;//
@property(nonatomic,assign)BOOL isWare;//锁
- (NSMutableArray *)reloadCalendarView:(NSDate *)date  selectDate:(NSDate *)date1 needDays:(int)days_number;
- (void)selectLogic:(CalendarDayModel *)day;

@property(nonatomic,retain)NSString *housesn;//

@end
