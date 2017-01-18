//
//  OtherOrdersTableViewCell.m
//  jjrms
//
//  Created by user on 2016/11/17.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "OtherOrdersTableViewCell.h"

@implementation OtherOrdersTableViewCell
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
    __weak typeof(self) weakSelf = self;
    
    
    
    self.backgroundColor=[UIColor whiteColor];
    self.homeImg=[[UIImageView alloc]init];
    [self.contentView addSubview:self.homeImg];
    [self.homeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*WSCALE, 100*HSCALE));
        make.left.mas_equalTo(50*WSCALE);
        make.top.mas_equalTo(50*HSCALE);
    }];
    
    
    
    self.name=[[UILabel alloc]init];
    self.name.textColor=[UIColor colorWithHexString:@"#555555"];
    [self.name setFont:[UIFont fontWithName:CUTI size:16]];
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(32*HSCALE);
        make.left.mas_equalTo(weakSelf.homeImg.mas_right).offset(20*WSCALE);
        make.top.mas_equalTo(56*HSCALE);
    }];
    
    
    self.datefirst=[[UILabel alloc]init];
    self.datefirst.textColor=[UIColor colorWithHexString:@"#777777"];
    self.datefirst.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.datefirst];
    [self.datefirst mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(28*HSCALE);
        make.right.mas_equalTo(-54*WSCALE);
        make.centerY.mas_equalTo(weakSelf.name.mas_centerY);
    }];
    
    
    self.address=[[UILabel alloc]init];
    self.address.lineBreakMode=NSLineBreakByTruncatingTail;
    self.address.font=[UIFont systemFontOfSize:14];
    self.address.textColor=[UIColor colorWithHexString:@"#777777"];
    [self.contentView addSubview:self.address];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(28*HSCALE);
        make.left.mas_equalTo(weakSelf.name);
        make.top.mas_equalTo(weakSelf.name.mas_bottom).offset(16*HSCALE);
        make.width.mas_equalTo(412*WSCALE);
    }];
    
    self.datedetail=[[UILabel alloc]init];
    self.datedetail.lineBreakMode=NSLineBreakByTruncatingTail;
    self.datedetail.font=[UIFont systemFontOfSize:14];
    self.datedetail.textColor=[UIColor colorWithHexString:@"#777777"];
    [self.contentView addSubview:self.datedetail];
    [self.datedetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(28*HSCALE);
        make.left.mas_equalTo(weakSelf.name);
        make.top.mas_equalTo(weakSelf.address.mas_bottom).offset(16*HSCALE);
        make.width.mas_equalTo(412*WSCALE);
    }];
    
    
    self.info=[[UILabel alloc]init];
    self.info.lineBreakMode=NSLineBreakByTruncatingTail;
    self.info.font=[UIFont systemFontOfSize:14];
    self.info.textColor=[UIColor colorWithHexString:@"#777777"];
    [self.contentView addSubview:self.info];
    [self.info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(28*HSCALE);
        make.left.mas_equalTo(weakSelf.name);
        make.top.mas_equalTo(weakSelf.datedetail.mas_bottom).offset(16*HSCALE);
        make.width.mas_lessThanOrEqualTo(336*WSCALE);
    }];
    
    
    self.money=[[UILabel alloc]init];
    self.money.textColor=[UIColor colorWithHexString:@"#555555"];
    [self.money setFont:[UIFont fontWithName:CUTI size:14]];
    [self.contentView addSubview:self.money];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(28*HSCALE);
        make.centerY.mas_equalTo(weakSelf.info.mas_centerY);
        make.right.mas_equalTo(-50*WSCALE);
    }];
    
    self.lineView=[[UIView alloc]init];
    self.lineView.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(2*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
        make.right.mas_equalTo(-50*WSCALE);
        make.bottom.mas_equalTo(-2*HSCALE);
    }];
    
}


- (void)setModel:(OrderModel *)model{
    
    [self.homeImg sd_setImageWithURL:[NSURL URLWithString:model.tenant_avatar] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    self.name.text=model.ota_tenant_name;
    self.address.text=model.house_name;
    self.datedetail.text=model.rent_period_txt;
    self.info.text=model.rent_overview_txt;
    double money_dou=model.landlord_total_price.doubleValue/100;
    self.money.text=[NSString stringWithFormat:@"%@ %.0f",model.rental_unit,money_dou];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[model.create_time doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    self.datefirst.text=[NSString stringWithFormat:@"%@",dateString];
    
    
    switch ([model.order_status integerValue]) {
        case 100:
            self.name.text=[NSString stringWithFormat:@"%@ * %@",NSLocalizedString(@"daifukuan_ac",nil), model.ota_tenant_name];
            break;
        case 110:
            self.name.text=[NSString stringWithFormat:@"%@ * %@",NSLocalizedString(@"dairuzhu_ac",nil), model.ota_tenant_name];
            break;
        case 150:
            self.name.text=[NSString stringWithFormat:@"%@ * %@",NSLocalizedString(@"yiruzhu_ac",nil), model.ota_tenant_name];
            break;
        case 900:
            self.name.text=[NSString stringWithFormat:@"%@ * %@",NSLocalizedString(@"yiwancheng_ac",nil), model.ota_tenant_name];
            break;
        case 510:
            self.name.text=[NSString stringWithFormat:@"%@ * %@",NSLocalizedString(@"yezhuqvxiao_or",nil), model.ota_tenant_name];
            break;
        case 520:
            self.name.text=[NSString stringWithFormat:@"%@ * %@",NSLocalizedString(@"zukeqvxiao_or",nil), model.ota_tenant_name];
            break;

        default:
            break;
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
