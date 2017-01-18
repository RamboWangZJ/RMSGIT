//
//  LoginBarView.m
//  jjrms
//
//  Created by user on 2016/12/6.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "LoginBarView.h"

@implementation LoginBarView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor=[UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
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
    //_titleLab.lineBreakMode = NSLineBreakByCharWrapping;// Wrap at character boundaries
    _titleLab.textColor=[UIColor colorWithHexString:@"#555555"];
    [_titleLab setFont:[UIFont systemFontOfSize:33]];
    _titleLab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(158*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
        make.right.mas_equalTo(-50*WSCALE);
    }];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
