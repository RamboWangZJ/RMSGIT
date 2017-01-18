//
//  CalendarDayCell.h
//  tttttt
//
//  Created by 张凡 on 14-8-20.
//  Copyright (c) 2014年 张凡. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>
#import "CalendarDayModel.h"
#import "Color.h"
#import "Masonry.h"
#import "UIColor+Helper.h"
#import "Commen.h"



@interface CalendarDayCell : UICollectionViewCell
{
    UILabel *day_lab;//今天的日期或者是节日
    UILabel *day_title;//显示标签
    UIImageView *imgview;//选中时的图片
    
    UIImageView *suoziImageView;//锁子
    UILabel *top_Lab;//灰色label
    UILabel *money_lab;//当日价格
    UILabel *houseNum_lab;//当日库存
    
    
    UIImageView *_backImg;
    UIView *_iphone6View;
}

@property(nonatomic , strong)CalendarDayModel *model;

@end
