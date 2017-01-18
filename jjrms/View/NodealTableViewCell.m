//
//  NodealTableViewCell.m
//  jjrms
//
//  Created by user on 16/10/9.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "NodealTableViewCell.h"

@implementation NodealTableViewCell
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
    
    self.checkBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.checkBut setImage:[UIImage imageNamed:@"guan"] forState:UIControlStateNormal];
    [self.checkBut setImage:[UIImage imageNamed:@"kai"] forState:UIControlStateSelected];
    [self.checkBut addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    //_open.tag=1003;
    [self.checkBut setSelected:YES];
    [self.contentView addSubview:self.checkBut];
    [self.checkBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(26*WSCALE, 26*HSCALE));
        make.top.mas_equalTo(56*HSCALE);
        make.left.mas_equalTo(26*WSCALE);
    }];
    
    
    self.ota=[[UIImageView alloc]init];
    self.ota.clipsToBounds = YES;
    [self.ota.layer setCornerRadius:7];
    [self.contentView addSubview:self.ota];
    [self.ota mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(192*WSCALE, 72*HSCALE));
        make.left.mas_equalTo(self.checkBut.mas_right).offset(26*WSCALE);
        make.top.mas_equalTo(40*HSCALE);
    }];
    
    self.detail=[[UILabel alloc]init];
    [self.contentView addSubview:self.detail];
    self.detail.textColor=[UIColor colorWithHexString:@"#666666"];
    self.detail.font=[UIFont systemFontOfSize:13];
    [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(26*HSCALE);
        make.left.mas_equalTo(296*WSCALE);
        make.height.mas_equalTo(28*HSCALE);
    }];self.detail.text=@"概况:";
    
    self.date=[[UILabel alloc]init];
    [self.contentView addSubview:self.date];
    self.date.textColor=[UIColor colorWithHexString:@"#666666"];
    self.date.font=[UIFont systemFontOfSize:13];
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detail.mas_bottom).offset(14*HSCALE);
        make.left.mas_equalTo(self.detail.mas_left);
        make.height.mas_equalTo(24*HSCALE);
    }];self.date.text=@"日期:";
    
    
    self.money=[[UILabel alloc]init];
    self.money.textColor=[UIColor colorWithHexString:@"#666666"];
    self.money.font=[UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.money];
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
 
}

-(void)butAction:(UIButton *)but{
    
    but.selected=!but.selected;

}


- (void)setModel:(OrderNoDealModel *)model{
    //self.ota.backgroundColor=[UIColor lightGrayColor];
    [self.ota sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"di"]];
    self.detail.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"gaikuang_or",nil),model.overview_txt];
    double money_dou=model.total_price.doubleValue/100;
    self.moneyRed.text=[NSString stringWithFormat:@"%.0f",money_dou];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy.MM.dd"];//@"yyyy-MM-dd-HHMMss"
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[model.start_time doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    NSDate* date2 = [NSDate dateWithTimeIntervalSince1970:[model.end_time doubleValue]];
    NSString* dateString2 = [formatter stringFromDate:date2];
    
    
    self.date.text=[NSString stringWithFormat:@"%@%@-%@",NSLocalizedString(@"riqi_or",nil),dateString,dateString2];
    
    if ([model.price_unit_symbol isEqualToString:@"USD"]) {
        self.danwei.text=@"$";
    }
    if ([model.price_unit_symbol isEqualToString:@"CNY"]) {
        self.danwei.text=@"¥";
    }
    if ([model.price_unit_symbol isEqualToString:@"JPY"]) {
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
