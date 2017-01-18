//
//  ListTableViewCell.m
//  jjrms
//
//  Created by user on 16/10/21.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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

    
    _nameLB=[[UILabel alloc]init];
    _nameLB.textColor=[UIColor colorWithHexString:@"#555555"];
    _nameLB.font=[UIFont systemFontOfSize:15];
    _nameLB.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_nameLB];
    [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40*HSCALE);
        make.left.mas_equalTo(52*WSCALE);
    }];
    
    
    
    _resultLB=[[UILabel alloc]init];
    _resultLB.textColor=[UIColor colorWithHexString:@"#999999"];
    _resultLB.font=[UIFont systemFontOfSize:14];
    _resultLB.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_resultLB];
    [_resultLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-38*HSCALE);
        make.left.mas_equalTo(52*WSCALE);
    }];
    
    
    _numLB=[[UILabel alloc]init];
    _numLB.textColor=[UIColor colorWithHexString:@"#999999"];
    _numLB.font=[UIFont systemFontOfSize:14];
    _numLB.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:_numLB];
    [_numLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40*HSCALE);
        make.right.mas_equalTo(-57*WSCALE);
    }];
    
    _dateLB=[[UILabel alloc]init];
    _dateLB.textColor=[UIColor colorWithHexString:@"#999999"];
    _dateLB.font=[UIFont systemFontOfSize:14];
    _dateLB.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:_dateLB];
    [_dateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-40*HSCALE);
        make.right.mas_equalTo(-50*WSCALE);
    }];

}

- (void)setModel:(AccountListModel *)model{
    _nameLB.text=model.meta_val;
    _resultLB.text=model.currency;
    double money=[model.amount doubleValue];
    money=money/100;
    if (money>=0) {
        _numLB.textColor=[UIColor colorWithHexString:@"#FE7575"];
        _numLB.text=[NSString stringWithFormat:@"+%.0f",money];
    }else{
        _numLB.textColor=[UIColor colorWithHexString:@"#8CC82E"];
        _numLB.text=[NSString stringWithFormat:@"%.0f",money];
    }

    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy.MM.dd"];//@"yyyy-MM-dd-HHMMss"
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[model.create_time doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    _dateLB.text=dateString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
