//
//  HomesTableViewCell.m
//  jjrms
//
//  Created by user on 2016/11/17.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import "HomesTableViewCell.h"

@implementation HomesTableViewCell
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
    [self.homeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(160*WSCALE, 120*HSCALE));
        make.right.mas_equalTo(-50*WSCALE);
        make.top.mas_equalTo(50*HSCALE);
    }];
    

    
    self.address=[[UILabel alloc]init];
    [self.contentView addSubview:self.address];
    self.address.numberOfLines=0;
    self.address.font=[UIFont systemFontOfSize:18];
    self.address.textColor=[UIColor colorWithHexString:@"#444444"];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(82*HSCALE);
        make.left.mas_equalTo(52*WSCALE);
        make.top.mas_equalTo(60*HSCALE);
        make.width.mas_equalTo(322*WSCALE);
    }];
    

    
    self.info=[[UILabel alloc]init];
    [self.contentView addSubview:self.info];
    self.info.font=[UIFont systemFontOfSize:13];
    self.info.textColor=[UIColor colorWithHexString:@"#777777"];
    [self.info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(26*HSCALE);
        make.left.mas_equalTo(52*WSCALE);
        make.top.mas_equalTo(self.address.mas_bottom).offset(28*HSCALE);
        make.width.mas_equalTo(332*WSCALE);
    }];
    
    

    
    self.homeTime=[[UILabel alloc]init];
    [self.contentView addSubview:self.homeTime];
    self.homeTime.font=[UIFont systemFontOfSize:15];
    self.homeTime.textColor=[UIColor colorWithHexString:@"#777777"];
    [self.homeTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30*HSCALE);
        make.left.mas_equalTo(52*WSCALE);
        make.top.mas_equalTo(_info.mas_bottom).offset(14*HSCALE);
        make.width.mas_equalTo(378*WSCALE);
    }];
    
    self.lineView=[[UIView alloc]init];
    self.lineView.backgroundColor=[UIColor colorWithHexString:@"#DDDDDD"];
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(2*HSCALE);
        make.left.mas_equalTo(50*WSCALE);
        make.right.mas_equalTo(-50*WSCALE);
        make.bottom.mas_equalTo(0*HSCALE);
    }];
}

- (void)setModel:(HomeSourceModel *)model{
    NSDictionary *dic=model.images[0];
    NSString *url=[dic objectForKey:@"url"];
    [self.homeImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"di"]];
    self.address.text=model.house_name;
    self.info.text=model.house_rooms_txt;

    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy/MM/dd"];//@"yyyy-MM-dd-HHMMss"
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[model.create_time doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    self.homeTime.text=[NSString stringWithFormat:@"%@·%@", dateString,model.status_txt];
   
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
