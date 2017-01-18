//
//  EditView.m
//  jjrms
//
//  Created by user on 2016/11/22.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "EditView.h"

@implementation EditView
{
    //UIButton *_cancel;
    //UIButton *_save;
    UIView *_line;//
    
    UIView *_view1;
    UIView *_view2;
    
    //UILabel *_dateLab;
    
    //UIButton *_kezuBtn;
    //UIButton *_pingbiBtn;
    
    UILabel *_priceLab;
    //UITextField *_input;


    
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
    
}

-(void)initView{
    self.backgroundColor=[UIColor colorWithHexString:@"#F0F0F0"];
    __weak typeof(self) weakSelf = self;

    
    //取消 保存
    _cancel=[UIButton buttonWithType:UIButtonTypeCustom];
    [_cancel setTitle:NSLocalizedString(@"qvxiao",nil) forState:UIControlStateNormal];
    [_cancel setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
    _cancel.titleLabel.font=[UIFont systemFontOfSize:17];
    [_cancel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self addSubview:_cancel];
    [_cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40*WSCALE);
        make.top.mas_equalTo(28*HSCALE);
    }];
    
    
    
    //保存
    _save=[UIButton buttonWithType:UIButtonTypeCustom];
    [_save setTitle:NSLocalizedString(@"baocun_ca",nil) forState:UIControlStateNormal];
    [_save setTitleColor:[UIColor colorWithHexString:@"#00A6A6"] forState:UIControlStateNormal];
    _save.titleLabel.font=[UIFont systemFontOfSize:17];
    [_save setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self addSubview:_save];
    [_save mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-40*WSCALE);
        make.top.mas_equalTo(28*HSCALE);
    }];
    
    _view1=[[UIView alloc] init];
    _view1.backgroundColor=[UIColor colorWithHexString:@"#E0E0E0"];
    [self addSubview:_view1];
    [_view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(560*WSCALE, 100*HSCALE));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(180*HSCALE);
    }];
    _view1.layer.cornerRadius = 6;
    _view1.layer.masksToBounds = YES;
    
    
    _view2=[[UIView alloc] init];
    _view2.backgroundColor=[UIColor whiteColor];
    [self addSubview:_view2];
    [_view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(560*WSCALE, 100*HSCALE));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.bottom.mas_equalTo(-52*HSCALE);
    }];
    _view2.layer.cornerRadius = 6;
    _view2.layer.masksToBounds = YES;
    
    
    _line=[[UIView alloc] init];
    _line.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [self addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 2*HSCALE));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(86*HSCALE);
    }];
    
    
    _dateLab=[[UILabel alloc]init];
    _dateLab.text=@"";
    _dateLab.textColor=[UIColor colorWithHexString:@"#555555"];
    _dateLab.font=[UIFont systemFontOfSize:16];
    _dateLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_dateLab];
    [_dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120*HSCALE);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
    
    
    _kezuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _kezuBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [_kezuBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_kezuBtn setTitle:NSLocalizedString(@"kezu_ca",nil) forState:UIControlStateNormal];

    [_kezuBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
    [_kezuBtn setAdjustsImageWhenHighlighted:NO];

    
     [_kezuBtn setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected ];

    

    [_view1 addSubview:_kezuBtn];
    [_kezuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0*WSCALE);
        make.bottom.mas_equalTo(0*WSCALE);
        make.left.mas_equalTo(0*WSCALE);
        make.width.mas_equalTo(280*WSCALE);
    }];
    

    
    _pingbiBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _pingbiBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [_pingbiBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_pingbiBtn setTitle:NSLocalizedString(@"yipingbi_ca",nil) forState:UIControlStateNormal];

    [_pingbiBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
    
    [_pingbiBtn setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
  
    [_pingbiBtn setAdjustsImageWhenHighlighted:NO];

    
    [_view1 addSubview:_pingbiBtn];
    [_pingbiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0*WSCALE);
        make.bottom.mas_equalTo(0*WSCALE);
        make.right.mas_equalTo(0*WSCALE);
        make.width.mas_equalTo(280*WSCALE);
    }];

    
    
    
    _priceLab=[[UILabel alloc]init];
    _priceLab.text=NSLocalizedString(@"meiwanprice_ca",nil);
    _priceLab.textColor=[UIColor colorWithHexString:@"#555555"];
    _priceLab.font=[UIFont systemFontOfSize:16];
    _priceLab.textAlignment=NSTextAlignmentLeft;
    [_view2 addSubview:_priceLab];
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(36*HSCALE);
        make.left.mas_equalTo(25*WSCALE);
    }];
   // _priceLab.backgroundColor=[UIColor grayColor];
    
    
    
    
    //价格
    _PriceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_PriceBtn setTitle:@"0" forState:UIControlStateNormal];
    [_PriceBtn setTitleColor:[UIColor colorWithHexString:@"#F06464"] forState:UIControlStateNormal];
    _PriceBtn.titleLabel.font=[UIFont fontWithName:CUTI size:16];
    [_PriceBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_view2 addSubview:_PriceBtn];
    [_PriceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-25*WSCALE);
        //make.left.mas_equalTo(_priceLab.mas_right).offset(20*WSCALE);
        make.centerY.mas_equalTo(_priceLab.mas_centerY);
    }];
   // _pingbiBtn.backgroundColor=[UIColor greenColor];
    
    
    _uint=[[UILabel alloc]init];
    //_uint.text=@"aaaa";
    _uint.textColor=[UIColor colorWithHexString:@"#F06464"];
    _uint.font=[UIFont fontWithName:CUTI size:16];
    _uint.textAlignment=NSTextAlignmentRight;
    [_view2 addSubview:_uint];
    [_uint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_priceLab.mas_centerY);
        make.left.mas_equalTo(_priceLab.mas_right).offset(5*WSCALE);
        make.right.mas_equalTo(_PriceBtn.mas_left).offset(-5*WSCALE);
        make.width.mas_greaterThanOrEqualTo(60*WSCALE);
    }];
    //_uint.backgroundColor=[UIColor lightGrayColor];
  
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
