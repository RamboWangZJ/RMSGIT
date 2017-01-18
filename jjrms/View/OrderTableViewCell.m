//
//  OrderTableViewCell.m
//  jjrms
//
//  Created by user on 16/9/28.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

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
    self.homeImg=[[UIImageView alloc]init];
    [self.contentView addSubview:self.homeImg];
    self.homeImg.clipsToBounds = YES;
    [self.homeImg.layer setCornerRadius:7];
    [self.homeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180*WSCALE, 136*HSCALE));
        make.left.mas_equalTo(26*WSCALE);
        make.top.mas_equalTo(26*HSCALE);
    }];
    
    self.orderStates=[[UILabel alloc]init];
    self.orderStates.textColor=[UIColor whiteColor];
    self.orderStates.font=[UIFont systemFontOfSize:14];
    self.orderStates.textAlignment=NSTextAlignmentCenter;
    [self.homeImg addSubview:self.orderStates];
    [self.orderStates mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(36*HSCALE);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.homeImg.mas_width);
    }];
    self.orderStates.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.6];


    
    self.name=[[UILabel alloc]init];
    self.name.textColor=[UIColor colorWithHexString:@"#343b47"];
    self.name.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(26*HSCALE);
        make.left.mas_equalTo(self.homeImg.mas_right).offset(30*WSCALE);
        make.top.mas_equalTo(30*HSCALE);
        make.width.mas_equalTo(394*WSCALE);
        //make.right.mas_equalTo(200*WSCALE);
        //make.right.mas_equalTo(weakSelf.mas_right).offset(50*WSCALE);
    }];
    
    self.addressImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dizhi"]];
    [self.contentView addSubview:self.addressImg];
    [self.addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.homeImg.mas_right).offset(30*WSCALE);
        make.top.mas_equalTo(self.name.mas_bottom).offset(26*HSCALE);
        make.size.mas_equalTo(CGSizeMake(24*WSCALE,24*HSCALE));
    }];
    
    self.address=[[UILabel alloc]init];
    self.address.lineBreakMode=NSLineBreakByTruncatingTail;
    self.address.font=[UIFont systemFontOfSize:13];
    self.address.textColor=[UIColor colorWithHexString:@"#666666"];
    [self.contentView addSubview:self.address];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(24*HSCALE);
        make.left.mas_equalTo(self.addressImg.mas_right).offset(10*WSCALE);
        make.top.mas_equalTo(self.name.mas_bottom).offset(26*HSCALE);
        make.width.mas_equalTo(378*WSCALE);
    }];
    
    self.moneyLab=[[UILabel alloc]init];
    self.moneyLab.text=@"¥";
    self.moneyLab.textColor=[UIColor colorWithHexString:@"#ff5b45"];
    [self.contentView addSubview:self.moneyLab];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.homeImg.mas_right).offset(30*WSCALE);
        make.top.mas_equalTo(self.addressImg.mas_bottom).offset(26*HSCALE);
        make.size.mas_equalTo(CGSizeMake(24*WSCALE,24*HSCALE));
    }];
    
    self.money=[[UILabel alloc]init];
    self.money.textColor=[UIColor colorWithHexString:@"#ff5b45"];
    self.money.font=[UIFont systemFontOfSize:18];
    [self.contentView addSubview:self.money];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(36*HSCALE);
        make.left.mas_equalTo(self.moneyLab.mas_right).offset(10*WSCALE);
        make.centerY.mas_equalTo(self.moneyLab.mas_centerY);
        //make.bottom.mas_equalTo(weakSelf.mas_bottom).offset((-28)*HSCALE);
        make.right.mas_equalTo(100*WSCALE);
    }];
    
}

- (void)setModel:(OrderModel *)model{
    [self.homeImg sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"di"]];
    self.name.text=model.house_name;
    self.address.text=model.room_address;
    double money_dou=model.price.doubleValue/100;
    self.money.text=[NSString stringWithFormat:@"%.2f",money_dou];
    switch ([model.order_status integerValue]) {
        case 90:
            self.orderStates.text=NSLocalizedString(@"daiqueren_ac",nil);
            break;
        case 100:
            self.orderStates.text=NSLocalizedString(@"daifukuan_ac",nil);
            break;
        case 110:
            self.orderStates.text=NSLocalizedString(@"dairuzhu_ac",nil);
            break;
        case 150:
            self.orderStates.text=NSLocalizedString(@"yiruzhu_ac",nil);
            break;
        case 900:
            self.orderStates.text=NSLocalizedString(@"yiwancheng_ac",nil);
            break;
        default:
            break;
    }
    
    if ([model.price_unit isEqualToString:@"USD"]) {
        self.moneyLab.text=@"$";
    }
    if ([model.price_unit isEqualToString:@"CNY"]) {
        self.moneyLab.text=@"¥";
    }
    if ([model.price_unit isEqualToString:@"JPY"]) {
        self.moneyLab.text=@"¥";
    }
    //self.moneyLab.text=model.price_unit_symbol;//

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
