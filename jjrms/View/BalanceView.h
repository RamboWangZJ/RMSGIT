//
//  BalanceView.h
//  jjrms
//
//  Created by user on 16/10/20.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "Commen.h"
#import "UIColor+Helper.h"
#import "MJExtension.h"
#import "NSObject+MJKeyValue.h"
@interface BalanceView : UIView
@property(nonatomic,retain)UILabel *moneyLable1;
@property(nonatomic,retain)UILabel *moneyLable2;
@property(nonatomic,retain)UILabel *moneyLable3;
@property(nonatomic,retain)UIButton *tixian1;
@property(nonatomic,retain)UIButton *tixian2;
@property(nonatomic,retain)UIButton *tixian3;
-(void)reloadUI;
@end
