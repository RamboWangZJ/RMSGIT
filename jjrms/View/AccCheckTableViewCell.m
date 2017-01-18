//
//  AccCheckTableViewCell.m
//  jjrms
//
//  Created by user on 16/10/21.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "AccCheckTableViewCell.h"

@implementation AccCheckTableViewCell

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
    __weak typeof(self) weakSelf = self;

    
    _typeName=[[UILabel alloc]init];
    _typeName.textColor=[UIColor colorWithHexString:@"#00A6A6"];
    _typeName.font=[UIFont systemFontOfSize:18];
    _typeName.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_typeName];
    [_typeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.left.mas_equalTo(60*WSCALE);
    }];
    
    _zhanghuLB=[[UILabel alloc]init];
    _zhanghuLB.textColor=[UIColor colorWithHexString:@"#666666"];
    _zhanghuLB.font=[UIFont systemFontOfSize:15];
    _zhanghuLB.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:_zhanghuLB];
    [_zhanghuLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_typeName.mas_centerY);
        make.right.mas_equalTo(-60*WSCALE);
    }];

    
    
}


- (void)setModel:(AccountsModel *)model{
    if ([model.pay_channel isEqualToString:@"PayPal"]) {
        _typeName.text=@"paypal";
    }
    if ([model.pay_channel isEqualToString:@"AliPay"]) {
        _typeName.text=@"支付宝";
    }
    _zhanghuLB.text=model.pay_account;
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
