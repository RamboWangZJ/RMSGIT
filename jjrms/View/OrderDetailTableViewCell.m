//
//  OrderDetailTableViewCell.m
//  jjrms
//
//  Created by user on 16/10/8.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "OrderDetailTableViewCell.h"

@implementation OrderDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // cell页面布局
        [self initCell];
    }
    return self;
}


-(void)initCell{
    self.backgroundColor=[UIColor whiteColor];
    
    self.ota=[[UIImageView alloc]init];
    self.ota.clipsToBounds = YES;
    [self.ota.layer setCornerRadius:7];
    [self.contentView addSubview:self.ota];
    [self.ota mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(178*WSCALE, 100*HSCALE));
        make.left.mas_equalTo(56*WSCALE);
        make.top.mas_equalTo(44*HSCALE);
    }];
    
    self.detail=[[UILabel alloc]init];
    [self.contentView addSubview:self.detail];
    self.detail.textColor=[UIColor colorWithHexString:@"#666666"];
    self.detail.font=[UIFont systemFontOfSize:13];
    [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(26*HSCALE);
        make.left.mas_equalTo(300*WSCALE);
        make.height.mas_equalTo(28*HSCALE);
    }];self.detail.text=@"概况:";
    
    
    self.date=[[UILabel alloc]init];
    [self.contentView addSubview:self.date];
    self.date.textColor=[UIColor colorWithHexString:@"#666666"];
    self.date.font=[UIFont systemFontOfSize:13];
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detail.mas_bottom).offset(12*HSCALE);
        make.left.mas_equalTo(self.detail.mas_left);
        make.height.mas_equalTo(24*HSCALE);
    }];self.date.text=@"日期:";
    
    
    self.money=[[UILabel alloc]init];
    [self.contentView addSubview:self.money];
    self.money.textColor=[UIColor colorWithHexString:@"#666666"];
    self.money.font=[UIFont systemFontOfSize:13];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.date.mas_bottom).offset(16*HSCALE);
        make.left.mas_equalTo(self.detail.mas_left);
        make.height.mas_equalTo(28*HSCALE);
    }];self.money.text=NSLocalizedString(@"zonge_or",nil);
    
    self.moneyRed=[[UILabel alloc]init];
    self.moneyRed.textColor=[UIColor colorWithHexString:@"#ff5a46"];
    self.money.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.moneyRed];
    [self.moneyRed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.date.mas_bottom).offset(15*HSCALE);
        make.left.mas_equalTo(self.money.mas_right).offset(5*WSCALE);
        make.height.mas_equalTo(26*HSCALE);
    }];
    self.danwei=[[UILabel alloc]init];
    self.danwei.textColor=[UIColor colorWithHexString:@"#666666"];
    self.danwei.font=[UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.danwei];
    [self.danwei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.date.mas_bottom).offset(16*HSCALE);
        make.left.mas_equalTo(self.moneyRed.mas_right).offset(10*WSCALE);
        make.height.mas_equalTo(24*HSCALE);
    }];self.danwei.text=@"";
    
    
    self.name=[[UILabel alloc]init];
    [self.contentView addSubview:self.name];
    self.name.textColor=[UIColor colorWithHexString:@"#666666"];
    self.name.font=[UIFont systemFontOfSize:13];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.money.mas_bottom).offset(12*HSCALE);
        make.left.mas_equalTo(self.detail.mas_left);
        make.height.mas_equalTo(24*HSCALE);
    }];self.name.text=@"房客姓名:";
    
    self.tel=[[UILabel alloc]init];
    self.tel.textColor=[UIColor colorWithHexString:@"#666666"];
    self.tel.font=[UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.tel];
    [self.tel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.name.mas_bottom).offset(16*HSCALE);
        make.left.mas_equalTo(self.detail.mas_left);
        make.height.mas_equalTo(24*HSCALE);
    }];self.tel.text=NSLocalizedString(@"tel_or",nil);
    
    self.telBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.telBut addTarget:self action:@selector(telAction) forControlEvents:UIControlEventTouchUpInside];
    [self.telBut setTitleColor:[UIColor colorWithHexString:@"#64b8f0"] forState:UIControlStateNormal];
    [self.telBut setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    self.telBut.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.telBut];
    [self.telBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tel.mas_right).offset(5*WSCALE);
        make.top.mas_equalTo(self.name.mas_bottom).offset(15*HSCALE);
        make.height.mas_equalTo(26*HSCALE);
    }];
}

- (void)setModel:(OrderDetailModel *)model{
    [self.ota sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"logo"]];
    self.name.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"xingming_or",nil),model.ota_tenant_name];
    self.detail.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"gaikuang_or",nil),model.overview_txt];
    double money_dou=model.total_price.doubleValue/100;
    self.moneyRed.text=[NSString stringWithFormat:@"%.0f",money_dou];
    [self.telBut setTitle:[NSString stringWithFormat:@"%@",model.ota_tenant_phone] forState:UIControlStateNormal];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy.MM.dd"];//@"yyyy-MM-dd-HHMMss"
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[model.start_time doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    
    NSDate* date2 = [NSDate dateWithTimeIntervalSince1970:[model.end_time doubleValue]];
    NSString* dateString2 = [formatter stringFromDate:date2];
    self.date.text=[NSString stringWithFormat:@"%@%@-%@",NSLocalizedString(@"riqi_or",nil),dateString,dateString2];
    
    //self.danwei.text=model.price_unit;
    
    if ([model.price_unit isEqualToString:@"USD"]) {
        self.danwei.text=@"$";
    }
    if ([model.price_unit isEqualToString:@"CNY"]) {
        self.danwei.text=@"¥";
    }
    if ([model.price_unit isEqualToString:@"JPY"]) {
        self.danwei.text=@"¥";
    }
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
