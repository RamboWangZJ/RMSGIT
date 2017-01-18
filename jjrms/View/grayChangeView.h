//
//  grayChangeView.h
//  jjrms
//
//  Created by user on 16/9/29.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarDayModel.h"

@interface grayChangeView : UIView<UITextFieldDelegate>



@property(nonatomic, retain)UILabel *name;
@property(nonatomic, retain)UILabel *beginTime;
@property(nonatomic, retain)UILabel *endTime;

@property(nonatomic, retain)UILabel *fangtai;
@property(nonatomic, retain)UIButton *kaibut;
@property(nonatomic, retain)UILabel *kai;

@property(nonatomic, retain)UIButton *guanbut;
@property(nonatomic, retain)UILabel *guan;

@property(nonatomic, retain)UIButton *cancel;
@property(nonatomic, retain)UIButton *save;

@property(nonatomic, retain)NSDate *qiDate;
@property(nonatomic, retain)NSDate *zhiDate;

@property(nonatomic, retain)UIButton *open;
@property(nonatomic, retain)UIButton *close;

@property(nonatomic, assign)BOOL isOpeen;
@property(nonatomic, assign)BOOL isClose;

@property(nonatomic,retain)UITextField *moneyTextField;

@property(nonatomic, retain)CalendarDayModel *model;
-(BOOL)isTrueDate;
-(NSMutableDictionary *)dealedData;
-(void)reInitDatePicker:(CalendarDayModel *)model;//点击某个日期，调用这个方法
@end
