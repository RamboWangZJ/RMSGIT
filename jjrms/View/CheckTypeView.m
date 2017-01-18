//
//  CheckTypeView.m
//  jjrms
//
//  Created by user on 16/10/20.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "CheckTypeView.h"

@implementation CheckTypeView
{
    UIView *_line;
}
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

    _paypalView=[[UIView alloc]init];
    [self addSubview:_paypalView];
    [_paypalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(600*WSCALE, 98*HSCALE));
        make.left.mas_equalTo(0);
    }];
    
    _PaypalImage=[[UIImageView alloc]init];
    _PaypalImage.image=[UIImage imageNamed:@"p"];
    [self addSubview:_PaypalImage];
    [_PaypalImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40*WSCALE, 40*HSCALE));
        make.left.mas_equalTo(30*WSCALE);
        make.centerY.mas_equalTo(_paypalView.mas_centerY);
    }];
    
    _PaypalName=[[UILabel alloc]init];
    _PaypalName.text=@"paypal";
    _PaypalName.textColor=[UIColor blackColor];
    _PaypalName.font=[UIFont systemFontOfSize:16];
    _PaypalName.textAlignment=NSTextAlignmentLeft;
    [_paypalView addSubview:_PaypalName];
    [_PaypalName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_PaypalImage.mas_centerY);
        make.height.mas_equalTo(30*HSCALE);
        make.left.mas_equalTo(_PaypalImage.mas_right).offset(20*WSCALE);
    }];
    
    
    _line=[[UIView alloc]init];
    [self addSubview:_line];
    _line.backgroundColor=[UIColor colorWithHexString:@"#dddddd"];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(580*WSCALE, 1*HSCALE));
        make.left.mas_equalTo(10*WSCALE);
        make.top.mas_equalTo(98*HSCALE);
    }];
    
    
    _zhifubaoView=[[UIView alloc]init];
    [self addSubview:_zhifubaoView];
    [_zhifubaoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(99*HSCALE);
        make.size.mas_equalTo(CGSizeMake(600*WSCALE, 98*HSCALE));
        make.left.mas_equalTo(0);
    }];
    
    _zhifubaoImage=[[UIImageView alloc]init];
    _zhifubaoImage.image=[UIImage imageNamed:@"z"];
    [self addSubview:_zhifubaoImage];
    [_zhifubaoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40*WSCALE, 40*HSCALE));
        make.left.mas_equalTo(30*WSCALE);
        make.centerY.mas_equalTo(_zhifubaoView.mas_centerY);
    }];
    
    _zhifubaoName=[[UILabel alloc]init];
    _zhifubaoName.text=NSLocalizedString(@"zhifubao_ac",nil);
    _zhifubaoName.textColor=[UIColor blackColor];
    _zhifubaoName.font=[UIFont systemFontOfSize:16];
    _zhifubaoName.textAlignment=NSTextAlignmentLeft;
    [_zhifubaoView addSubview:_zhifubaoName];
    [_zhifubaoName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_zhifubaoImage.mas_centerY);
        make.height.mas_equalTo(30*HSCALE);
        make.left.mas_equalTo(_zhifubaoImage.mas_right).offset(20*WSCALE);
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
