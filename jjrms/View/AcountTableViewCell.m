//
//  AcountTableViewCell.m
//  jjrms
//
//  Created by user on 16/10/20.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "AcountTableViewCell.h"

@implementation AcountTableViewCell
{

    UILabel *_acctont;
}

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

    
    _typeImage=[[UIImageView alloc]init];
    [weakSelf.contentView addSubview:_typeImage];
    [_typeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40*WSCALE, 40*HSCALE));
        make.left.mas_equalTo(50*WSCALE);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    _typeName=[[UILabel alloc]init];
    _typeName.textColor=[UIColor blackColor];
    _typeName.font=[UIFont systemFontOfSize:15];
    _typeName.textAlignment=NSTextAlignmentLeft;
    [weakSelf.contentView addSubview:_typeName];
    [_typeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_typeImage.mas_centerY);
        make.height.mas_equalTo(30*HSCALE);
        make.left.mas_equalTo(_typeImage.mas_right).offset(20*WSCALE);
    }];
    
    _acctont=[[UILabel alloc]init];
    _acctont.textColor=[UIColor colorWithHexString:@"#666666"];
    _acctont.font=[UIFont systemFontOfSize:15];
    _acctont.textAlignment=NSTextAlignmentRight;
    [weakSelf.contentView addSubview:_acctont];
    [_acctont mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_typeImage.mas_centerY);
        make.right.mas_equalTo(-50*WSCALE);
        make.left.mas_equalTo(_typeName.mas_right).offset(20*WSCALE);
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


- (void)setModel:(AccountsModel *)model{
    if ([model.pay_channel isEqualToString:@"PayPal"]) {
        _typeImage.image=[UIImage imageNamed:@"p"];
        _typeName.text=@"PayPal";
    }
    if ([model.pay_channel isEqualToString:@"AliPay"]) {
        _typeImage.image=[UIImage imageNamed:@"z"];
        _typeName.text=NSLocalizedString(@"zhifubao_ac",nil);
    }
    _acctont.text=model.pay_account;
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
