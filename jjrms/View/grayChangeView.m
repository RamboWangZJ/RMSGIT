//
//  grayChangeView.m
//  jjrms
//
//  Created by user on 16/9/29.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "grayChangeView.h"
#import "UIColor+Helper.h"
#import "Commen.h"
#import "Masonry.h"
@implementation grayChangeView
{
    UIButton *_houseBut;
    UIButton *_moneyBut;
    UIView *_lineView;
    UIView *_lineViewShu;
    UIView *_lineViewShu2;
    UIView *_lineViewHeng1;
    UIView *_lineViewHeng2;
    UIView *_lineViewHeng3;
    UIView *_lineViewHeng4;



    
    UIView *_whiteView;
    UILabel *_qi;
    UILabel *_zhi;
    UIButton *_qixiala;
    UIButton *_zhixiala;
    
    UIDatePicker *_datePickerBegin;
    UIDatePicker *_datePickerEed;
    
    UILabel *_openL;
    UILabel *_closeL;
    UILabel *_state;
    
    UILabel *_danwei;
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
    
}

-(void)initView{
    
    
    self.qiDate=[[NSDate alloc]init];

    self.zhiDate=[[NSDate alloc]init];

    __weak typeof(self) weakSelf = self;

    self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];

    
    _whiteView=[[UIView alloc]init];
    _whiteView.backgroundColor=[UIColor whiteColor];
    _whiteView.alpha=1;
    _whiteView.layer.masksToBounds=YES;
    _whiteView.layer.cornerRadius=8;
    [self addSubview:_whiteView];
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if(iPhone5||iPhone4){
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 400*HSCALE));
        }else{
            make.size.mas_equalTo(CGSizeMake(580*WSCALE, 400*HSCALE));
        }
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];
    
    UITapGestureRecognizer *whiteViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    // 设置触控对象
    [whiteViewTap setNumberOfTouchesRequired:1];
    // 设置轻拍的次数
    [whiteViewTap setNumberOfTapsRequired:1];
    // 给创建好的视图添加手势 (一个视图可以添加多个手势，但是一个手势只能添加到一个视图上）
    [_whiteView addGestureRecognizer:whiteViewTap];
    
    
    
    _houseBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [_houseBut setTitle:NSLocalizedString(@"xiugaifangtai_ca",nil) forState:UIControlStateNormal];
    [_houseBut addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    [_houseBut setTitleColor:[UIColor colorWithHexString:@"#343b47"] forState:UIControlStateNormal];
    _houseBut.tag=1005;
    _houseBut.titleLabel.font=[UIFont systemFontOfSize:15];
    [_houseBut setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_whiteView addSubview:_houseBut];
    [_houseBut mas_makeConstraints:^(MASConstraintMaker *make) {
        if(iPhone5||iPhone4){
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, 80*HSCALE));
        }else{
            make.size.mas_equalTo(CGSizeMake(580/2*WSCALE, 80*HSCALE));
        }
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    _moneyBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [_moneyBut setTitle:NSLocalizedString(@"xiugaijiage_ca",nil) forState:UIControlStateNormal];
    [_moneyBut addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    [_moneyBut setTitleColor:[UIColor colorWithHexString:@"#343b47"] forState:UIControlStateNormal];
    _moneyBut.tag=1006;
    _moneyBut.titleLabel.font=[UIFont systemFontOfSize:15];
    [_moneyBut setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_whiteView addSubview:_moneyBut];
    [_moneyBut mas_makeConstraints:^(MASConstraintMaker *make) {
        if(iPhone5||iPhone4){
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, 80*HSCALE));
        }else{
            make.size.mas_equalTo(CGSizeMake(580/2*WSCALE, 80*HSCALE));
        }
        make.left.mas_equalTo(580/2*WSCALE);
        make.top.mas_equalTo(0);
    }];
    
    
//起时间行
    _qi=[[UILabel alloc]init];
    _qi.textAlignment=NSTextAlignmentLeft;
    _qi.textColor=[UIColor colorWithHexString:@"#343b47"];
    _qi.font=[UIFont systemFontOfSize:15];
    [_whiteView addSubview:_qi];
    [_qi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(72*HSCALE);
        make.top.mas_equalTo(80*HSCALE);
        make.left.mas_equalTo(30*WSCALE);
        make.width.mas_equalTo(80*WSCALE);
    }];_qi.text=NSLocalizedString(@"qi_ca",nil);

    
    self.beginTime=[[UILabel alloc]init];
    self.beginTime.textAlignment=NSTextAlignmentCenter;
    self.beginTime.textColor=[UIColor colorWithHexString:@"#666666"];
    [_whiteView addSubview:self.beginTime];
    [self.beginTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(72*HSCALE);
        make.top.mas_equalTo(_qi.mas_top);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *qiStrLable=[dateFormatter stringFromDate:[[NSDate alloc]init]];
    self.beginTime.text=qiStrLable;
    
    UITapGestureRecognizer *beginTimeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(qiTapAction:)];
    // 设置触控对象
    [beginTimeTap setNumberOfTouchesRequired:1];
    // 设置轻拍的次数
    [beginTimeTap setNumberOfTapsRequired:1];
    self.beginTime.userInteractionEnabled=true;
    [self.beginTime addGestureRecognizer:beginTimeTap];
    
    
    _qixiala=[UIButton buttonWithType:UIButtonTypeCustom];
    [_qixiala setBackgroundImage:[UIImage imageNamed:@"xiala_TRA"] forState:UIControlStateNormal];
    [_qixiala addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    _qixiala.tag=1001;
    [_whiteView addSubview:_qixiala];
    [_qixiala mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60*WSCALE, 60*HSCALE));
        make.centerY.mas_equalTo(_qi.mas_centerY);
        make.right.mas_equalTo(-22*WSCALE);
    }];
    
    
    _datePickerBegin=[[UIDatePicker alloc]init];
    _datePickerBegin.datePickerMode=UIDatePickerModeDate;
    [_datePickerBegin addTarget:self action:@selector(datePickerBeginChange:) forControlEvents:UIControlEventValueChanged];
    NSString *qiStr=[dateFormatter stringFromDate:[[NSDate alloc]init]];
    [_datePickerBegin setMinimumDate:[dateFormatter dateFromString:qiStr]];
    [_datePickerBegin setMaximumDate:[dateFormatter dateFromString:@"2018-12-31"]];
    
    NSString *lang=@"";
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:LANGUAGE] isEqualToString:@"zh-Hans"] || [[[NSUserDefaults standardUserDefaults]valueForKey:LANGUAGE] isEqualToString:@"zh-Hans-CN"]) {
        lang=@"zh_CN";
    }else{
        lang=@"en";
    }
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:lang];//设置为中文
    
    _datePickerBegin.locale = locale;
    [_whiteView addSubview:_datePickerBegin];
    [_datePickerBegin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_qi.mas_centerY);
        make.height.mas_equalTo(244*HSCALE);
        //make.left.mas_equalTo(_qi.mas_right).offset(50*WSCALE);
        //make.right.mas_equalTo(-60*WSCALE);
        make.left.mas_equalTo(_qi.mas_right).offset(0*WSCALE);
        make.right.mas_equalTo(-0*WSCALE);
    }];
    _datePickerBegin.hidden=true;

    
    
    
//止时间行
    _zhi=[[UILabel alloc]init];
    _zhi.textAlignment=NSTextAlignmentLeft;
    _zhi.textColor=[UIColor colorWithHexString:@"#343b47"];
    _zhi.font=[UIFont systemFontOfSize:15];
    [_whiteView addSubview:_zhi];
    [_zhi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(72*HSCALE);
        make.top.mas_equalTo(_qi.mas_bottom);
        make.left.mas_equalTo(30*WSCALE);
        make.width.mas_equalTo(50*WSCALE);
    }];_zhi.text=NSLocalizedString(@"zhi_ca",nil);
    
    
    self.endTime=[[UILabel alloc]init];
    self.endTime.textAlignment=NSTextAlignmentCenter;
    self.endTime.textColor=[UIColor colorWithHexString:@"#666666"];
    [_whiteView addSubview:self.endTime];
    [self.endTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(72*HSCALE);
        make.top.mas_equalTo(_zhi.mas_top);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
    self.endTime.text=qiStrLable;
    UITapGestureRecognizer *endTimeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endTapAction:)];
    // 设置触控对象
    [endTimeTap setNumberOfTouchesRequired:1];
    // 设置轻拍的次数
    [endTimeTap setNumberOfTapsRequired:1];
    self.endTime.userInteractionEnabled=true;
    [self.endTime addGestureRecognizer:endTimeTap];
    
    _zhixiala=[UIButton buttonWithType:UIButtonTypeCustom];
    [_zhixiala setBackgroundImage:[UIImage imageNamed:@"xiala_TRA"] forState:UIControlStateNormal];
    [_zhixiala addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    _zhixiala.tag=1002;
    [_whiteView addSubview:_zhixiala];
    [_zhixiala mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60*WSCALE, 60*HSCALE));
        make.centerY.mas_equalTo(_zhi.mas_centerY);
        make.right.mas_equalTo(-22*WSCALE);
    }];
    
    
    
    _datePickerEed=[[UIDatePicker alloc]init];
    _datePickerEed.datePickerMode=UIDatePickerModeDate;
    [_datePickerEed addTarget:self action:@selector(datePickerEndChange:) forControlEvents:UIControlEventValueChanged];
    [_datePickerEed setMinimumDate:[dateFormatter dateFromString:qiStr]];
    [_datePickerEed setMaximumDate:[dateFormatter dateFromString:@"2018-12-31"]];
    _datePickerEed.locale = locale;
    [_whiteView addSubview:_datePickerEed];
    [_datePickerEed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_zhi.mas_centerY);
        make.height.mas_equalTo(244*HSCALE);
        //make.left.mas_equalTo(_zhi.mas_right).offset(50*WSCALE);
        //make.right.mas_equalTo(-60*WSCALE);
        make.left.mas_equalTo(_qi.mas_right).offset(0*WSCALE);
        make.right.mas_equalTo(0*WSCALE);
    }];
    _datePickerEed.hidden=true;
    
    
//取消 保存
    self.cancel=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancel setTitle:NSLocalizedString(@"qvxiao",nil) forState:UIControlStateNormal];
    [self.cancel setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    self.cancel.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.cancel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_whiteView addSubview:self.cancel];
    [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(580/2*WSCALE, 88*HSCALE));
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    self.save=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.save setTitle:NSLocalizedString(@"queren",nil) forState:UIControlStateNormal];
    [self.save setTitleColor:[UIColor colorWithHexString:@"#64b8f0"] forState:UIControlStateNormal];
    self.save.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.save setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_whiteView addSubview:self.save];
    [self.save mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(580/2*WSCALE, 88*HSCALE));
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
//房态 /基础价格
    _state=[[UILabel alloc]init];
    _state.textAlignment=NSTextAlignmentCenter;
    _state.textColor=[UIColor colorWithHexString:@"#343b47"];
    _state.font=[UIFont systemFontOfSize:15];
    [_whiteView addSubview:_state];
    [_state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(72*HSCALE);
        make.left.mas_equalTo(30*WSCALE);
        //make.width.mas_equalTo(50*WSCALE);
        make.bottom.mas_equalTo(self.cancel.mas_top);
    }];_state.text=NSLocalizedString(@"fangtai_ca",nil);

    
    
    
    self.open=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.open setImage:[UIImage imageNamed:@"guan"] forState:UIControlStateNormal];
    [self.open setImage:[UIImage imageNamed:@"kai"] forState:UIControlStateSelected];
    [self.open addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    self.open.tag=1003;
    [self.open setSelected:YES];
    [_whiteView addSubview:self.open];
    [self.open mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(26*WSCALE, 26*HSCALE));
        make.centerY.mas_equalTo(_state.mas_centerY);
        make.left.mas_equalTo(160*WSCALE);
    }];
    
    
    
    _openL=[[UILabel alloc]init];
    _openL.textAlignment=NSTextAlignmentCenter;
    _openL.textColor=[UIColor colorWithHexString:@"#343b47"];
    _openL.font=[UIFont systemFontOfSize:15];
    [_whiteView addSubview:_openL];
    [_openL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(72*HSCALE);
        make.left.mas_equalTo(_open.mas_right).offset(12*WSCALE);
        make.centerY.mas_equalTo(_state.mas_centerY);
    }];_openL.text=NSLocalizedString(@"kai_ca",nil);
    
    
    
    self.close=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.close setImage:[UIImage imageNamed:@"guan"] forState:UIControlStateNormal];
    [self.close setImage:[UIImage imageNamed:@"kai"] forState:UIControlStateSelected];
    [self.close addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    self.close.tag=1004;
    [_whiteView addSubview:self.close];
    [_close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(26*WSCALE, 26*HSCALE));
        make.centerY.mas_equalTo(_state.mas_centerY);
        make.left.mas_equalTo(340*WSCALE);
    }];
    
    

    _closeL=[[UILabel alloc]init];
    _closeL.textAlignment=NSTextAlignmentCenter;
    _closeL.textColor=[UIColor colorWithHexString:@"#343b47"];
    _closeL.font=[UIFont systemFontOfSize:15];
    [_whiteView addSubview:_closeL];
    [_closeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(72*HSCALE);
        make.left.mas_equalTo(_close.mas_right).offset(12*WSCALE);
        make.centerY.mas_equalTo(_state.mas_centerY);
    }];_closeL.text=NSLocalizedString(@"guan_ca",nil);
    
    
    _danwei=[[UILabel alloc]init];
    //_closeL.textAlignment=NSTextAlignmentCenter;
    _danwei.textColor=[UIColor colorWithHexString:@"#343b47"];
    [_whiteView addSubview:_danwei];
    [_danwei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(72*HSCALE);
        make.right.mas_equalTo(-30*WSCALE);
        make.centerY.mas_equalTo(_state.mas_centerY);
    }];_danwei.text=[[NSUserDefaults standardUserDefaults]valueForKey:RENTAL_UNIT];
    _danwei.hidden=true;
    
    
    self.moneyTextField=[[UITextField alloc]init];
    self.moneyTextField.placeholder=@"0";
    self.moneyTextField.textColor=[UIColor colorWithHexString:@"#343b47"];
    self.moneyTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_whiteView addSubview:self.moneyTextField];
    [self.moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(130*WSCALE, 46*HSCALE));
        make.centerY.mas_equalTo(_state.mas_centerY);
        make.right.mas_equalTo(_danwei.mas_left).offset(-12*WSCALE);
    }];
    self.moneyTextField.hidden=true;
    self.moneyTextField.delegate=self;
    
    
    
    _lineView=[[UIView alloc]init];
    [_whiteView addSubview:_lineView];
    _lineView.backgroundColor=[UIColor colorWithHexString:@"#64b8f0"];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(CGSizeMake(540/2*WSCALE, 4*HSCALE));
        if(iPhone5||iPhone4){
            make.size.mas_equalTo(CGSizeMake(300*WSCALE, 4*HSCALE));
        }else{
            make.size.mas_equalTo(CGSizeMake(540/2*WSCALE, 4*HSCALE));
        }
        make.left.mas_equalTo(10*WSCALE);
        make.bottom.mas_equalTo(_houseBut.mas_bottom);
    }];
    
    
    
    _lineViewShu=[[UIView alloc]init];
    [_whiteView addSubview:_lineViewShu];
    _lineViewShu.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    [_lineViewShu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1*WSCALE, 60*HSCALE));
        if(iPhone5||iPhone4){
            make.left.mas_equalTo((SCREEN_WIDTH)/2);
        }else{
            make.left.mas_equalTo(580/2*WSCALE);
        }
        make.top.mas_equalTo(10*HSCALE);
    }];
    _lineViewShu2=[[UIView alloc]init];
    [_whiteView addSubview:_lineViewShu2];
    _lineViewShu2.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    [_lineViewShu2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1*WSCALE, 60*HSCALE));
        make.left.mas_equalTo(580/2*WSCALE);
        make.bottom.mas_equalTo(-10*HSCALE);
    }];
    _lineViewHeng4=[[UIView alloc]init];//baocun
    [_whiteView addSubview:_lineViewHeng4];
    _lineViewHeng4.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    [_lineViewHeng4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(580*WSCALE, 1*HSCALE));
        make.left.mas_equalTo(0*WSCALE);
        make.bottom.mas_equalTo(_houseBut.mas_bottom);
    }];
    _lineViewHeng3=[[UIView alloc]init];//baocun
    [_whiteView addSubview:_lineViewHeng3];
    _lineViewHeng3.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    [_lineViewHeng3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(580*WSCALE, 1*HSCALE));
        make.left.mas_equalTo(0*WSCALE);
        make.bottom.mas_equalTo(_cancel.mas_top);
    }];
    
    //需要变的线
    _lineViewHeng1=[[UIView alloc]init];
    [_whiteView addSubview:_lineViewHeng1];
    _lineViewHeng1.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    [_lineViewHeng1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(560*WSCALE, 1*HSCALE));
        make.left.mas_equalTo(10*WSCALE);
        make.top.mas_equalTo(_qi.mas_bottom);
    }];
    
    _lineViewHeng2=[[UIView alloc]init];
    [_whiteView addSubview:_lineViewHeng2];
    _lineViewHeng2.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
    [_lineViewHeng2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(560*WSCALE, 1*HSCALE));
        make.left.mas_equalTo(10*WSCALE);
        make.top.mas_equalTo(_zhi.mas_bottom);
    }];
    
}

#pragma 主要
#pragma 试图内所有按钮点击事件
-(void)butAction:(UIButton *)but{

//修改起始日期
    if (but.tag==1001) {
        [self qiLineTap];
    }
//修改止时间
    if (but.tag==1002) {
        [self endLineTap];
    }
    
//开
    if (but.tag==1003) {
        but.selected=!but.selected;
        
        if (but.isSelected) {
            [self.close setSelected:false];
        }
    }
    
//关
    if (but.tag==1004) {
        but.selected=!but.selected;
        
        if (but.isSelected) {
            [self.open setSelected:false];
        }

    }
    
    
//修改房态
    if (but.tag==1005) {
        _state.text=NSLocalizedString(@"fangtai_ca",nil);
        self.open.hidden=false;
        _openL.hidden=false;
        self.close.hidden=false;
        _closeL.hidden=false;
        _danwei.hidden=true;
        self.moneyTextField.hidden=true;
        [_houseBut setTitleColor:[UIColor colorWithHexString:@"#64b8f0"] forState:UIControlStateNormal];
        [_moneyBut setTitleColor:[UIColor colorWithHexString:@"#343b47"] forState:UIControlStateNormal];
        [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            //make.left.mas_equalTo(10*WSCALE);
            if(iPhone5||iPhone4){
                make.left.mas_equalTo(10*WSCALE);
            }else{
                make.left.mas_equalTo(10*WSCALE);
            }
        }];
    }
//修改价格
    if (but.tag==1006) {
        _state.text=NSLocalizedString(@"jichujiage_ca",nil);
        self.open.hidden=true;
        _openL.hidden=true;
        self.close.hidden=true;
        _closeL.hidden=true;
        _danwei.hidden=false;
        self.moneyTextField.hidden=false;
        [_houseBut setTitleColor:[UIColor colorWithHexString:@"#343b47"] forState:UIControlStateNormal];
        [_moneyBut setTitleColor:[UIColor colorWithHexString:@"#64b8f0"] forState:UIControlStateNormal];
        [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            //make.left.mas_equalTo(580/2*WSCALE + 10*WSCALE);
            if(iPhone5||iPhone4){
                make.left.mas_equalTo(320*WSCALE + 10*WSCALE);
            }else{
                make.left.mas_equalTo(580/2*WSCALE + 10*WSCALE);
            }
        }];
    }
    
}

-(void)qiTapAction:(UITapGestureRecognizer *)tap{
    [self qiLineTap];
}
-(void)endTapAction:(UITapGestureRecognizer *)tap{
    [self endLineTap];
}
#pragma 价格输入时调整背景位置
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    __weak typeof(self) weakSelf = self;
    [_whiteView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if(iPhone5||iPhone4){
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 572*HSCALE));
        }else{
            make.size.mas_equalTo(CGSizeMake(580*WSCALE, 572*HSCALE));
        }
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(150*HSCALE);
    }];

}


#pragma 轻拍起时间、起时间下拉
-(void)qiLineTap{
    [_whiteView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(572*HSCALE);
    }];
    [_qi mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80*HSCALE);
        make.height.mas_equalTo(244*HSCALE);
    }];

    //止时间行
    [_zhi mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(324*HSCALE);
        make.height.mas_equalTo(72*HSCALE);
    }];
    
    self.endTime.hidden=false;
    _zhixiala.hidden=false;
    [self.endTime mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_zhi.mas_top);
    }];
    [_zhixiala mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_zhi.mas_centerY);
    }];
    
    self.beginTime.hidden=true;
    _qixiala.hidden=true;
    self.endTime.hidden=false;
    _zhixiala.hidden=false;
    _datePickerBegin.hidden=false;
    _datePickerEed.hidden=true;
}

#pragma 轻拍止时间、止时间下拉
-(void)endLineTap{
    [_whiteView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(572*HSCALE);
    }];
    [_qi mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80*HSCALE);
        make.height.mas_equalTo(72*HSCALE);
    }];
    [self.beginTime mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_qi.mas_centerY);
    }];
    [_qixiala mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_qi.mas_centerY);
    }];
    
    //止时间行
    [_zhi mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(152*HSCALE);
        make.height.mas_equalTo(244*HSCALE);
    }];
    
    self.beginTime.hidden=false;
    _qixiala.hidden=false;
    _datePickerBegin.hidden=true;
    
    
    self.endTime.hidden=true;
    _zhixiala.hidden=true;
    
    _datePickerBegin.hidden=true;
    _datePickerEed.hidden=false;

}

#pragma 显示原始高度，隐藏时间选择器
-(void)saveDatePicker{
    NSLog(@"saveDatePicker");
    [_whiteView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(400*HSCALE);
    }];
    [_qi mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80*HSCALE);
        make.height.mas_equalTo(72*HSCALE);
    }];
    [_zhi mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_qi.mas_bottom);
        make.height.mas_equalTo(72*HSCALE);
    }];
    //_beginTime.hidden=false;
    self.beginTime.hidden=false;
    _qixiala.hidden=false;
    self.endTime.hidden=false;
    _zhixiala.hidden=false;
    _datePickerBegin.hidden=true;
    _datePickerEed.hidden=true;
}



#pragma 选择框的结果
-(NSMutableDictionary *)dealedData{
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSString *qistr = [dateFormatter stringFromDate:self.qiDate];
    //NSString *zhistr = [dateFormatter stringFromDate:self.zhiDate];
    NSString *qistr = [dateFormatter stringFromDate:self.qiDate];
    NSString *zhistr = [dateFormatter stringFromDate:self.zhiDate];
    [dic setValue:qistr forKey:@"start_time"];
    [dic setValue:zhistr forKey:@"end_time"];
    if (_lineView.frame.origin.x<50*WSCALE){
        [dic setValue:@"status" forKey:@"check"];
        //房态
        if (self.open.isSelected) {
            [dic setValue:@"10" forKey:@"house_status"];
        }else{
            [dic setValue:@"20" forKey:@"house_status"];
        }

    }else{
        [dic setValue:@"money" forKey:@"check"];
        //价格
        double money_dou=self.moneyTextField.text.doubleValue*100;
        NSNumber *num = [[NSNumber alloc]initWithDouble:money_dou];
        [dic setValue:num forKey:@"house_rental"];
    }

    return dic;
}



- (void)datePickerBeginChange:(UIDatePicker *)paramPicker{
    self.qiDate=paramPicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *qiDate=[dateFormatter stringFromDate:paramPicker.date];
    NSLog(@"begin date = %@", qiDate);
    self.beginTime.text=qiDate;
}

- (void)datePickerEndChange:(UIDatePicker *)paramPicker{
    self.zhiDate=paramPicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *qiDate=[dateFormatter stringFromDate:paramPicker.date];
    NSLog(@"end date = %@", qiDate);
    self.endTime.text=qiDate;
}


//bug 2017日期错误


//
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



//日期范围正确性判断
-(BOOL)isTrueDate{
    NSComparisonResult result = [self.qiDate compare:self.zhiDate];
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
    if (ci==1||ci==0) {
        return true;
    }else{
        return false;
    }
    
}

#pragma 日期自适应
- (void)reInitDatePicker:(CalendarDayModel *)model{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *selectDate=[NSString stringWithFormat:@"%lu-%lu-%lu",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day];
    
    [_datePickerBegin setDate:[dateFormatter dateFromString:selectDate]];
    NSDate *qidate=[dateFormatter dateFromString:selectDate];
    NSString *qiStrLable=[dateFormatter stringFromDate:qidate];
    self.beginTime.text=qiStrLable;
    
    [_datePickerEed setDate:[dateFormatter dateFromString:selectDate]];
    self.endTime.text=qiStrLable;
    
    self.qiDate=_datePickerBegin.date;
    self.zhiDate=_datePickerEed.date;
}


#pragma 白色背景轻拍手势
-(void)tapAction:(UITapGestureRecognizer *)tap{
    [self.moneyTextField resignFirstResponder];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
