//
//  BalanceView.m
//  jjrms
//
//  Created by user on 16/10/20.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "BalanceView.h"
#import "httpManager.h"
#import "DataProcessing.h"
#import "QuerymoneyModel.h"
@implementation BalanceView
{
    UIImageView *_moneyType1;
    UIImageView *_moneyType2;
    UIImageView *_moneyType3;
    UILabel *_type1;
    UILabel *_type2;
    UILabel *_type3;
    
    UIView *_lineone;//细线
    UIView *_linetwo;//细线
    UIView *_linet;//
    
    UILabel *_titleLab;
    UIView *_lineView;

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

    _titleLab=[[UILabel alloc]init];
    _titleLab.textColor=[UIColor colorWithHexString:@"#555555"];
    _titleLab.text=NSLocalizedString(@"qianbao_tit",nil);
    [_titleLab setFont:[UIFont fontWithName:CUTI size:23]];
    _titleLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
    }];
    
    
    
    _lineView=[[UIView alloc]init];
    _lineView.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [self addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_titleLab.mas_width);
        make.height.mas_equalTo(1.5*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
        make.top.mas_equalTo(_titleLab.mas_bottom).offset(45*HSCALE);
    }];
    

    _type1=[[UILabel alloc]init];
    _type1.text=@"CNY";
    _type1.textColor=[UIColor colorWithHexString:@"#555555"];
    _type1.font=[UIFont systemFontOfSize:15];
    _type1.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_type1];
    [_type1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lineView.mas_bottom).offset(58*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
    }];
    
    _type2=[[UILabel alloc]init];
    _type2.text=@"USD";
    _type2.textColor=[UIColor colorWithHexString:@"#555555"];
    _type2.font=[UIFont systemFontOfSize:15];
    _type2.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_type2];
    [_type2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(94*2*HSCALE + 140*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
    }];
    
    _type3=[[UILabel alloc]init];
    _type3.text=@"JPY";
    _type3.textColor=[UIColor colorWithHexString:@"#555555"];
    _type3.font=[UIFont systemFontOfSize:15];
    _type3.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_type3];
    [_type3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(158*2*HSCALE+140*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
    }];

    
    self.moneyLable1=[[UILabel alloc]init];
    self.moneyLable1.textColor=[UIColor colorWithHexString:@"#555555"];
    self.moneyLable1.font=[UIFont systemFontOfSize:18];
    self.moneyLable1.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.moneyLable1];
    [self.moneyLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_type1.mas_centerY);
        make.left.mas_equalTo(_type1.mas_right).offset(50*WSCALE);
    }];
    self.moneyLable2=[[UILabel alloc]init];
    self.moneyLable2.textColor=[UIColor colorWithHexString:@"#555555"];
    self.moneyLable2.font=[UIFont systemFontOfSize:18];
    self.moneyLable2.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.moneyLable2];
    [self.moneyLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_type2.mas_centerY);
        make.left.mas_equalTo(weakSelf.moneyLable1.mas_left);
    }];
    self.moneyLable3=[[UILabel alloc]init];
    self.moneyLable3.textColor=[UIColor colorWithHexString:@"#555555"];
    self.moneyLable3.font=[UIFont systemFontOfSize:18];
    self.moneyLable3.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.moneyLable3];
    [self.moneyLable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_type3.mas_centerY);
        make.left.mas_equalTo(weakSelf.moneyLable2.mas_left);
    }];
    


    
    self.tixian1=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.tixian1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (iPhone4||iPhone5) {
        self.tixian1.titleLabel.font=[UIFont systemFontOfSize:14];
    }else{
        self.tixian1.titleLabel.font=[UIFont systemFontOfSize:15];
    }
    [self.tixian1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.tixian1 setTitle:NSLocalizedString(@"tixian_ac",nil) forState:UIControlStateNormal];
    [self.tixian1 setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    [self addSubview:self.tixian1];
    [self.tixian1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-50*WSCALE);
        make.centerY.mas_equalTo(_type1.mas_centerY);
    }];
    
    
    self.tixian2=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.tixian2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (iPhone4||iPhone5) {
        self.tixian2.titleLabel.font=[UIFont systemFontOfSize:14];
    }else{
        self.tixian2.titleLabel.font=[UIFont systemFontOfSize:15];
    }    [self.tixian2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.tixian2 setTitle:NSLocalizedString(@"tixian_ac",nil) forState:UIControlStateNormal];
    [self.tixian2 setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    [self addSubview:self.tixian2];
    [self.tixian2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-50*WSCALE);
        make.centerY.mas_equalTo(_type2.mas_centerY);
    }];
    
    self.tixian3=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.tixian3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (iPhone4||iPhone5) {
        self.tixian3.titleLabel.font=[UIFont systemFontOfSize:14];
    }else{
        self.tixian3.titleLabel.font=[UIFont systemFontOfSize:15];
    }
    [self.tixian3 setTitle:NSLocalizedString(@"tixian_ac",nil) forState:UIControlStateNormal];
    [self.tixian3 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.tixian3 setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    [self addSubview:self.tixian3];
    [self.tixian3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-50*WSCALE);
        make.centerY.mas_equalTo(_type3.mas_centerY);
    }];
    

    
    
    _moneyType1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cny"]];
    [self addSubview:_moneyType1];
    [_moneyType1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_tixian1.mas_left).offset(-12*WSCALE);
        make.centerY.mas_equalTo(_type1.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(34*WSCALE,32*HSCALE));
    }];
    
    _moneyType2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"usd"]];
    [self addSubview:_moneyType2];
    [_moneyType2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_tixian2.mas_left).offset(-12*WSCALE);
        make.centerY.mas_equalTo(_type2.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(34*WSCALE,32*HSCALE));
    }];
    
    _moneyType3=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jry"]];
    [self addSubview:_moneyType3];
    [_moneyType3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_tixian3.mas_left).offset(-12*WSCALE);
        make.centerY.mas_equalTo(_type3.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(34*WSCALE,32*HSCALE));
    }];
    
    
    _lineone=[[UIView alloc]init];
    _lineone.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [self addSubview:_lineone];
    [_lineone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(540*WSCALE, 1.5*HSCALE));
        make.left.mas_equalTo(50*WSCALE);
        make.top.mas_equalTo(_type1.mas_bottom).offset(50*HSCALE);
    }];
    
    _linetwo=[[UIView alloc]init];
    _linetwo.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [self addSubview:_linetwo];
    [_linetwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(540*WSCALE, 1.5*HSCALE));
        make.left.mas_equalTo(50*WSCALE);
        make.top.mas_equalTo(_type2.mas_bottom).offset(50*HSCALE);
    }];
    
    _linet=[[UIView alloc]init];
    _linet.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [self addSubview:_linet];
    [_linet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1.5*HSCALE));
        make.left.mas_equalTo(0*WSCALE);
        make.top.mas_equalTo(_type3.mas_bottom).offset(45*HSCALE);
    }];
    
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    dic=@{@"user_sn":[[NSUserDefaults standardUserDefaults] valueForKey:USER_SN]};
    
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"account/querymoney"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"account/querymoney" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            
            NSDictionary *info=[responseDic objectForKey:@"info"];
            NSArray *listArr=[info objectForKey:@"list"];
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            arr = [QuerymoneyModel objectArrayWithKeyValuesArray:listArr];
            
            for (int i=0; i<arr.count; i++) {
                QuerymoneyModel *model=arr[i];
                double m=model.money.doubleValue/100;
                if ([model.currency isEqualToString:@"USD"]) {
                    _moneyLable2.text=[NSString stringWithFormat:@"%.0f",m];
                }
                if ([model.currency isEqualToString:@"CNY"]) {
                    _moneyLable1.text=[NSString stringWithFormat:@"%.0f",m];
                }
                if ([model.currency isEqualToString:@"JPY"]) {
                    _moneyLable3.text=[NSString stringWithFormat:@"%.0f",m];
                }
            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];


    
}



//提现成功刷新页面
-(void)reloadUI{
    
    NSDictionary *dic=[[NSDictionary alloc]init];
    dic=@{@"user_sn":[[NSUserDefaults standardUserDefaults] valueForKey:USER_SN]};
    
    NSString *dateStr=[[DataProcessing sharedManager]nowTimestamp];
    NSString *sign=[[DataProcessing sharedManager]dataSignWithParam:dic url:@"account/querymoney"timeString:dateStr];
    [[httpManager sharedManager]httpWithURL:@"account/querymoney" method:GET param:dic timeString:dateStr sign:sign success:^(NSDictionary *responseDic) {
        
        NSInteger status=[[responseDic objectForKey:@"status"] integerValue];
        
        if (status==1){
            
            NSDictionary *info=[responseDic objectForKey:@"info"];
            NSArray *listArr=[info objectForKey:@"list"];
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            arr = [QuerymoneyModel objectArrayWithKeyValuesArray:listArr];
            
            for (int i=0; i<arr.count; i++) {
                QuerymoneyModel *model=arr[i];
                double m=model.money.doubleValue/100;

                if ([model.currency isEqualToString:@"USD"]) {
                    _moneyLable2.text=[NSString stringWithFormat:@"%.0f",m];
                }
                if ([model.currency isEqualToString:@"CNY"]) {
                    _moneyLable1.text=[NSString stringWithFormat:@"%.0f",m];
                }
                if ([model.currency isEqualToString:@"JPY"]) {
                    _moneyLable3.text=[NSString stringWithFormat:@"%.0f",m];
                }
            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];

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
