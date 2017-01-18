//
//  CalendarDayCell.m
//  tttttt
//
//  Created by 张凡 on 14-8-20.
//  Copyright (c) 2014年 张凡. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "CalendarDayCell.h"

@implementation CalendarDayCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    

    __weak typeof(self) weakSelf = self;
    self.backgroundColor=[UIColor whiteColor];
    
    
    _backImg=[[UIImageView alloc]init];
    [self addSubview:_backImg];
    [_backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    //日期
    day_lab = [[UILabel alloc]init];
    day_lab.textAlignment = NSTextAlignmentCenter;
    day_lab.font = [UIFont systemFontOfSize:13];
    [self addSubview:day_lab];
    [day_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
    
    
    _iphone6View=[[UIView alloc]init];
    _iphone6View.backgroundColor=[UIColor colorWithHexString:@"#555555"];
    [self addSubview:_iphone6View];
    [_iphone6View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(3*WSCALE);
        make.right.mas_equalTo(3*WSCALE);
        make.height.mas_equalTo(64*HSCALE);
    }];
    _iphone6View.hidden=YES;


    
    /*
    top_Lab = [[UILabel alloc]init];
    top_Lab.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    top_Lab.textAlignment=NSTextAlignmentCenter;
    top_Lab.font = [UIFont systemFontOfSize:13];
    [self addSubview:top_Lab];
    [top_Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0*HSCALE);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(26*HSCALE);
    }];
    */
    /*
    //价格
    money_lab = [[UILabel alloc]init];
    money_lab.textAlignment = NSTextAlignmentCenter;
    money_lab.font = [UIFont systemFontOfSize:11];
    [self addSubview:money_lab];
    [money_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(34*HSCALE);
        make.height.mas_equalTo(26*HSCALE);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
    
    
    //锁子
    suoziImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"suodi"]];
    [self addSubview:suoziImageView];
    [suoziImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(18*WSCALE, 20*HSCALE));
        make.right.mas_equalTo(-8*WSCALE);
        make.bottom.mas_equalTo(-3*HSCALE);
    }];
    
    
    //库存
    houseNum_lab = [[UILabel alloc]init];
    houseNum_lab.textAlignment = NSTextAlignmentCenter;
    houseNum_lab.font = [UIFont systemFontOfSize:13];
    [self addSubview:houseNum_lab];
    [houseNum_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-2);
        make.height.mas_equalTo(15*HSCALE);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
    houseNum_lab.hidden=true;
    */
  
}


- (void)setModel:(CalendarDayModel *)model
{

    /*
    houseNum_lab.hidden=YES;; // 重用的时候如果没有这句 会出现部分cell 这个lab没有隐藏掉
    money_lab.hidden=YES;
    day_lab.hidden=YES;
    top_Lab.hidden=YES;
    suoziImageView.hidden=YES;
     */
    
    //self.backgroundColor=[UIColor whiteColor]; // 如果在这里进行强调， 会出现错乱的背景重用
    
    _backImg.image=[UIImage imageNamed:@"gezi"];
    _iphone6View.hidden=YES;
    //NSLog(@"%@...",model.type);
    
    
    switch (model.style) {
        case CellDayTypeEmpty://不显示
            [self hidden_YES];
            break;
        case CellDayTypePast://过去的日期
            [self hidden_NO];
            if (model.holiday) {
                day_lab.text = model.holiday;
            }else{
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
            }
            day_lab.textColor = [UIColor colorWithHexString:@"#cccccc"];
            break;
        case CellDayTypeFutur://将来的日期
            [self hidden_NO];
            if (model.holiday) {
                day_lab.text = model.holiday;
                day_lab.textColor = [UIColor lightGrayColor];
            }else{
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                day_lab.textColor = [UIColor lightGrayColor];
            }
            break;
        case CellDayTypeWeek://周末
            [self hidden_NO];
            if (model.holiday) {
                day_lab.text = model.holiday;
                day_lab.textColor = [UIColor lightGrayColor];
            }else{
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                day_lab.textColor = [UIColor lightGrayColor];
            }
            break;
            
        case CellDayTypeClick://被点击的日期
            [self hidden_NO];
            day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
            day_lab.textColor = [UIColor lightGrayColor];
            break;
            
        default:
            break;
    }

    /*
    if (model.is_warehouse) {//有锁子
        day_lab.hidden=YES;
        top_Lab.hidden=NO;
        suoziImageView.hidden=NO;
        self.layer.borderWidth=0.4;
        self.layer.borderColor=[UIColor lightGrayColor].CGColor;
        top_Lab.text=[NSString stringWithFormat:@"%lu",(unsigned long)model.day];//上部日期
        
        if (model.money) {
            day_lab.hidden=YES;
            top_Lab.hidden=NO;
            self.layer.borderWidth=0.4;
            self.layer.borderColor=[UIColor lightGrayColor].CGColor;
            top_Lab.text=[NSString stringWithFormat:@"%lu",(unsigned long)model.day];//上部日期
            money_lab.hidden=NO;
            double money_dou=model.money.doubleValue/100;
            money_lab.text=[NSString stringWithFormat:@"%.0f",money_dou];
        }
        
    }else{//价格 锁 都没有
        self.layer.borderWidth=0;
        day_lab.backgroundColor=[UIColor clearColor];
        top_Lab.hidden=YES;
        suoziImageView.hidden=YES;
        
        
        if (model.money) {
            day_lab.hidden=YES;
            top_Lab.hidden=NO;
            self.layer.borderWidth=0.4;
            self.layer.borderColor=[UIColor lightGrayColor].CGColor;
            top_Lab.text=[NSString stringWithFormat:@"%lu",(unsigned long)model.day];//上部日期
            money_lab.hidden=NO;
            double money_dou=model.money.doubleValue/100;
            money_lab.text=[NSString stringWithFormat:@"%.0f",money_dou];
        }
    }
     */
    
    
    //房态关
    if (model.is_warehouse) {
        _backImg.image=[UIImage imageNamed:@"Cell_p6_3"];//wu
    }
    
    //点击效果
    if ([model.type isEqualToString:@"sele"] ) {
        switch (model.selectStyle) {
            case CellSelectTypeYuan:
                _backImg.image=[UIImage imageNamed:@"yuan"];
                break;
            case CellSelectTypeLeftYuan:
                _backImg.image=[UIImage imageNamed:@"zuoyuan"];
                _iphone6View.hidden=NO;
                break;
            case CellSelectTypeRightYuan:
                _backImg.image=[UIImage imageNamed:@"youyuan"];
                break;
            case CellSelectTypeCenter:
                _backImg.image=[UIImage imageNamed:@"kuai"];
                _iphone6View.hidden=NO;
                break;
            default:
                break;
        }
        day_lab.textColor=[UIColor whiteColor];
    }else if(model.is_warehouse){
        _backImg.image=[UIImage imageNamed:@"Cell_p6_3"];//wu
    }else{
        _backImg.image=[UIImage imageNamed:@"gezi"];//wu
        day_lab.textColor=[UIColor lightGrayColor];
    }
    
    

    

}


- (void)hidden_YES{
    day_lab.hidden = YES;
}
- (void)hidden_NO{
    day_lab.hidden = NO;
}


@end
