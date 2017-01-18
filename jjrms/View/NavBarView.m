//
//  NavBarView.m
//  jjrms
//
//  Created by user on 16/10/18.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "NavBarView.h"

@implementation NavBarView

static NSString *COLOR_line=@"#DDDDDD";


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    
    self.backgroundColor=[UIColor whiteColor];
    //__weak typeof(self) weakSelf = self;

    self.backBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBut setImage:[UIImage imageNamed:@"fanhuinews"] forState:UIControlStateNormal];
    [self addSubview:self.backBut];
    [self.backBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60*WSCALE, 60*HSCALE));
        make.left.mas_equalTo(18*WSCALE);
        make.top.mas_equalTo(35*HSCALE);
    }];
    
    _titleLab=[[UILabel alloc]init];
    _titleLab.numberOfLines=0;
    _titleLab.textColor=[UIColor colorWithHexString:@"#555555"];
    [_titleLab setFont:[UIFont systemFontOfSize:24]];
    _titleLab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(158*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
        make.right.mas_equalTo(-50*WSCALE);

    }];

    
    
    _lineView=[[UIView alloc]init];
    _lineView.backgroundColor=[UIColor colorWithHexString:COLOR_line];
    [self addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_titleLab.mas_width);
        make.height.mas_equalTo(2*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
        make.top.mas_equalTo(252*HSCALE);
    }];
    
    
    /*
    self.backgroundColor=[UIColor colorWithHexString:@"#343b47"];
    
    __weak typeof(self) weakSelf = self;

    self.backBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBut setImage:[UIImage imageNamed:@"fanhuiNew"] forState:UIControlStateNormal];
    [self addSubview:self.backBut];
    [self.backBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60*WSCALE, 60*HSCALE));
        make.left.mas_equalTo(12*WSCALE);
        make.bottom.mas_equalTo(-10*WSCALE);
    }];
    

    
    self.titleLab=[[UILabel alloc]init];
    self.titleLab.textColor=[UIColor whiteColor];
    //self.titleLab.font=[UIFont systemFontOfSize:16];
    [self.titleLab setFont:[UIFont fontWithName:CUTI size:16]];
    

    self.titleLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf);
        make.height.mas_equalTo(50*HSCALE);
        make.bottom.mas_equalTo(-13*HSCALE);
    }];
    
    
    
    self.rightBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightBut.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.rightBut setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self addSubview:self.rightBut];
    [self.rightBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120*WSCALE, 50*HSCALE));
        make.right.mas_equalTo(-20*WSCALE);
        make.centerY.mas_equalTo(self.titleLab.mas_centerY);
    }];
    */
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
